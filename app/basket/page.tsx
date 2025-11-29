"use client";

import { useCart } from "@/components/cart-context";
import { useState } from "react";

export default function BasketPage() {
  const {
    items,
    orderedItems,
    updateQuantity,
    removeItem,
    total,
    clearCart,
    placeOrder,
  } = useCart();
  const [activeTab, setActiveTab] = useState<"order" | "payment">("order");

  const orderDisabled = items.length === 0;
  const paymentDisabled = orderedItems.length === 0;
  const tabItems = activeTab === "order" ? items : orderedItems;
  const tabTotal =
    activeTab === "order"
      ? total
      : orderedItems.reduce((sum, i) => sum + i.price * i.quantity, 0);

  const handlePlaceOrder = () => {
    if (orderDisabled) return;
    placeOrder();
    setActiveTab("payment");
  };

  return (
    <div className="fixed inset-0 z-30 flex items-center justify-center bg-black/70 px-4 backdrop-blur">
      <div className="flex max-h-[90vh] w-full max-w-md flex-col overflow-hidden rounded-[28px] bg-card shadow-2xl">
        <div className="flex items-start justify-between gap-2 px-5 pt-4">
          <div>
            <h1 className="text-xl font-semibold text-foreground">Orders</h1>
            <p className="text-xs text-muted-foreground">
              Review items and proceed to payment.
            </p>
          </div>
          <button className="inline-flex h-10 items-center justify-center rounded-full bg-black px-4 text-[11px] font-semibold text-white shadow-sm transition hover:bg-black/80">
            Payment options
          </button>
        </div>

        <div className="flex w-full gap-2 px-5 pt-3 text-xs">
          {[
            { id: "order", label: "Order", icon: "🛒" },
            { id: "payment", label: "Payment", icon: "💳" },
          ].map((tab) => {
            const active = activeTab === tab.id;
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as "order" | "payment")}
                className={`flex h-[60px] min-w-[60px] flex-1 items-center justify-center gap-2 rounded-[14px] px-4 text-sm font-semibold shadow-sm transition ${
                  active
                    ? "bg-foreground text-background"
                    : "bg-muted text-foreground"
                }`}
              >
                <span>{tab.icon}</span>
                <span>{tab.label}</span>
              </button>
            );
          })}
        </div>

        <div className="flex-1 space-y-3 overflow-y-auto px-5 py-4">
          {tabItems.length === 0 && (
            <p className="text-xs text-muted-foreground">
              {activeTab === "order"
                ? "Your basket is empty."
                : "No orders placed yet."}
            </p>
          )}
          {tabItems.map((item) => (
            <article
              key={item.id}
              className="flex items-center justify-between rounded-2xl border border-border bg-card px-3 py-2 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]"
            >
              <div className="flex-1">
                <p className="text-sm font-semibold text-foreground">{item.name}</p>
                <p className="text-[11px] text-muted-foreground">
                  € {item.price.toFixed(2)} each
                </p>
              </div>
              {activeTab === "order" ? (
                <div className="flex items-center gap-2">
                  <button
                    onClick={() =>
                      updateQuantity(item.id, Math.max(0, item.quantity - 1))
                    }
                    className="flex h-6 w-6 items-center justify-center rounded-full bg-muted text-xs text-foreground"
                  >
                    -
                  </button>
                  <span className="w-6 text-center text-xs text-foreground">
                    {item.quantity}
                  </span>
                  <button
                    onClick={() => updateQuantity(item.id, item.quantity + 1)}
                    className="flex h-6 w-6 items-center justify-center rounded-full bg-primary text-xs font-semibold text-primary-foreground"
                  >
                    +
                  </button>
                  <button
                    onClick={() => removeItem(item.id)}
                    className="text-[11px] text-muted-foreground hover:text-destructive"
                  >
                    Remove
                  </button>
                </div>
              ) : (
                <span className="text-xs font-semibold text-primary">
                  x{item.quantity}
                </span>
              )}
            </article>
          ))}
        </div>

        <div className="space-y-3 border-t border-border px-5 pb-5 pt-3">
          <div className="flex items-center justify-between text-sm">
            <span className="text-xs text-muted-foreground">Total</span>
            <span className="text-sm font-semibold text-primary">
              € {tabTotal.toFixed(2)}
            </span>
          </div>
          {activeTab === "order" ? (
            <button
              onClick={handlePlaceOrder}
              disabled={orderDisabled}
              className={`w-full rounded-full py-2 text-xs font-semibold shadow-sm transition ${
                orderDisabled
                  ? "bg-muted text-muted-foreground"
                  : "bg-primary text-primary-foreground hover:bg-primary/90"
              }`}
            >
              Order now
            </button>
          ) : (
            <button
              disabled={paymentDisabled}
              className={`w-full rounded-full py-2 text-xs font-semibold shadow-sm transition ${
                paymentDisabled
                  ? "bg-muted text-muted-foreground"
                  : "bg-primary text-primary-foreground hover:bg-primary/90"
              }`}
            >
              Pay now
            </button>
          )}
          {activeTab === "order" && (
            <button
              onClick={clearCart}
              className="w-full rounded-full border border-border py-2 text-[11px] font-medium text-muted-foreground hover:border-destructive hover:text-destructive"
            >
              Clear basket
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
