"use client";

import BillButton from "@/components/bill-button";
import { menuItems } from "@/lib/menu";
import { useCart } from "@/components/cart-context";
import Image from "next/image";

export default function HotPage() {
  const { addItem } = useCart();
  const hotItems = menuItems.filter((i) => i.hot);

  return (
    <div className="space-y-4">
      <header className="flex items-start justify-between gap-2">
        <div>
          <p className="text-[11px] uppercase tracking-[0.2em] text-muted-foreground">
            Highlights
          </p>
          <h1 className="text-xl font-semibold text-foreground">
            Hot & Popular
          </h1>
          <p className="text-xs text-muted-foreground">
            Most ordered and recommended items.
          </p>
        </div>
        <BillButton />
      </header>

      <section className="grid grid-cols-2 gap-3 pb-4">
        {hotItems.map((item) => (
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
                  sizes="200px"
                  className="object-cover"
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
              <span className="inline-flex rounded-full bg-secondary px-2 py-[2px] text-[10px] font-medium text-secondary-foreground">
                Most ordered
              </span>
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
