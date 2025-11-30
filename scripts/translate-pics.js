/* eslint-disable @typescript-eslint/no-require-imports */
/**
 * Translate names in menuitems to English-friendly names and rewrite pics.json.
 * Usage: node scripts/translate-pics.js
 */

const fs = require("fs");

const cats = JSON.parse(fs.readFileSync("menuitems/categories.json", "utf8"));
const drinks = JSON.parse(fs.readFileSync("menuitems/drinks.json", "utf8"));
const foods = JSON.parse(fs.readFileSync("menuitems/foods.json", "utf8"));
const others = JSON.parse(fs.readFileSync("menuitems/others.json", "utf8"));

const dict = {
  kalte: "Cold",
  warme: "Hot",
  getranke: "Drinks",
  getränke: "Drinks",
  alkoholfreie: "Non-alcoholic",
  alkoholfrei: "Non-alcoholic",
  bier: "Beer",
  fass: "Draft",
  flasche: "Bottle",
  spezialbier: "Special Beer",
  wein: "Wine",
  weisswein: "White Wine",
  weißwein: "White Wine",
  rotwein: "Red Wine",
  rose: "Rose",
  sekt: "Sparkling",
  aperitifs: "Aperitifs",
  spirituosen: "Spirits",
  vorspeisen: "Appetizers",
  salate: "Salads",
  pasta: "Pasta",
  fleischgerichte: "Meat Dishes",
  fischgerichte: "Fish Dishes",
  vegetarisch: "Vegetarian",
  vegan: "Vegan",
  beilagen: "Sides",
  desserts: "Desserts",
  kindergerichte: "Kids Menu",
  nachspeisen: "Desserts",
  eis: "Ice Cream",
  kuchen: "Cake",
  wasser: "Water",
  sprudelnd: "Sparkling",
  sprudel: "Sparkling",
  still: "Still",
  zitrone: "Lemon",
  pfirsich: "Peach",
  apfel: "Apple",
  saft: "Juice",
  schorle: "Spritzer",
  eistee: "Iced Tea",
  malzbier: "Malt Beer",
  hausgemachte: "Homemade",
  limonade: "Lemonade",
  pils: "Pilsner",
  helles: "Lager",
  weissbier: "Wheat Beer",
  weizenbier: "Wheat Beer",
  kölsch: "Kolsch",
  koelsch: "Kolsch",
  altbier: "Altbier",
  dunkles: "Dark",
  radler: "Shandy",
  diesel: "Beer Cola Mix",
  schwarzbier: "Black Beer",
  grauburgunder: "Pinot Gris",
  weissburgunder: "Pinot Blanc",
  weißburgunder: "Pinot Blanc",
  spaetburgunder: "Pinot Noir",
  spätburgunder: "Pinot Noir",
  prosecco: "Prosecco",
  aperol: "Aperol",
  hugo: "Hugo",
  campari: "Campari",
  jagermeister: "Jaegermeister",
  jägemeister: "Jaegermeister",
  obstler: "Fruit Schnapps",
  lachs: "Salmon",
  schnitzel: "Schnitzel",
  wiener: "Viennese",
  bratwurst: "Grilled Sausage",
  currywurst: "Curry Sausage",
  fisch: "Fish",
  garnelen: "Shrimp",
  gemuse: "Vegetable",
  gemüse: "Vegetable",
  kase: "Cheese",
  käse: "Cheese",
  kartoffel: "Potato",
  knodel: "Dumpling",
  knödel: "Dumpling",
  pommes: "Fries",
  bratkartoffeln: "Fried Potatoes",
  suppe: "Soup",
  tag: "Day",
  tomatensuppe: "Tomato Soup",
  kurbis: "Pumpkin",
  kürbis: "Pumpkin",
  minestrone: "Minestrone",
  gruner: "Green",
  grüner: "Green",
  gemischter: "Mixed",
  thunfisch: "Tuna",
  bauernsalat: "Farmer Salad",
  mozzarella: "Mozzarella",
  avocado: "Avocado",
  funghi: "Mushroom",
  tonno: "Tuna",
  hawaii: "Hawaiian",
  prosciutto: "Prosciutto",
  quattro: "Four",
  formaggi: "Cheese",
  diavolo: "Spicy",
  pepperoni: "Pepperoni",
  bolognese: "Bolognese",
  carbonara: "Carbonara",
  arrabiata: "Arrabiata",
  panna: "Cream",
  spaetzle: "Spaetzle",
  spätzle: "Spaetzle",
  suesskartoffel: "Sweet Potato",
  süßkartoffel: "Sweet Potato",
  creme: "Creme",
  brulee: "Brulee",
  obstsalat: "Fruit Salad",
};

const normalize = (s) => s.normalize("NFKD").replace(/[^\w\s/+-]/g, "");

const translate = (name) => {
  const base = normalize(name);
  const parts = base.split(/(\s+|\/|−|-|\+)/);
  const translated = parts
    .map((p) => {
      const key = p.toLowerCase();
      if (dict[key]) return dict[key];
      return p;
    })
    .join(" ")
    .replace(/\s+/g, " ")
    .trim();
  return translated || name;
};

// Reduce to a single keyword (e.g., "Homemade Lemonade" -> "Lemonade")
const toSingleKeyword = (translated) => {
  const stop = new Set(["and", "in", "of", "with", "&", "the", "a", "an", "to"]);
  const words = translated.split(/\s+/).filter(Boolean);
  for (let i = words.length - 1; i >= 0; i--) {
    const w = words[i].toLowerCase();
    if (!stop.has(w)) {
      return words[i].charAt(0).toUpperCase() + words[i].slice(1);
    }
  }
  return translated.split(/\s+/)[0] || translated;
};

const slug = (s) => normalize(s).replace(/[^a-zA-Z0-9]+/g, "").toLowerCase();
const makeId = (prefix, name, counter) =>
  `${prefix}${slug(name).slice(0, 6)}${String(counter).padStart(3, "0")}`;

let counter = 1;
const pics = [];

for (const [group, arr] of Object.entries(cats)) {
  for (const cat of arr) {
    pics.push({
      id: makeId("cat", cat.label, counter++),
      name: toSingleKeyword(translate(cat.label)),
      originalName: cat.label,
      type: "category",
      group,
      link: "",
    });
  }
}

for (const [group, data] of [
  ["drink", drinks],
  ["food", foods],
  ["other", others],
]) {
  for (const item of data) {
    pics.push({
      id: makeId(group === "drink" ? "itm" : group === "food" ? "itf" : "ito", item.name, counter++),
      name: toSingleKeyword(translate(item.name)),
      originalName: item.name,
      type: "item",
      group,
      link: "",
    });
  }
}

fs.writeFileSync("menuitems/pics.json", JSON.stringify(pics, null, 2));
console.log("pics entries", pics.length);
