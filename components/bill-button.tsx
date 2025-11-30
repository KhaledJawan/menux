"use client";

import { useMemo, useState } from "react";
import Image from "next/image";
import { useCart } from "./cart-context";

export default function BillButton() {
  // Local UI state for overlay
  const [open, setOpen] = useState(false);
  const [activeTab, setActiveTab] = useState<"order" | "payment">("order");
  const {
    items,
    orderedItems,
    updateQuantity,
    removeItem,
    total,
    placeOrder,
    clearCart,
    markPaid,
  } = useCart();
  const [paidMessage, setPaidMessage] = useState("");

  // Total count of items across basket + ordered for badge display
  const totalCount = useMemo(
    () =>
      [...items, ...orderedItems].reduce(
        (sum, item) => sum + (item.quantity || 0),
        0
      ),
    [items, orderedItems]
  );

  // Derived flags for disabling actions
  const orderDisabled = items.length === 0;
  const paymentDisabled = orderedItems.length === 0;
  const hasPaymentCue = orderedItems.length > 0;
  const tabItems = activeTab === "order" ? items : orderedItems;
  const tabTotal =
    activeTab === "order"
      ? total
      : orderedItems.reduce((sum, i) => sum + i.price * i.quantity, 0);

  const handlePlaceOrder = () => {
    if (orderDisabled) return;
    placeOrder();
    // Stay on order tab; payment tab will pulse to draw attention.
  };

  const handlePayment = () => {
    if (paymentDisabled) return;
    markPaid();
    setPaidMessage("Payment successful. Thank you for your payment.");
    setTimeout(() => setPaidMessage(""), 2500);
  };

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        id="bill_btn"
        className="relative inline-flex h-10 w-10 items-center justify-center rounded-full bg-black text-xs font-semibold text-white shadow-sm transition hover:bg-black/80"
        aria-label="Bill"
      >
        <Image
          src="/icons/bold/receipt-disscount.svg"
          alt="Bill"
          width={20}
          height={20}
          className="h-5 w-5 invert"
          priority
        />
        {totalCount > 0 && (
          <span className="pointer-events-none absolute bottom-0 left-0 inline-flex h-5 min-w-[18px] -translate-x-1/2 translate-y-1/2 items-center justify-center rounded-full bg-red-500 px-[6px] text-[10px] font-bold leading-none text-white shadow ring-2 ring-card">
            {totalCount > 99 ? "99+" : totalCount}
          </span>
        )}
      </button>

      {open && (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 px-4 backdrop-blur">
          <div className="flex max-h-[90vh] w-full max-w-md flex-col overflow-hidden rounded-[28px] bg-card shadow-2xl">
            <div className="flex items-start justify-between gap-2 px-5 pt-4">
              <div>
                <h2 className="text-lg font-semibold text-foreground">Orders</h2>
                <p className="text-xs text-muted-foreground">
                  Review items and proceed to payment.
                </p>
              </div>
              <button
                onClick={() => setOpen(false)}
                className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-black/80 text-xs font-semibold text-white shadow-sm transition hover:bg-black"
              >
                ✕
              </button>
            </div>

            <div className="flex w-full gap-2 px-5 pt-3 text-xs">
            {[
              {
                id: "order",
                label: "Order",
                icon: "/icons/bold/bag-happy.svg",
              },
              {
                id: "payment",
                label: "Payment",
                icon: "/icons/bold/receipt-text.svg",
              },
            ].map((tab) => {
              const active = activeTab === tab.id;
              const cue = tab.id === "payment" && hasPaymentCue;
              const iconStyle =
                active && !cue
                  ? undefined
                  : cue && !active
                    ? {
                        filter:
                          "invert(39%) sepia(73%) saturate(2281%) hue-rotate(191deg) brightness(93%) contrast(98%)",
                      }
                    : undefined;
              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id as "order" | "payment")}
                  className={`flex h-[60px] min-w-[60px] flex-1 items-center justify-center gap-2 rounded-[14px] px-4 text-sm font-semibold shadow-sm transition ${
                    active
                      ? "bg-foreground text-background"
                    : cue
                        ? "bg-muted text-blue-600 ring-2 ring-blue-500 animate-pulse"
                      : "bg-muted text-foreground"
                  }`}
                >
                  <Image
                    src={tab.icon}
                    alt={tab.label}
                    width={20}
                    height={20}
                    className={`h-5 w-5 ${active ? "invert" : ""}`}
                    style={iconStyle}
                  />
                  <span>{tab.label}</span>
                </button>
              );
            })}
            </div>

            <div className="flex-1 space-y-3 overflow-y-auto px-5 py-4">
              {activeTab === "payment" && orderedItems.length > 0 && (
                <p className="text-[11px] text-muted-foreground">
                  Your order is received. You can pay anytime before you leave—no rush if you want to add more.
                </p>
              )}
              {activeTab === "payment" && orderedItems.length > 0 && (
                <h3 className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
                  Order history
                </h3>
              )}
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
                    <p className="text-sm font-semibold text-foreground">
                      {item.name}
                    </p>
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
                  className={`w-full rounded-[16px] py-3 text-sm font-semibold shadow-sm transition ${
                    orderDisabled
                      ? "bg-muted text-muted-foreground"
                      : "bg-primary text-primary-foreground hover:bg-primary/90"
                  }`}
                >
                  Order now
                </button>
              ) : (
                <button
                  onClick={handlePayment}
                  disabled={paymentDisabled}
                  className={`w-full rounded-[16px] py-3 text-sm font-semibold shadow-sm transition ${
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
              {activeTab === "payment" && (
                <button className="w-full rounded-full border border-border py-2 text-[11px] font-medium text-muted-foreground hover:border-foreground hover:text-foreground">
                  Payment options
                </button>
              )}
              {paidMessage && (
                <p className="text-center text-xs font-semibold text-primary">
                  {paidMessage}
                </p>
              )}
            </div>
          </div>
        </div>
      )}
    </>
  );
}
