/* eslint-disable @typescript-eslint/no-require-imports */
/**
 * Fetch photos from Unsplash for entries in pics.json and propagate to menuitems.
 * Usage:
 *   node scripts/fetch-photos.js
 *
 * Behavior:
 * - Reads .env.local for UNSPLASH_ACCESS_KEY (not committed).
 * - Iterates menuitems/pics.json; if `link` is empty, fetches a photo by `name` and stores the URL.
 * - After updating pics.json, it updates menuitems (drinks/foods/others) photos by matching originalName.
 */

const fs = require("fs");
const path = require("path");

// Manual .env.local loader
const envPath = path.join(process.cwd(), ".env.local");
if (fs.existsSync(envPath)) {
  const lines = fs.readFileSync(envPath, "utf8").split("\n");
  for (const line of lines) {
    const m = line.match(/^\s*([^=#]+)\s*=\s*(.*)\s*$/);
    if (m) process.env[m[1]] = m[2];
  }
}

const ACCESS_KEY = process.env.UNSPLASH_ACCESS_KEY;
if (!ACCESS_KEY) {
  console.error("Set UNSPLASH_ACCESS_KEY in .env.local before running this script.");
  process.exit(1);
}

const UNSPLASH_URL = (q) =>
  `https://api.unsplash.com/search/photos?query=${encodeURIComponent(
    q
  )}&client_id=${ACCESS_KEY}&per_page=1`;

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function fetchPhoto(query) {
  const res = await fetch(UNSPLASH_URL(query));
  if (!res.ok) {
    if (res.status === 401 || res.status === 403) {
      console.warn(`Unsplash auth/rate-limit error (${res.status}) for "${query}"`);
      return null;
    }
    console.warn(`Unsplash error ${res.status} for "${query}"`);
    return null;
  }
  const data = await res.json();
  const hit = data.results?.[0];
  return hit?.urls?.small ?? hit?.urls?.regular ?? null;
}

async function updatePics() {
  const picsPath = path.join(process.cwd(), "menuitems/pics.json");
  const pics = JSON.parse(fs.readFileSync(picsPath, "utf8"));
  let changed = false;

  for (const entry of pics) {
    if (entry.link) continue; // already has a link
    if (entry.type !== "item") continue; // skip categories

    // Build a more descriptive query to improve matches
    const query = `${entry.name} ${entry.group}`.trim();
    const photo = await fetchPhoto(query);
    if (photo) {
      entry.link = photo;
      changed = true;
      console.log(`Added link for "${entry.name}"`);
    } else {
      console.log(`No photo found for "${entry.name}"`);
    }
    // Gentle throttle to avoid rate limiting
    await sleep(800);
  }

  if (changed) {
    fs.writeFileSync(picsPath, JSON.stringify(pics, null, 2));
    console.log("Updated menuitems/pics.json");
  } else {
    console.log("No changes to pics.json");
  }

  return pics;
}

function propagateToMenuItems(pics) {
  const files = [
    { path: "menuitems/drinks.json", group: "drink" },
    { path: "menuitems/foods.json", group: "food" },
    { path: "menuitems/others.json", group: "other" },
  ];

  const map = new Map();
  pics.forEach((p) => {
    if (p.type === "item" && p.link) {
      map.set(p.originalName, p.link);
    }
  });

  for (const file of files) {
    const fullPath = path.join(process.cwd(), file.path);
    const data = JSON.parse(fs.readFileSync(fullPath, "utf8"));
    let changed = false;
    data.forEach((item) => {
      const link = map.get(item.name);
      if (link) {
        item.photos = [link];
        changed = true;
      }
    });
    if (changed) {
      fs.writeFileSync(fullPath, JSON.stringify(data, null, 2));
      console.log(`Updated ${file.path}`);
    }
  }
}

async function main() {
  const pics = await updatePics();
  propagateToMenuItems(pics);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
