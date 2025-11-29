"use client";

export default function ProfilePage() {
  return (
    <div className="space-y-4">
      <header>
        <h1 className="text-xl font-semibold text-foreground">Profile</h1>
        <p className="text-xs text-muted-foreground">
          Basic guest profile and simple settings.
        </p>
      </header>

      <section className="space-y-3 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        <h2 className="text-sm font-semibold text-foreground">Guest info</h2>
        <div className="space-y-2 text-xs text-muted-foreground">
          <div className="flex flex-col gap-1">
            <label className="text-[11px] text-muted-foreground">Name</label>
            <input
              className="rounded-lg border border-border bg-input-background px-3 py-2 text-xs text-foreground outline-none ring-0"
              placeholder="Optional"
            />
          </div>
          <div className="flex flex-col gap-1">
            <label className="text-[11px] text-muted-foreground">
              Table / Seat
            </label>
            <input
              className="rounded-lg border border-border bg-input-background px-3 py-2 text-xs text-foreground outline-none ring-0"
              placeholder="e.g. Table 5"
            />
          </div>
        </div>
      </section>

      <section className="space-y-3 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        <h2 className="text-sm font-semibold text-foreground">Settings</h2>
        <div className="flex items-center justify-between text-xs text-foreground">
          <span>Notifications</span>
          <button className="rounded-full bg-muted px-3 py-1 text-[11px] text-foreground">
            On (demo)
          </button>
        </div>
        <div className="flex items-center justify-between text-xs text-foreground">
          <span>Language</span>
          <button className="rounded-full bg-muted px-3 py-1 text-[11px] text-foreground">
            EN (demo)
          </button>
        </div>
      </section>
    </div>
  );
}
