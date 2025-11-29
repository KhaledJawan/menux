"use client";

import { FormEvent, useState } from "react";
import { useCart } from "@/components/cart-context";
import { menuItems } from "@/lib/menu";

type Message = {
  id: number;
  from: "user" | "bot";
  text: string;
};

export default function ChatbotPage() {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 1,
      from: "bot",
      text: "Hi! Tell me what you feel like eating or drinking, and I will suggest items for you.",
    },
  ]);
  const [input, setInput] = useState("");
  const { addItem } = useCart();

  const handleSend = (e: FormEvent) => {
    e.preventDefault();
    if (!input.trim()) return;

    const userMsg: Message = {
      id: Date.now(),
      from: "user",
      text: input.trim(),
    };

    // یک جواب خیلی ساده (فقط demo)
    const lower = input.toLowerCase();
    const wantsAdd =
      lower.includes("add") ||
      lower.includes("order") ||
      lower.includes("yes") ||
      lower.includes("sure");
    const suggested =
      menuItems.find((i) => i.name.toLowerCase().includes("burger")) ||
      menuItems[0];

    if (wantsAdd) {
      addItem({
        id: suggested.id,
        name: suggested.name,
        price: suggested.price,
      });
    }

    const botText =
      wantsAdd && suggested
        ? `Added "${suggested.name}" to your basket. Want anything else?`
        : lower.includes("burger") || lower.includes("hungry")
          ? `You might like "${suggested.name}". I can add it to your basket if you want.`
          : "Thanks! For now I’m a simple demo bot. Soon I can understand more and add items directly to your basket.";

    const botMsg: Message = {
      id: Date.now() + 1,
      from: "bot",
      text: botText,
    };

    setMessages((prev) => [...prev, userMsg, botMsg]);
    setInput("");
  };

  return (
    <div className="flex h-[calc(100vh-5rem)] flex-col">
      <header className="mb-2">
        <h1 className="text-xl font-semibold text-foreground">Chat bot</h1>
        <p className="text-xs text-muted-foreground">
          Ask for recommendations or type your order in natural language.
        </p>
      </header>

      <div className="flex-1 space-y-2 overflow-y-auto rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        {messages.map((m) => (
          <div
            key={m.id}
            className={`flex ${
              m.from === "user" ? "justify-end" : "justify-start"
            }`}
          >
            <div
              className={`max-w-[80%] rounded-2xl px-3 py-2 text-xs ${
              m.from === "user"
                ? "bg-primary text-primary-foreground"
                : "bg-muted text-foreground"
            }`}
          >
              {m.text}
            </div>
          </div>
        ))}
      </div>

      <form
        onSubmit={handleSend}
        className="mt-2 flex items-center gap-2 rounded-full border border-border bg-card px-3 py-2 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]"
      >
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Type your message..."
          className="flex-1 bg-transparent text-xs text-foreground placeholder:text-muted-foreground focus:outline-none"
        />
        <button
          type="submit"
          className="rounded-full bg-primary px-3 py-1 text-xs font-semibold text-primary-foreground transition hover:bg-primary/90"
        >
          Send
        </button>
      </form>
    </div>
  );
}
