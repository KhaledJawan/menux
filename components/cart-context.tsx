"use client";

import { createContext, useContext, useMemo, useState, type ReactNode } from "react";

export type CartItem = {
  id: string;
  name: string;
  price: number;
  quantity: number;
};

/**
 * Public shape of the cart context.
 * Tracks pending items, ordered items, totals, and exposes mutation helpers.
 */
type CartContextType = {
  items: CartItem[];
  orderedItems: CartItem[];
  addItem: (item: Omit<CartItem, "quantity">) => void;
  removeItem: (id: string) => void;
  updateQuantity: (id: string, quantity: number) => void;
  clearCart: () => void;
  placeOrder: () => void;
  clearOrders: () => void;
  total: number;
};

const CartContext = createContext<CartContextType | undefined>(undefined);

export function CartProvider({ children }: { children: ReactNode }) {
  // State buckets: current basket + already-ordered items
  const [items, setItems] = useState<CartItem[]>([]);
  const [orderedItems, setOrderedItems] = useState<CartItem[]>([]);

  // Add or increment an item in the basket
  const addItem = (item: Omit<CartItem, "quantity">) => {
    setItems((prev) => {
      const existing = prev.find((i) => i.id === item.id);
      if (existing) {
        return prev.map((i) =>
          i.id === item.id ? { ...i, quantity: i.quantity + 1 } : i
        );
      }
      return [...prev, { ...item, quantity: 1 }];
    });
  };

  // Remove a line item entirely
  const removeItem = (id: string) => {
    setItems((prev) => prev.filter((i) => i.id !== id));
  };

  // Update quantity; drop item if zeroed out
  const updateQuantity = (id: string, quantity: number) => {
    setItems((prev) =>
      prev
        .map((i) => (i.id === id ? { ...i, quantity } : i))
        .filter((i) => i.quantity > 0)
    );
  };

  // Reset basket
  const clearCart = () => setItems([]);

  // Move basket items into ordered list
  const placeOrder = () => {
    if (items.length === 0) return;
    setOrderedItems((prev) => [...prev, ...items]);
    setItems([]);
  };

  // Reset ordered history
  const clearOrders = () => setOrderedItems([]);

  // Aggregate price for current basket
  const total = useMemo(
    () => items.reduce((sum, i) => sum + i.price * i.quantity, 0),
    [items]
  );

  const value: CartContextType = {
    items,
    orderedItems,
    addItem,
    removeItem,
    updateQuantity,
    clearCart,
    placeOrder,
    clearOrders,
    total,
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

export function useCart() {
  const ctx = useContext(CartContext);
  if (!ctx) {
    throw new Error("useCart must be used within CartProvider");
  }
  return ctx;
}
