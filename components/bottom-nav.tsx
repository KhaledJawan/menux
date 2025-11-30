"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useCart } from "./cart-context";

type NavItem = {
  href: string;
  label: string;
  name: "home" | "receipt" | "top" | "profile";
};

const navItems: NavItem[] = [
  { href: "/order", label: "Home", name: "home" },
  { href: "/top", label: "Top", name: "top" },
  { href: "/receipt", label: "Receipt", name: "receipt" },
  { href: "/profile", label: "Profile", name: "profile" },
];

const ICON_PATHS: Record<
  NavItem["name"],
  { active: string; inactive: string }
> = {
  home: {
    active: "/icons/bold/home.svg",
    inactive: "/icons/outline/home.svg",
  },
  receipt: {
    active: "/icons/bold/receipt-disscount.svg",
    inactive: "/icons/outline/receipt-disscount.svg",
  },
  top: {
    active: "/icons/bold/medal-star.svg",
    inactive: "/icons/outline/medal-star.svg",
  },
  profile: {
    active: "/icons/bold/frame.svg",
    inactive: "/icons/outline/frame.svg",
  },
};

function NavIcon({ name, active }: { name: NavItem["name"]; active: boolean }) {
  const src = active ? ICON_PATHS[name].active : ICON_PATHS[name].inactive;
  return (
    <Image
      src={src}
      alt={`${name} icon`}
      width={20}
      height={20}
      className="h-5 w-5"
      priority
    />
  );
}

export default function BottomNav() {
  const { items, orderedItems } = useCart();
  const pathname = usePathname();
  if (pathname === "/") return null;
  const totalCount = [...items, ...orderedItems].reduce(
    (sum, item) => sum + (item.quantity || 0),
    0
  );

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-20 border-t border-border bg-card/95 backdrop-blur">
      <div className="mx-auto flex max-w-md items-center justify-between px-4 py-2">
        {navItems.map((item) => {
          const active = pathname.startsWith(item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className="relative flex flex-1 flex-col items-center gap-1 text-[11px]"
            >
              {/* Icon + label with animated underline */}
              <span className="relative inline-flex items-center justify-center">
                <NavIcon name={item.name} active={active} />
                {item.name === "receipt" && totalCount > 0 && (
                  <span className="absolute -right-1.5 -top-1.5 inline-flex h-4 min-w-[16px] items-center justify-center rounded-full bg-red-500 px-[4px] text-[10px] font-bold leading-none text-white shadow ring-2 ring-card">
                    {totalCount > 99 ? "99+" : totalCount}
                  </span>
                )}
              </span>
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
                className={`h-[2px] w-10 rounded-full transition-[transform,background-color] duration-300 ease-out ${
                  active
                    ? "translate-y-0 bg-primary"
                    : "translate-y-[4px] bg-transparent"
                }`}
              />
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
