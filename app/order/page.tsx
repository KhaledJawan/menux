"use client";

import { useCart } from "@/components/cart-context";
import { menuItems, type MenuItem } from "@/lib/menu";
import categoriesData from "@/menuitems/categories.json";
import Image from "next/image";
import type { LucideIcon } from "lucide-react";
import { ArrowLeft, CupSoda, IceCream, Utensils, X } from "lucide-react";
import { useEffect, useMemo, useRef, useState } from "react";
import ChatOverlay from "@/components/chat-overlay";

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
  // UI state for tabs, category drilldown, modal, sizing, and notes
  const [activeTab, setActiveTab] = useState<"food" | "drink" | "other">(
    "drink"
  );
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [selectedItem, setSelectedItem] = useState<MenuItem | null>(null);
  const [selectedSize, setSelectedSize] = useState<string>("normal");
  const [note, setNote] = useState("");
  const [quantity, setQuantity] = useState(1);
  const { addItem } = useCart();
  const [cueIndex, setCueIndex] = useState<number | null>(() => {
    if (typeof window === "undefined") return null;
    const fromStarter = window.sessionStorage.getItem("fromStarterIntro");
    if (fromStarter) {
      window.sessionStorage.removeItem("fromStarterIntro");
      return 0;
    }
    return null;
  });
  const touchStart = useRef<{ x: number; y: number } | null>(null);
  const touchDelta = useRef<{ dx: number; dy: number }>({ dx: 0, dy: 0 });
  const pointerStart = useRef<{ x: number; y: number } | null>(null);
  const pointerDelta = useRef<{ dx: number; dy: number }>({ dx: 0, dy: 0 });
  const [dragOffset, setDragOffset] = useState(0);
  const scrollAreaRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (cueIndex === null) return;
    let idx = cueIndex;
    const interval = window.setInterval(() => {
      idx += 1;
      if (idx >= tabs.length) {
        setCueIndex(null);
        window.clearInterval(interval);
      } else {
        setCueIndex(idx);
      }
    }, 400);
    return () => window.clearInterval(interval);
  }, [cueIndex]);

  // Handle swipe gestures to switch tabs (left/right)
  const handleTouchStart = (e: React.TouchEvent<HTMLDivElement>) => {
    const t = e.touches[0];
    touchStart.current = { x: t.clientX, y: t.clientY };
    touchDelta.current = { dx: 0, dy: 0 };
    setDragOffset(0);
  };

  const handleTouchMove = (e: React.TouchEvent<HTMLDivElement>) => {
    if (!touchStart.current) return;
    const t = e.touches[0];
    touchDelta.current = {
      dx: t.clientX - touchStart.current.x,
      dy: t.clientY - touchStart.current.y,
    };
    if (Math.abs(touchDelta.current.dx) > Math.abs(touchDelta.current.dy)) {
      const limited = Math.max(-80, Math.min(80, touchDelta.current.dx));
      setDragOffset(limited);
    }
  };

  const handleTouchEnd = () => {
    if (!touchStart.current) return;
    const { dx, dy } = touchDelta.current;
    touchStart.current = null;
    setDragOffset(0);
    // Only horizontal, with a small vertical tolerance
    if (Math.abs(dx) < 20 || Math.abs(dx) <= Math.abs(dy)) return;
    const idx = tabs.findIndex((t) => t.id === activeTab);
    if (idx === -1) return;
    const nextIdx = dx < 0 ? idx + 1 : idx - 1;
    if (nextIdx < 0 || nextIdx >= tabs.length) return;
    setActiveTab(tabs[nextIdx].id);
    setSelectedCategory(null);
  };

  // Mouse/pen swipe handler for desktop users
  const handlePointerDown = (e: React.PointerEvent<HTMLDivElement>) => {
    pointerStart.current = { x: e.clientX, y: e.clientY };
    pointerDelta.current = { dx: 0, dy: 0 };
    setDragOffset(0);
  };

  const handlePointerMove = (e: React.PointerEvent<HTMLDivElement>) => {
    if (!pointerStart.current || e.pointerType === "touch") return;
    pointerDelta.current = {
      dx: e.clientX - pointerStart.current.x,
      dy: e.clientY - pointerStart.current.y,
    };
    if (Math.abs(pointerDelta.current.dx) > Math.abs(pointerDelta.current.dy)) {
      const limited = Math.max(-80, Math.min(80, pointerDelta.current.dx));
      setDragOffset(limited);
    }
  };

  const handlePointerUp = (e: React.PointerEvent<HTMLDivElement>) => {
    if (!pointerStart.current || e.pointerType === "touch") return;
    const { dx, dy } = pointerDelta.current;
    pointerStart.current = null;
    setDragOffset(0);
    if (Math.abs(dx) < 20 || Math.abs(dx) <= Math.abs(dy)) return;
    const idx = tabs.findIndex((t) => t.id === activeTab);
    if (idx === -1) return;
    const nextIdx = dx < 0 ? idx + 1 : idx - 1;
    if (nextIdx < 0 || nextIdx >= tabs.length) return;
    setActiveTab(tabs[nextIdx].id);
    setSelectedCategory(null);
  };

  // Structured categories by top-level tab
  const categoryItems = categoriesData as Record<
    "food" | "drink" | "other",
    { id: string; label: string; image: string }[]
  >;

  // Items filtered by selected top tab and chosen subcategory
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

  // Modal open handler
  const openItem = (item: MenuItem) => {
    setSelectedItem(item);
    setSelectedSize("normal");
    setNote("");
    setQuantity(1);
  };

  // Persist item(s) into cart with selected size and quantity
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

  const categoryCards = categoryItems[activeTab];

  // Always jump the scrollable grid back to the top when switching tab/category
  useEffect(() => {
    if (scrollAreaRef.current) {
      scrollAreaRef.current.scrollTo({ top: 0, behavior: "auto" });
    }
  }, [activeTab, selectedCategory]);

  return (
    <div className="flex h-full min-h-0 flex-col space-y-4 overflow-hidden">
      <header className="flex items-center gap-2">
        <h1 className="text-xl font-semibold text-foreground">Menux</h1>
        <div className="flex flex-1 justify-center">
          <span className="rounded-full bg-muted px-3 py-1 text-[11px] font-semibold text-foreground">
            Table 24
          </span>
        </div>
        <ChatOverlay />
      </header>

      <div
        className="flex w-full gap-2 overflow-x-auto text-xs"
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
        onPointerDown={handlePointerDown}
        onPointerMove={handlePointerMove}
        onPointerUp={handlePointerUp}
        style={{ touchAction: "pan-y" }}
      >
        {tabs.map((tab, idx) => {
          const isActive = activeTab === tab.id;
          const isCue = cueIndex === idx;
          const baseColor = isActive
            ? "bg-foreground font-semibold text-background"
            : "bg-muted text-foreground";
          const colorClass = isCue ? "bg-blue-500 text-white animate-pulse" : baseColor;
          return (
            <button
              key={tab.id}
              onClick={() => {
                setActiveTab(tab.id);
                setSelectedCategory(null);
              }}
              aria-label={tab.label}
              className={`flex h-[60px] min-w-[60px] items-center justify-center gap-2 whitespace-nowrap rounded-[14px] px-4 text-sm shadow-sm transition-all duration-300 ease-out ${
                isActive ? "flex-[1.4]" : "flex-none"
              } ${colorClass}`}
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

      {/* Subcategory bar with back button + centered label */}
      <div
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
        onPointerDown={handlePointerDown}
        onPointerMove={handlePointerMove}
        onPointerUp={handlePointerUp}
        style={{
          touchAction: "pan-y",
          transform: `translateX(${dragOffset}px)`,
          transition: dragOffset === 0 ? "transform 150ms ease-out" : "none",
        }}
        className="flex min-h-0 flex-1 flex-col"
      >
        {selectedCategory && (
          <div className="relative mb-2 flex items-center justify-center pb-2">
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

        {/* Category or item grid */}
        <section
          ref={scrollAreaRef}
          className="grid min-h-0 flex-1 grid-cols-2 gap-3 overflow-y-auto pb-4"
        >
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
                      €{" "}
                      {selectedItem?.id === item.id && selectedSize === "small"
                        ? (item.price * 0.75).toFixed(2)
                        : item.price.toFixed(2)}
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
      </div>

      {/* Item overlay */}
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
