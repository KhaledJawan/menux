"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Bell } from "lucide-react";
import { useCart } from "@/components/cart-context";

export default function ProfilePage() {
  // Pull status from cart context (updated after ordering)
  const { status } = useCart();
  const router = useRouter();
  const [showNotifications, setShowNotifications] = useState(false);
  const [langOpen, setLangOpen] = useState(false);
  const [selectedLang, setSelectedLang] = useState("en");

  const languages = [
    { id: "en", label: "English" },
    { id: "de", label: "Deutsch" },
    { id: "lb", label: "Lëtzebuergesch" },
    { id: "fr", label: "Français" },
    { id: "fa", label: "فارسی" },
    { id: "ar", label: "العربية" },
  ];

  const statusOptions = [
    { id: "free", label: "Available" },
    { id: "reserved", label: "Reserved" },
    { id: "in-use", label: "In use" },
  ];

  // Only admin/payment flow should change status. If in-use and user tries to free it, send them to payment.
  const handleStatusSelect = (optId: "free" | "reserved" | "in-use") => {
    if (status === "in-use" && optId === "free") {
      router.push("/order");
      return;
    }
    // Regular guests cannot toggle status directly.
  };

  return (
    <div className="space-y-4">
      <header className="flex items-center gap-2">
        <div className="flex-1">
          <h1 className="text-xl font-semibold text-foreground">Profile</h1>
          <p className="text-xs text-muted-foreground">
            Basic guest profile and simple settings.
          </p>
        </div>
        <button
          onClick={() => setShowNotifications(true)}
          className="relative inline-flex h-10 w-10 items-center justify-center rounded-full bg-black text-xs font-semibold text-white shadow-sm transition hover:bg-black/80"
          aria-label="Notifications"
        >
          <Bell className="h-5 w-5" />
        </button>
      </header>

      <section className="space-y-3 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        <h2 className="text-sm font-semibold text-foreground">Guest & Table</h2>
        <div className="space-y-2 text-xs text-muted-foreground">
          <div className="flex flex-col gap-1">
            <label className="text-[11px] text-muted-foreground">Name</label>
            <input
              className="rounded-lg border border-border bg-input-background px-3 py-2 text-xs text-foreground outline-none ring-0"
              placeholder="Optional"
            />
          </div>
          <div className="flex items-center justify-between rounded-xl bg-muted px-3 py-2 text-xs text-foreground">
            <span>Table 24</span>
            <button className="rounded-full bg-foreground px-3 py-1 text-[11px] font-semibold text-background shadow-sm">
              Request change
            </button>
          </div>
          <p className="text-[11px] text-muted-foreground">Set the current state for this table/seat.</p>
          <div className="flex flex-wrap gap-2">
            {statusOptions.map((opt) => {
              const active = status === opt.id;
              const isFreeDefault = opt.id === "free";
              return (
                <button
                  key={opt.id}
                  onClick={() => handleStatusSelect(opt.id as typeof status)}
                  className={`rounded-full px-3 py-2 text-[11px] font-semibold transition ${
                    active
                      ? isFreeDefault
                        ? "bg-blue-500 text-white"
                        : "bg-foreground text-background shadow-sm"
                      : "bg-muted text-foreground"
                  }`}
                >
                  {opt.label}
                </button>
              );
            })}
          </div>
        </div>
      </section>

      <section className="space-y-3 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        <h2 className="text-sm font-semibold text-foreground">Language</h2>
        <div className="relative">
          <button
            onClick={() => setLangOpen((v) => !v)}
            className="flex w-full items-center justify-between rounded-2xl border border-border bg-card px-3 py-2 text-xs font-semibold text-foreground shadow-sm"
          >
            <span>App language</span>
            <span>{languages.find((l) => l.id === selectedLang)?.label}</span>
          </button>
          {langOpen && (
            <div className="absolute right-0 top-12 z-20 w-48 rounded-2xl border border-border bg-card text-sm shadow-lg">
              {languages.map((lang) => (
                <button
                  key={lang.id}
                  onClick={() => {
                    setSelectedLang(lang.id);
                    setLangOpen(false);
                  }}
                  className="flex w-full items-center justify-between px-3 py-2 text-left text-foreground hover:bg-muted"
                >
                  <span>{lang.label}</span>
                  {lang.id === selectedLang ? (
                    <span className="text-primary">✓</span>
                  ) : null}
                </button>
              ))}
            </div>
          )}
        </div>
      </section>

      <section className="space-y-3 rounded-2xl border border-border bg-card p-3 shadow-[0px_4px_20px_0px_rgba(0,0,0,0.08)]">
        <h2 className="text-sm font-semibold text-foreground">Request service</h2>
        <p className="text-[11px] text-muted-foreground">
          Ask a staff member to come to your table for questions or ordering.
        </p>
        <button className="w-full rounded-[14px] bg-primary px-4 py-2 text-xs font-semibold text-primary-foreground shadow-sm">
          Request at table
        </button>
      </section>

      {showNotifications && (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 px-4 backdrop-blur">
          <div className="flex max-h-[90vh] w-full max-w-md flex-col overflow-hidden rounded-[28px] bg-card shadow-2xl">
            <div className="flex items-start justify-between gap-2 px-5 pt-4">
              <div>
                <h2 className="text-lg font-semibold text-foreground">Updates</h2>
                <p className="text-xs text-muted-foreground">
                  Order status & notifications.
                </p>
              </div>
              <button
                onClick={() => setShowNotifications(false)}
                className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-black/80 text-xs font-semibold text-white shadow-sm transition hover:bg-black"
              >
                ✕
              </button>
            </div>
            <div className="flex-1 space-y-3 overflow-y-auto px-5 py-4">
              {status !== "free" ? (
                <div className="rounded-2xl bg-muted px-3 py-2 text-xs text-foreground shadow-sm">
                  <p className="font-semibold">Order accepted</p>
                  <p className="text-[11px] text-muted-foreground">
                    We will bring it to your table shortly.
                  </p>
                </div>
              ) : (
                <p className="text-xs text-muted-foreground">
                  No new notifications. Recent updates will appear here.
                </p>
              )}
            </div>
            <div className="space-y-3 border-t border-border px-5 pb-5 pt-3">
              <button
                onClick={() => setShowNotifications(false)}
                className="w-full rounded-[16px] bg-primary py-3 text-sm font-semibold text-primary-foreground shadow-sm transition hover:bg-primary/90"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
