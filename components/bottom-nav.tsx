"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

type NavItem = {
  href: string;
  label: string;
  icon: keyof typeof ICON_PATHS;
};

const items: NavItem[] = [
  { href: "/", label: "Home", icon: "home" },
  { href: "/chatbot", label: "Chat bot", icon: "bot" },
  { href: "/hot", label: "Hot", icon: "heart" },
  { href: "/basket", label: "Basket", icon: "receipt" },
  { href: "/profile", label: "Profile", icon: "profile" },
];

const ICON_PATHS = {
  home: "M20.83 8.01L14.28 2.77C13 1.75 11 1.74 9.73 2.76L3.18 8.01C2.24 8.76 1.67 10.26 1.87 11.44L3.13 18.98C3.42 20.67 4.99 22 6.7 22H17.3C18.99 22 20.59 20.64 20.88 18.97L22.14 11.43C22.32 10.26 21.75 8.76 20.83 8.01ZM12.75 18C12.75 18.41 12.41 18.75 12 18.75C11.59 18.75 11.25 18.41 11.25 18V15C11.25 14.59 11.59 14.25 12 14.25C12.41 14.25 12.75 14.59 12.75 15V18Z",
  bot: "M12.2048 21C14.8573 21 17.4863 20.3641 19.8366 19.0746C21.9687 17.9081 24.0034 16.2076 24.0034 13.9625C24 9.24394 19.9575 0 12 0C4.04253 0 0 8.93475 0 13.9625C0 16.3376 2.00448 18.0381 4.11975 19.173C6.4197 20.4062 8.98489 21 11.5669 21H12.2048Z",
  heart:
    "M16.44 3.1C14.63 3.1 13.01 3.98 12 5.33C10.99 3.98 9.37 3.1 7.56 3.1C4.49 3.1 2 5.6 2 8.69C2 9.88 2.19 10.98 2.52 12C4.1 17 8.97 19.99 11.38 20.81C11.72 20.93 12.28 20.93 12.62 20.81C15.03 19.99 19.9 17 21.48 12C21.81 10.98 22 9.88 22 8.69C22 5.6 19.51 3.1 16.44 3.1Z",
  receipt:
    "M7 2H6C3 2 2 3.79 2 6V7V21C2 21.83 2.94 22.3 3.6 21.8L5.31 20.52C5.71 20.22 6.27 20.26 6.63 20.62L8.29 22.29C8.68 22.68 9.32 22.68 9.71 22.29L11.39 20.61C11.74 20.26 12.3 20.22 12.69 20.52L14.4 21.8C15.06 22.29 16 21.82 16 21V4C16 2.9 16.9 2 18 2H7ZM11.25 13.75H6.75C6.34 13.75 6 13.41 6 13C6 12.59 6.34 12.25 6.75 12.25H11.25C11.66 12.25 12 12.59 12 13C12 13.41 11.66 13.75 11.25 13.75ZM12 9.75H6C5.59 9.75 5.25 9.41 5.25 9C5.25 8.59 5.59 8.25 6 8.25H12C12.41 8.25 12.75 8.59 12.75 9C12.75 9.41 12.41 9.75 12 9.75Z",
  profile:
    "M12.1596 11.62C12.1296 11.62 12.1096 11.62 12.0796 11.62C12.0296 11.61 11.9596 11.61 11.8996 11.62C8.99961 11.53 6.80961 9.25 6.80961 6.44C6.80961 3.58 9.13961 1.25 11.9996 1.25C14.8596 1.25 17.1896 3.58 17.1896 6.44C17.1796 9.25 14.9796 11.53 12.1896 11.62C12.1796 11.62 12.1696 11.62 12.1596 11.62ZM11.9996 2.75C9.96961 2.75 8.30961 4.41 8.30961 6.44C8.30961 8.44 9.86961 10.05 11.8596 10.12C11.9096 10.11 12.0496 10.11 12.1796 10.12C14.1396 10.03 15.6796 8.42 15.6896 6.44C15.6896 4.41 14.0296 2.75 11.9996 2.75Z",
};

function Icon({ name, active }: { name: keyof typeof ICON_PATHS; active: boolean }) {
  return (
    <svg
      aria-hidden
      viewBox="0 0 24 24"
      className={`h-5 w-5 transition-colors ${active ? "text-primary" : "text-muted-foreground"}`}
      fill="currentColor"
    >
      <path d={ICON_PATHS[name]} />
    </svg>
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
              <Icon name={item.icon} active={active} />
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
