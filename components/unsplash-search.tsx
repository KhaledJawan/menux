"use client";

import { useState } from "react";

type Photo = {
  id: string;
  description: string | null;
  alt_description: string | null;
  urls: { small?: string; regular?: string };
};

export default function UnsplashSearch() {
  // --- Local UI state ---
  const [query, setQuery] = useState("");
  const [photos, setPhotos] = useState<Photo[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // --- Fetch handler ---
  const handleSearch = async () => {
    setError(null);
    setLoading(true);
    try {
      const res = await fetch(`/api/photos?q=${encodeURIComponent(query)}`);
      if (!res.ok) throw new Error("Failed to fetch photos.");
      const data = await res.json();
      setPhotos(data.results || []);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unexpected error.");
      setPhotos([]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-3">
      {/* Search input + button */}
      <div className="flex gap-2">
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search Unsplash..."
          className="flex-1 rounded-2xl border border-border bg-input-background px-3 py-2 text-sm text-foreground placeholder:text-muted-foreground outline-none"
        />
        <button
          onClick={handleSearch}
          disabled={!query.trim() || loading}
          className="rounded-2xl bg-foreground px-4 py-2 text-sm font-semibold text-background shadow-sm transition hover:bg-foreground/90 disabled:cursor-not-allowed disabled:bg-muted disabled:text-muted-foreground"
        >
          {loading ? "Loading..." : "Search"}
        </button>
      </div>

      {/* Error state */}
      {error && (
        <p className="text-xs font-semibold text-destructive">
          {error}
        </p>
      )}

      {/* Results grid */}
      <div className="grid grid-cols-2 gap-3">
        {photos.map((photo) => (
          <figure
            key={photo.id}
            className="overflow-hidden rounded-xl border border-border bg-card shadow-sm"
          >
            {photo.urls.small ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={photo.urls.small}
                alt={photo.alt_description ?? "Photo"}
                className="h-32 w-full object-cover transition duration-200 hover:scale-[1.02]"
                loading="lazy"
              />
            ) : null}
            <figcaption className="p-2 text-[11px] text-muted-foreground">
              {photo.description || photo.alt_description || "Untitled"}
            </figcaption>
          </figure>
        ))}
      </div>

      {/* Empty state */}
      {!loading && photos.length === 0 && !error && (
        <p className="text-xs text-muted-foreground">
          Try searching for a dish, drink, or ambience.
        </p>
      )}
    </div>
  );
}
