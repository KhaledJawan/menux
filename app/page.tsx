"use client";

import BillButton from "@/components/bill-button";
import { menuItems } from "@/lib/menu";
import { useCart } from "@/components/cart-context";
import Image from "next/image";
import { useState } from "react";

const tabs: {
  id: "food" | "drink" | "other";
  label: string;
  icon: string;
}[] = [
  { id: "drink", label: "Drinks", icon: "🥤" },
  { id: "food", label: "Food", icon: "🍽️" },
  { id: "other", label: "Others", icon: "🎁" },
];

export default function HomePage() {
  const [activeTab, setActiveTab] = useState<"food" | "drink" | "other">(
    "drink"
  );
  const { addItem } = useCart();

  const filtered =
    activeTab === "other"
      ? menuItems.filter((item) => item.category !== "drink" && item.category !== "food")
      : menuItems.filter((item) => item.category === activeTab);

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
              onClick={() => setActiveTab(tab.id)}
              aria-label={tab.label}
              className={`flex h-[60px] min-w-[60px] items-center justify-center gap-2 whitespace-nowrap rounded-[14px] px-4 text-sm shadow-sm transition ${
                isActive
                  ? "flex-1 bg-foreground font-semibold text-background"
                  : "flex-none bg-muted text-foreground"
              }`}
            >
              <span className="text-base">{tab.icon}</span>
              {isActive ? <span className="truncate">{tab.label}</span> : null}
            </button>
          );
        })}
      </div>

      <section className="grid min-h-0 flex-1 grid-cols-2 gap-3 overflow-y-auto pb-4">
        {filtered.map((item) => (
          <article
            key={item.id}
            className="flex h-full flex-col gap-2 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]"
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
            <button
              onClick={() =>
                addItem({
                  id: item.id,
                  name: item.name,
                  price: item.price,
                })
              }
              className="mt-auto w-full rounded-full bg-primary px-4 py-2 text-[11px] font-semibold text-primary-foreground shadow-sm transition hover:bg-primary/90"
            >
              Add
            </button>
          </article>
        ))}
      </section>
    </div>
  );
}
