import drinksData from "@/menuitems/drinks.json";
import foodsData from "@/menuitems/foods.json";
import othersData from "@/menuitems/others.json";

export type Category = "food" | "drink" | "other";

type RawMenuItem = {
  id: string;
  name: string;
  description: string;
  hiddenDescription?: string;
  price: number;
  photos?: string[];
  rate?: number;
  hot?: boolean;
};

export type MenuItem = RawMenuItem & {
  category: Category;
  image?: string;
};

const mapItems = (data: RawMenuItem[], category: Category): MenuItem[] =>
  data.map((item) => ({
    ...item,
    category,
    image: item.photos?.[0],
  }));

export const menuItems: MenuItem[] = [
  ...mapItems(drinksData, "drink"),
  ...mapItems(foodsData, "food"),
  ...mapItems(othersData, "other"),
];
