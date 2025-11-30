"use client";

import Link from "next/link";
import Image from "next/image";

export default function LandingPage() {
  return (
    <div className="mx-auto flex min-h-screen max-w-sm flex-col overflow-y-auto bg-card px-4 py-6 text-foreground">
      <header className="mb-6 flex items-center justify-between gap-3">
        <h1 className="text-xl font-semibold">Menux</h1>
        <div className="flex items-center gap-2 rounded-2xl border border-border px-3 py-2 text-sm shadow-sm">
          <span role="img" aria-hidden className="text-lg">
            🌐
          </span>
          <span className="font-semibold">English</span>
        </div>
      </header>

      <div className="flex flex-1 flex-col">
        <div className="relative mb-5 h-64 w-full overflow-hidden rounded-3xl">
        <Image
          src="/design/restaurantsample.jpg"
          alt="Restaurant atmosphere"
          fill
          className="object-cover"
          sizes="400px"
        />
      </div>

      <div className="mb-2">
        <p className="text-2xl font-semibold">Table 24</p>
        <p className="text-sm text-muted-foreground">Welcome to XXX Restaurant</p>
      </div>
        <p className="mb-6 text-sm leading-relaxed text-muted-foreground">
          Lorem ipsum dolor sit amet consectetur. Neque placerat leo dapibus
          aliquet velit. Amet tempor mauris volutpat egestas et dui leo in
          gravida. Mus mauris ut aliquam faucibus...
        </p>

        <div className="mt-auto space-y-3 pb-4">
        <div className="flex gap-3 justify-center">
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

        <Link
          href="/top"
          className="relative flex w-full items-center justify-center gap-2 rounded-[28px] bg-white px-4 py-3 text-base font-semibold text-black shadow-sm transition hover:bg-muted"
        >
          Order Fast
          <span className="absolute right-4 text-black">→</span>
        </Link>
        </div>
      </div>
    </div>
  );
}
