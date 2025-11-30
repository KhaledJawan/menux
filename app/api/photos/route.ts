"use server";

import { NextResponse } from "next/server";

type UnsplashResult = {
  id: string;
  description: string | null;
  alt_description: string | null;
  urls: { small?: string; regular?: string };
};

const UNSPLASH_BASE = "https://api.unsplash.com/search/photos";

export async function GET(request: Request) {
  // Parse query string for "q"
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q") || "";

  // Validate API key
  const accessKey = process.env.UNSPLASH_ACCESS_KEY;
  if (!accessKey) {
    return NextResponse.json(
      { error: "Unsplash access key not configured." },
      { status: 500 }
    );
  }

  // Basic validation for the query term
  if (!q.trim()) {
    return NextResponse.json({ results: [] });
  }

  // Build Unsplash request URL
  const url = `${UNSPLASH_BASE}?query=${encodeURIComponent(
    q
  )}&client_id=${accessKey}&per_page=20`;

  try {
    const res = await fetch(url);
    if (!res.ok) {
      return NextResponse.json(
        { error: "Failed to fetch from Unsplash" },
        { status: res.status }
      );
    }

    const data = await res.json();

    // Shape the response: only the fields we need
    const cleaned = (data.results as UnsplashResult[] | undefined || []).map(
      (item) => ({
        id: item.id,
        description: item.description,
        alt_description: item.alt_description,
        urls: {
          small: item.urls?.small,
          regular: item.urls?.regular,
        },
      })
    );

    return NextResponse.json({ results: cleaned });
  } catch (err) {
    console.error("Unsplash fetch error:", err);
    return NextResponse.json(
      { error: "Unexpected error reaching Unsplash." },
      { status: 500 }
    );
  }
}
