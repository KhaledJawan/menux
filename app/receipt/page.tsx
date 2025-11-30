"use client";

import Image from "next/image";
import { useCart } from "@/components/cart-context";
import { useState } from "react";

export default function ReceiptPage() {
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
  const [activeTab, setActiveTab] = useState<"order" | "payment">("order");
  const [paidMessage, setPaidMessage] = useState("");

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

  const handlePayment = () => {
    if (paymentDisabled) return;
    markPaid();
    setPaidMessage("Payment successful. Thank you for your payment.");
    setTimeout(() => setPaidMessage(""), 2500);
  };

  return (
    <div className="space-y-4">
      <header className="flex items-center gap-2">
        <h1 className="text-xl font-semibold text-foreground">Receipt</h1>
        <div className="flex flex-1 justify-center">
          <span className="rounded-full bg-muted px-3 py-1 text-[11px] font-semibold text-foreground">
            Table 24
          </span>
        </div>
      </header>

      <div className="flex w-full gap-2 text-xs">
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
          const cue = tab.id === "payment" && orderedItems.length > 0;
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
                className={`h-5 w-5 ${active ? "invert" : cue ? "text-blue-600" : ""}`}
                style={
                  cue && !active
                    ? {
                        filter:
                          "invert(39%) sepia(73%) saturate(2281%) hue-rotate(191deg) brightness(93%) contrast(98%)",
                      }
                    : undefined
                }
              />
              <span>{tab.label}</span>
            </button>
          );
        })}
      </div>

      <div className="flex-1 space-y-3 overflow-y-auto">
        {activeTab === "payment" && orderedItems.length > 0 && (
          <p className="text-[11px] text-muted-foreground">
            Your order is received. You can pay anytime before you leave—no rush if you want to
            add more.
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

      <div className="space-y-3 border-t border-border pt-3">
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
  );
}
