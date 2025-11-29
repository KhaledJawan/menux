"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import type { LucideIcon } from "lucide-react";
import {
  Bot,
  Flame,
  Home,
  ReceiptText,
  UserRound,
} from "lucide-react";

type NavItem = {
  href: string;
  label: string;
  icon: LucideIcon;
};

const items: NavItem[] = [
  { href: "/", label: "Home", icon: Home },
  { href: "/chatbot", label: "Chat bot", icon: Bot },
  { href: "/hot", label: "Hot", icon: Flame },
  { href: "/basket", label: "Basket", icon: ReceiptText },
  { href: "/profile", label: "Profile", icon: UserRound },
];
export default function BottomNav() {
  const pathname = usePathname();

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-20 border-t border-border bg-card/95 backdrop-blur">
      <div className="mx-auto flex max-w-md items-center justify-between px-4 py-2">
        {items.map((item) => {
          const active =
            item.href === "/"
              ? pathname === "/"
              : pathname.startsWith(item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className="flex flex-1 flex-col items-center gap-1 text-[11px]"
            >
              <item.icon
                className={`h-5 w-5 transition-colors ${
                  active ? "text-primary" : "text-muted-foreground"
                }`}
                strokeWidth={2}
                aria-hidden
              />
              <span
                className={`transition-colors ${
                  active
                    ? "font-semibold text-primary"
                    : "text-muted-foreground hover:text-foreground"
                }`}
              >
                {item.label}
              </span>
              <span
                className={`h-[2px] w-10 rounded-full transition-all ${
                  active ? "bg-primary" : "bg-transparent"
                }`}
              />
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
