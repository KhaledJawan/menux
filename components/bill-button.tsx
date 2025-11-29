"use client";

import { useState } from "react";
import Image from "next/image";
import { useCart } from "./cart-context";

export default function BillButton() {
  const [open, setOpen] = useState(false);
  const { items, total } = useCart();

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        className="inline-flex items-center justify-center rounded-full bg-white px-3 py-2 text-xs font-semibold text-white shadow-sm ring-1 ring-border transition hover:bg-white/90"
        aria-label="Bill"
      >
        <Image
          src="/icons/bold/receipt-text.svg"
          alt="Bill"
          width={20}
          height={20}
          className="h-5 w-5 invert"
          priority
        />
      </button>

      {open && (
        <div className="fixed inset-0 z-30 flex items-center justify-center bg-black/70 px-4">
          <div className="w-full max-w-md rounded-2xl bg-card p-4 shadow-xl">
            <div className="mb-2 flex items-center justify-between">
              <h2 className="text-sm font-semibold text-foreground">Current Bill</h2>
              <button
                onClick={() => setOpen(false)}
                className="text-xs text-muted-foreground hover:text-foreground"
              >
                Close
              </button>
            </div>
            <div className="max-h-72 space-y-2 overflow-y-auto text-sm">
              {items.length === 0 && (
                <p className="text-xs text-muted-foreground">No items in your bill yet.</p>
              )}
              {items.map((item) => (
                <div
                  key={item.id}
                  className="flex items-center justify-between rounded-lg bg-muted px-3 py-2"
                >
                  <div>
                    <p className="text-xs font-medium text-foreground">{item.name}</p>
                    <p className="text-[11px] text-muted-foreground">x{item.quantity}</p>
                  </div>
                  <p className="text-xs font-semibold text-primary">
                    € {(item.price * item.quantity).toFixed(2)}
                  </p>
                </div>
              ))}
            </div>
            <div className="mt-3 flex items-center justify-between border-t border-border pt-3 text-sm">
              <span className="text-xs text-muted-foreground">Total</span>
              <span className="text-sm font-semibold text-primary">€ {total.toFixed(2)}</span>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
