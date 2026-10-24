import type { Config } from "tailwindcss";

export default {
  darkMode: ["class"],
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        graphite: {
          50: "#eef1f5",
          100: "#d8dfe8",
          200: "#bbc8d8",
          300: "#94a9c1",
          400: "#6f8eab",
          500: "#56728f",
          600: "#445b74",
          700: "#38485b",
          800: "#2d3a49",
          900: "#0e1118"
        },
        accent: {
          500: "#5ea5ff",
          600: "#3b8cff"
        }
      },
      borderRadius: {
        xl: "1rem",
        "2xl": "1.25rem"
      },
      boxShadow: {
        flux: "0 20px 50px rgba(0,0,0,0.45), 0 0 0 1px rgba(94,165,255,0.12)"
      },
      fontFamily: {
        sans: ["Inter", "Segoe UI", "sans-serif"],
        mono: ["JetBrains Mono", "Consolas", "monospace"]
      },
      keyframes: {
        "overlay-in": {
          "0%": { opacity: "0", transform: "translateY(10px) scale(0.985)" },
          "100%": { opacity: "1", transform: "translateY(0) scale(1)" }
        },
        "overlay-out": {
          "0%": { opacity: "1", transform: "translateY(0) scale(1)" },
          "100%": { opacity: "0", transform: "translateY(10px) scale(0.985)" }
        }
      },
      animation: {
        "overlay-in": "overlay-in 180ms cubic-bezier(0.22, 1, 0.36, 1)",
        "overlay-out": "overlay-out 150ms ease-in"
      }
    }
  },
  plugins: []
} satisfies Config;
