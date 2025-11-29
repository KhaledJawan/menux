import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  reactCompiler: true,
  turbopack: {
    // Force Turbopack to treat this directory as the workspace root
    root: __dirname,
  },
  allowedDevOrigins: ["http://localhost:3000", "http://192.168.0.60:3000"],
};

export default nextConfig;
