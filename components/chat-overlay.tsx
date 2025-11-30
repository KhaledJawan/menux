"use client";

import { useState, type FormEvent } from "react";
import Image from "next/image";
import { menuItems } from "@/lib/menu";
import { useCart } from "./cart-context";

type Message = {
  id: number;
  from: "user" | "bot";
  text: string;
};

// Placeholder for future API integration
// eslint-disable-next-line @typescript-eslint/no-unused-vars
async function sendMessageToAPI(_userMessage: string) {
  // Connect your backend here and return the bot reply.
  // This placeholder currently echoes nothing to avoid logic changes.
  return { reply: null as string | null, items: [] as typeof menuItems };
}

export default function ChatOverlay() {
  const { addItem } = useCart();
  const [open, setOpen] = useState(false);
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 1,
      from: "bot",
      text: "Hi! Tell me what you feel like eating or drinking, and I will suggest items for you.",
    },
  ]);
  const [input, setInput] = useState("");

  const handleSend = (e: FormEvent) => {
    e.preventDefault();
    if (!input.trim()) return;

    // --- User message append ---
    const userMsg: Message = {
      id: Date.now(),
      from: "user",
      text: input.trim(),
    };

    // --- Demo bot logic (unchanged) ---
    const lower = input.toLowerCase();
    const wantsAdd =
      lower.includes("add") ||
      lower.includes("order") ||
      lower.includes("yes") ||
      lower.includes("sure");
    const suggested =
      menuItems.find((i) => i.name.toLowerCase().includes("burger")) ||
      menuItems[0];

    if (wantsAdd && suggested) {
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

    // --- Future: call sendMessageToAPI(userMsg.text) and merge replies/items here ---

    setMessages((prev) => [...prev, userMsg, botMsg]);
    setInput("");
  };

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        className="inline-flex h-10 w-10 items-center justify-center rounded-full bg-black text-xs font-semibold text-white shadow-sm transition hover:bg-black/80"
        aria-label="Chat bot"
      >
        <Image
          src="/icons/bold/bot.svg"
          alt="Chat bot"
          width={20}
          height={20}
          className="h-5 w-5 invert"
          priority
        />
      </button>

      {open && (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 px-4 backdrop-blur transition-opacity duration-200">
          <div className="flex h-[85vh] min-h-[70vh] max-h-[90vh] w-full max-w-md flex-col overflow-hidden rounded-[28px] border border-border bg-card/95 shadow-2xl shadow-black/30 backdrop-blur">
            {/* Header */}
            <div className="flex items-start justify-between gap-2 px-5 pt-4">
              <div>
                <h2 className="text-lg font-semibold text-foreground">Chat bot</h2>
                <p className="text-xs text-muted-foreground">
                  Ask for recommendations or type your order.
                </p>
              </div>
              <button
                onClick={() => setOpen(false)}
                className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-black/80 text-xs font-semibold text-white shadow-sm transition hover:bg-black"
              >
                ✕
              </button>
            </div>

            {/* Messages area */}
            <div className="flex-1 min-h-0 space-y-3 overflow-y-auto px-5 py-4">
              {messages.map((m) => (
                <div
                  key={m.id}
                  className={`flex transition ${
                    m.from === "user" ? "justify-end" : "justify-start"
                  }`}
                >
                  <div
                    className={`max-w-[82%] rounded-2xl px-3 py-2 text-sm leading-relaxed shadow-sm transition ${
                      m.from === "user"
                        ? "bg-primary text-primary-foreground shadow-primary/30"
                        : "bg-muted text-foreground shadow-border"
                    }`}
                  >
                    {m.text}
                  </div>
                </div>
              ))}
              {messages.length === 0 && (
                <div className="flex h-full items-center justify-center">
                  <span className="text-xs text-muted-foreground">
                    Start a conversation to see replies here.
                  </span>
                </div>
              )}
            </div>

            {/* Input area */}
            <form
              onSubmit={handleSend}
              className="flex items-center gap-2 border-t border-border bg-card/80 px-5 pb-4 pt-3 backdrop-blur"
            >
              <input
                value={input}
                onChange={(e) => setInput(e.target.value)}
                placeholder="Type your message..."
                className="flex-1 rounded-full border border-border bg-input-background px-3 py-2 text-sm text-foreground placeholder:text-muted-foreground outline-none transition focus:border-primary"
              />
              <button
                type="submit"
                className="rounded-full bg-primary px-4 py-2 text-xs font-semibold text-primary-foreground shadow-sm transition hover:bg-primary/90"
              >
                Send
              </button>
            </form>
          </div>
        </div>
      )}
    </>
  );
}
