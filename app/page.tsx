"use client";

import Link from "next/link";
import Image from "next/image";
import { useState } from "react";

export default function LandingPage() {
  const [langOpen, setLangOpen] = useState(false);
  const languages = [
    { id: "en", label: "English", default: true },
    { id: "de", label: "Deutsch" },
    { id: "lb", label: "Lëtzebuergesch" },
    { id: "fr", label: "Français" },
    { id: "fa", label: "فارسی" },
    { id: "ar", label: "العربية" },
  ];

  const handleMenuClick = () => {
    if (typeof window !== "undefined") {
      window.sessionStorage.setItem("fromStarterIntro", "1");
    }
  };

  return (
    <div className="mx-auto flex h-[calc(100vh-64px)] max-w-sm flex-col bg-card px-4 py-6 text-foreground">
      {/* Header */}
      <header className="mb-6 flex items-center justify-between gap-3">
        <h1 className="text-xl font-semibold">Menux</h1>
        <div className="relative">
          <button
            onClick={() => setLangOpen((v) => !v)}
            className="flex items-center gap-2 rounded-2xl border border-border px-3 py-2 text-sm font-semibold shadow-sm"
          >
            <span role="img" aria-hidden className="text-lg">
              🌐
            </span>
            <span>Language</span>
          </button>
          {langOpen && (
            <div className="absolute right-0 top-12 z-20 w-48 rounded-2xl border border-border bg-card text-sm shadow-lg">
              {languages.map((lang) => (
                <button
                  key={lang.id}
                  className="flex w-full items-center justify-between px-3 py-2 text-left text-foreground hover:bg-muted"
                >
                  <span>{lang.label}</span>
                  {lang.default ? <span className="text-primary">✓</span> : null}
                </button>
              ))}
            </div>
          )}
        </div>
      </header>

      <div className="flex flex-1 flex-col justify-between">
        {/* Hero */}
        <div className="relative mb-5 h-64 w-full overflow-hidden rounded-3xl">
        <Image
          src="/design/restaurantsample.jpg"
          alt="Restaurant atmosphere"
          fill
          className="object-cover"
          sizes="400px"
        />
      </div>

      {/* Table + intro */}
      <div className="mb-2">
        <p className="text-2xl font-semibold">Table 24</p>
        <p className="text-sm text-muted-foreground">Welcome to XXX Restaurant</p>
      </div>
        <p className="mb-6 line-clamp-3 text-sm leading-relaxed text-muted-foreground">
          Lorem ipsum dolor sit amet consectetur. Neque placerat leo dapibus
          aliquet velit. Amet tempor mauris volutpat egestas et dui leo in
          gravida. Mus mauris ut aliquam faucibus...
        </p>

        {/* CTA buttons */}
        <div className="mt-auto space-y-3 pb-4">
          <div className="flex justify-center gap-3">
            <Link
              href="/chatbot"
              className="max-w-[180px] flex h-14 flex-1 flex-col items-center justify-center rounded-[28px] bg-white px-4 text-center text-sm font-semibold text-black shadow-sm transition hover:bg-muted"
            >
              <span className="text-[11px] text-black/60">I&apos;m new here</span>
              <span className="text-base leading-tight">Chat with AI</span>
            </Link>
            <Link
              href="/order"
              onClick={handleMenuClick}
              className="max-w-[180px] flex h-14 flex-1 items-center justify-center rounded-[28px] bg-black px-4 text-center text-base font-semibold text-white shadow-sm transition hover:bg-black/85"
            >
              Menu
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
