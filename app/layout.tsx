import type { Metadata } from "next";
import "./globals.css";
import { Providers } from "@/components/providers";
import BottomNav from "@/components/bottom-nav";

export const metadata: Metadata = {
  title: "Menux",
  description: "Menux — mobile-first food & drink ordering",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="bg-background text-foreground">
        <Providers>
          {/* App shell with overflow-visible main to allow badges/overlays to escape */}
          <div className="mx-auto flex min-h-screen max-w-md flex-col bg-card pb-16 text-foreground">
            <main className="flex min-h-0 flex-1 flex-col overflow-visible px-4 pt-4 text-foreground">
              {children}
            </main>
            <BottomNav />
          </div>
        </Providers>
      </body>
    </html>
  );
}
