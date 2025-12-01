/* eslint-disable @typescript-eslint/no-require-imports */
/**
 * Fetch photos from Unsplash for menuitems files (drinks/foods/others) that are missing photos.
 * - Requires UNSPLASH_ACCESS_KEY in .env.local (not committed).
 * - Only fills missing photos (images.unsplash.com), never overwrites existing photos.
 * - Works directly on menuitems/drinks|foods|others.
 *
 * Usage:
 *   node scripts/fetch-photos.js
 */

const fs = require("fs");
const path = require("path");

// Load .env.local manually (do not commit your key)
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
    console.warn(`Unsplash error ${res.status} for "${query}"`);
    return null;
  }
  const data = await res.json();
  const hit = data.results?.[0];
  return hit?.urls?.small ?? hit?.urls?.regular ?? null;
}

async function fillMenuItems() {
  const files = ["menuitems/drinks.json", "menuitems/foods.json", "menuitems/others.json"];
  for (const file of files) {
    const full = path.join(process.cwd(), file);
    const data = JSON.parse(fs.readFileSync(full, "utf8"));
    let changed = false;
    for (const item of data) {
      if (Array.isArray(item.photos) && item.photos.length > 0) continue; // keep existing
      const query = item.name || "food";
      const link = await fetchPhoto(query);
      if (link) {
        item.photos = [link];
        changed = true;
        console.log(`Added photo for "${item.name}"`);
      } else {
        console.warn(`No photo for "${item.name}"`);
      }
      await sleep(250); // throttle
    }
    if (changed) {
      fs.writeFileSync(full, JSON.stringify(data, null, 2));
      console.log(`Updated ${file}`);
    } else {
      console.log(`No changes to ${file}`);
    }
  }
}

async function main() {
  await fillMenuItems();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
