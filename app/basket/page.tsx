"use client";

import { useCart } from "@/components/cart-context";

export default function BasketPage() {
  const { items, updateQuantity, removeItem, total, clearCart } = useCart();

  return (
    <div className="space-y-4">
      <header>
        <h1 className="text-xl font-semibold text-foreground">Basket</h1>
        <p className="text-xs text-muted-foreground">
          Review your order before sending it to the kitchen.
        </p>
      </header>

      <section className="space-y-2">
        {items.length === 0 && (
          <p className="text-xs text-muted-foreground">Your basket is empty.</p>
        )}
        {items.map((item) => (
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
          </article>
        ))}
      </section>

      {items.length > 0 && (
        <div className="space-y-3 border-t border-border pt-3">
          <div className="flex items-center justify-between text-sm">
            <span className="text-xs text-muted-foreground">Total</span>
            <span className="text-sm font-semibold text-primary">
              € {total.toFixed(2)}
            </span>
          </div>
          <button className="w-full rounded-full bg-primary py-2 text-xs font-semibold text-primary-foreground shadow-sm transition hover:bg-primary/90">
            Order now (demo)
          </button>
          <button
            onClick={clearCart}
            className="w-full rounded-full border border-border py-2 text-[11px] font-medium text-muted-foreground hover:border-destructive hover:text-destructive"
          >
            Clear basket
          </button>
        </div>
      )}
    </div>
  );
}
