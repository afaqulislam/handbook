import type { MetadataRoute } from "next";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Handbook - Knowledge System of Record",
    short_name: "Handbook",
    description: "A governed Knowledge System of Record (KSoR) for policies and operating knowledge with MCP-powered retrieval.",
    start_url: "/",
    display: "standalone",
    background_color: "#0b1026",
    theme_color: "#0b1026",
    icons: [
      {
        src: "/icon.png",
        sizes: "512x512",
        type: "image/png",
      },
    ],
  };
}
