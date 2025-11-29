"use client";

import BillButton from "@/components/bill-button";
import { menuItems, type MenuItem } from "@/lib/menu";
import { useCart } from "@/components/cart-context";
import Image from "next/image";
import { useMemo, useState } from "react";
import type { LucideIcon } from "lucide-react";
import { ArrowLeft, CupSoda, IceCream, Utensils, X } from "lucide-react";
import categoriesData from "@/menuitems/categories.json";

const tabs: {
  id: "food" | "drink" | "other";
  label: string;
  icon: LucideIcon;
}[] = [
  { id: "drink", label: "Drinks", icon: CupSoda },
  { id: "food", label: "Food", icon: Utensils },
  { id: "other", label: "Starters & Desserts", icon: IceCream },
];

export default function HomePage() {
  const [activeTab, setActiveTab] = useState<"food" | "drink" | "other">(
    "drink"
  );
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [selectedItem, setSelectedItem] = useState<MenuItem | null>(null);
  const [selectedSize, setSelectedSize] = useState<string>("normal");
  const [note, setNote] = useState("");
  const [quantity, setQuantity] = useState(1);
  const { addItem } = useCart();

  const categoryItems = categoriesData as Record<
    "food" | "drink" | "other",
    { id: string; label: string; image: string }[]
  >;

  const filtered = useMemo(() => {
    const base =
      activeTab === "other"
        ? menuItems.filter(
            (item) => item.category !== "drink" && item.category !== "food"
          )
        : menuItems.filter((item) => item.category === activeTab);
    if (!selectedCategory) return [];
    return base.filter((item) => item.categories?.includes(selectedCategory));
  }, [activeTab, selectedCategory]);

  const openItem = (item: MenuItem) => {
    setSelectedItem(item);
    setSelectedSize("normal");
    setNote("");
    setQuantity(1);
  };

  const handleAddToBasket = () => {
    if (!selectedItem) return;
    const price =
      selectedSize === "small" ? selectedItem.price * 0.75 : selectedItem.price;
    for (let i = 0; i < quantity; i += 1) {
      addItem({
        id: `${selectedItem.id}-${selectedSize}`,
        name: `${selectedItem.name} (${selectedSize})`,
        price,
      });
    }
    setSelectedItem(null);
  };

  const categoryCards = categoryItems[activeTab] ?? [];

  return (
    <div className="flex h-full min-h-0 flex-col space-y-4 overflow-hidden">
      <header className="flex items-start justify-between gap-2">
        <div>
          <p className="text-[11px] uppercase tracking-[0.2em] text-muted-foreground">
            Table 24
          </p>
          <h1 className="text-xl font-semibold text-foreground">Menux</h1>
          <p className="text-xs text-muted-foreground">
            Order food & drinks directly from your table.
          </p>
        </div>
        <BillButton />
      </header>

      <div className="flex w-full gap-2 overflow-x-auto text-xs">
        {tabs.map((tab) => {
          const isActive = activeTab === tab.id;
          return (
            <button
              key={tab.id}
              onClick={() => {
                setActiveTab(tab.id);
                setSelectedCategory(null);
              }}
              aria-label={tab.label}
              className={`flex h-[60px] min-w-[60px] items-center justify-center gap-2 whitespace-nowrap rounded-[14px] px-4 text-sm shadow-sm transition-all duration-300 ease-out ${
                isActive
                  ? "flex-[1.4] bg-foreground font-semibold text-background"
                  : "flex-none bg-muted text-foreground"
              }`}
              style={{
                width: isActive ? undefined : 60,
              }}
            >
              <tab.icon className="h-5 w-5" aria-hidden />
              {isActive ? <span className="truncate">{tab.label}</span> : null}
            </button>
          );
      })}
      </div>

      {selectedCategory && (
        <div className="relative flex items-center justify-center pb-1">
          <button
            onClick={() => setSelectedCategory(null)}
            className="absolute left-0 flex items-center gap-1 rounded-full bg-muted px-3 py-2 text-xs font-semibold text-foreground shadow-sm"
          >
            <ArrowLeft className="h-4 w-4" aria-hidden />
            Back
          </button>
          <span className="text-sm font-semibold text-foreground">
            {categoryCards.find((c) => c.id === selectedCategory)?.label}
          </span>
        </div>
      )}

      <section className="grid min-h-0 flex-1 grid-cols-2 gap-3 overflow-y-auto pb-4">
        {!selectedCategory &&
          categoryCards.map((cat) => (
            <article
              key={cat.id}
              className="flex h-full flex-col gap-2 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]"
              onClick={() => setSelectedCategory(cat.id)}
            >
              <div className="relative h-24 w-full overflow-hidden rounded-xl bg-muted">
                <Image
                  src={cat.image}
                  alt={cat.label}
                  fill
                  className="object-cover"
                  sizes="200px"
                />
              </div>
              <h2 className="text-sm font-semibold text-foreground">
                {cat.label}
              </h2>
            </article>
          ))}
        {selectedCategory &&
          filtered.map((item) => (
            <article
              key={item.id}
              className="flex h-full cursor-pointer flex-col gap-2 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]"
              onClick={() => openItem(item)}
            >
              <div className="relative h-24 w-full overflow-hidden rounded-xl bg-muted">
                {item.image ? (
                  <Image
                    src={item.image}
                    alt={item.name}
                    fill
                    className="object-cover"
                    sizes="200px"
                  />
                ) : null}
              </div>
              <div className="flex flex-1 flex-col gap-1">
                <h2 className="text-sm font-semibold text-foreground">
                  {item.name}
                </h2>
                <p className="text-[11px] text-muted-foreground">
                  {item.description}
                </p>
                <div className="flex items-center justify-between text-[11px]">
                  <p className="text-sm font-semibold text-primary">
                    € {item.price.toFixed(2)}
                  </p>
                  <span className="flex items-center gap-[2px] text-amber-400">
                    {Array.from({ length: 5 }).map((_, idx) => (
                      <span key={idx}>{idx < (item.rate ?? 0) ? "★" : "☆"}</span>
                    ))}
                  </span>
                </div>
              </div>
            </article>
          ))}
      </section>

      {selectedItem && (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 px-4 backdrop-blur">
          <div className="flex max-h-[90vh] w-full max-w-md flex-col overflow-hidden rounded-[28px] bg-card shadow-2xl">
            <div className="relative h-60 w-full">
              {selectedItem.image ? (
                <Image
                  src={selectedItem.image}
                  alt={selectedItem.name}
                  fill
                  className="object-cover"
                  sizes="400px"
                />
              ) : null}
              <button
                onClick={() => setSelectedItem(null)}
                className="absolute right-3 top-3 inline-flex h-9 w-9 items-center justify-center rounded-full bg-white/85 text-slate-900 shadow"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            <div className="flex flex-1 flex-col gap-4 overflow-y-auto bg-card px-5 pb-5 pt-4">
              <div className="flex items-start justify-between gap-3">
                <div className="space-y-1">
                  <h3 className="text-lg font-semibold text-foreground">
                    {selectedItem.name}
                  </h3>
                  <p className="text-sm font-semibold text-primary">
                    €{" "}
                    {(selectedSize === "small"
                      ? selectedItem.price * 0.75
                      : selectedItem.price
                    ).toFixed(2)}
                  </p>
                </div>
                <span className="flex items-center gap-[2px] rounded-full bg-muted px-2 py-1 text-[11px] font-medium text-amber-400">
                  {Array.from({ length: 5 }).map((_, idx) => (
                    <span key={idx}>{idx < (selectedItem.rate ?? 0) ? "★" : "☆"}</span>
                  ))}
                </span>
              </div>

              <p className="text-sm leading-relaxed text-muted-foreground">
                {selectedItem.description}
              </p>

              <div className="grid grid-cols-3 gap-2 text-sm">
                {(selectedItem.options ?? ["small", "normal"]).map((size) => {
                  const active = selectedSize === size;
                  return (
                    <button
                      key={size}
                      onClick={() => setSelectedSize(size)}
                      className={`rounded-2xl px-3 py-2 text-xs font-semibold transition ${
                        active
                          ? "bg-foreground text-background shadow-sm"
                          : "bg-muted text-foreground"
                      }`}
                    >
                      {size.charAt(0).toUpperCase() + size.slice(1)}
                    </button>
                  );
                })}
              </div>

              <div className="space-y-2">
                <label className="text-xs font-semibold text-foreground">
                  Comment
                </label>
                <textarea
                  value={note}
                  onChange={(e) => setNote(e.target.value)}
                  className="h-24 w-full rounded-2xl border border-border bg-input-background px-3 py-2 text-sm text-foreground outline-none"
                  placeholder="Add special instructions..."
                />
              </div>

              <div className="flex items-center gap-3">
                <div className="grid h-11 flex-[0.9] grid-cols-3 items-center rounded-[16px] bg-muted text-sm text-foreground shadow-sm">
                  <button
                    onClick={() => setQuantity((q) => Math.max(1, q - 1))}
                    className="flex items-center justify-center text-lg"
                  >
                    -
                  </button>
                  <span className="text-center font-semibold">{quantity}</span>
                  <button
                    onClick={() => setQuantity((q) => q + 1)}
                    className="flex items-center justify-center text-lg"
                  >
                    +
                  </button>
                </div>
                <button
                  onClick={handleAddToBasket}
                  className="flex h-11 flex-[1.4] items-center justify-center gap-2 rounded-[16px] bg-foreground px-3 text-sm font-semibold text-background shadow-sm transition hover:bg-foreground/90"
                >
                  <span>Add to basket</span>
                  <span className="text-xs opacity-90">
                    €{" "}
                    {(
                      (selectedSize === "small"
                        ? selectedItem.price * 0.75
                        : selectedItem.price) * quantity
                    ).toFixed(2)}
                  </span>
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
