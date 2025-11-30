"use client";

import Link from "next/link";
import Image from "next/image";

export default function LandingPage() {
  return (
    <div className="mx-auto flex h-[calc(100vh-64px)] max-w-sm flex-col bg-card px-4 py-6 text-foreground">
      {/* Header */}
      <header className="mb-6 flex items-center justify-between gap-3">
        <h1 className="text-xl font-semibold">Menux</h1>
        <div className="flex items-center gap-2 rounded-2xl border border-border px-3 py-2 text-sm shadow-sm">
          <span role="img" aria-hidden className="text-lg">
            🌐
          </span>
          <span className="font-semibold">English</span>
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
