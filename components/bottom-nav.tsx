"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import Image from "next/image";

type NavItem = {
  href: string;
  label: string;
  name: "home" | "bot" | "hot" | "basket" | "profile";
};

const items: NavItem[] = [
  { href: "/", label: "Home", name: "home" },
  { href: "/chatbot", label: "Chat bot", name: "bot" },
  { href: "/hot", label: "Hot", name: "hot" },
  { href: "/basket", label: "Basket", name: "basket" },
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
  bot: {
    active: "/icons/bold/bot.svg",
    inactive: "/icons/outline/bot-line.svg",
  },
  hot: {
    active: "/icons/bold/heart.svg",
    inactive: "/icons/outline/heart.svg",
  },
  basket: {
    active: "/icons/bold/bag-happy.svg",
    inactive: "/icons/outline/bag-happy.svg",
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
              <NavIcon name={item.name} active={active} />
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
