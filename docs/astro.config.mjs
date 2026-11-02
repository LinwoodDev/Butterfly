import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import linwoodStarlight from "@linwooddev/starlight-style";
import react from "@astrojs/react";
import { createI18n } from "@linwooddev/starlight-style/translations";
import AstroPWA from "@vite-pwa/astro";
import manifest from "./webmanifest.json";

const { config: i18n, getSidebarTranslatedLabel } = createI18n(
  new URL("./src/content/i18n/", import.meta.url),
);

// https://astro.build/config
export default defineConfig({
  site: "https://butterfly.linwood.dev",
  integrations: [
    starlight({
      plugins: [linwoodStarlight({ math: true, detectLanguage: true })],
      title: "Linwood Butterfly",
      description: "Take notes, draw freely, and organize ideas across an endless workspace",
      head: [
        {
          tag: "meta",
          attrs: { property: "og:image", content: "https://butterfly.linwood.dev/img/logo.png" },
        },
        {
          tag: "meta",
          attrs: { property: "og:image:alt", content: "Linwood Butterfly logo" },
        },
        { tag: "meta", attrs: { name: "twitter:card", content: "summary" } },
      ],
      customCss: [
        "./src/styles/custom.scss",
      ],
      editLink: {
        baseUrl: 'https://github.com/LinwoodDev/Butterfly/edit/develop/docs/',
      },
      logo: {
        src: "./public/img/docs.svg",
      },
      favicon: "./favicon.ico",
      social: [
        { icon: "mastodon", label: "Mastodon", href: "https://floss.social/@linwood" },
        { icon: "matrix", label: "Matrix", href: "https://linwood.dev/matrix" },
        { icon: "discord", label: "Discord", href: "https://linwood.dev/discord" },
        { icon: "blueSky", label: "Bluesky", href: "https://bsky.app/profile/linwood.dev" },
        { icon: "github", label: "GitHub", href: "https://github.com/LinwoodDev/Butterfly" },
      ],
      components: {
        Head: "./src/components/Head.astro",
      },
      sidebar: [
        {
          ...getSidebarTranslatedLabel("Guides"),
          items: [
            "docs/v2/intro",
            "docs/v2/settings",
            "docs/v2/context_menu",
            "docs/v2/areas",
            "docs/v2/background",
            "docs/v2/colors",
            "docs/v2/paints",
            "docs/v2/layers",
            "docs/v2/pack",
            "docs/v2/templates",
            "docs/v2/pages",
            "docs/v2/shortcuts",
            "docs/v2/stylus-support",
            "docs/v2/storage",
            "docs/v2/waypoints",
            "docs/v2/add",
            "docs/v2/importing",
            "docs/v2/exporting",
            "docs/v2/utilities",
            "docs/v2/collaboration",
            "docs/v2/arguments",
            "docs/v2/migrating",
            {
              label: "OneNote",
              slug: "docs/v2/onenote",
            },
            {
              ...getSidebarTranslatedLabel("Tools"),
              items: [
                {
                  ...getSidebarTranslatedLabel("Overview"),
                  slug: "docs/v2/tools",
                },
                "docs/v2/tools/pen",
                "docs/v2/tools/select",
                "docs/v2/tools/hand",
                "docs/v2/tools/eraser",
                "docs/v2/tools/undo",
                "docs/v2/tools/redo",
                "docs/v2/tools/shape",
                "docs/v2/tools/table",
                "docs/v2/tools/polygon",
                "docs/v2/tools/spacer",
                "docs/v2/tools/area",
                "docs/v2/tools/full_screen",
                "docs/v2/tools/label",
                "docs/v2/tools/laser",
                "docs/v2/tools/texture",
                "docs/v2/tools/barcode",
                "docs/v2/tools/eye_dropper",
                "docs/v2/tools/stamp",
                "docs/v2/tools/collection",
                "docs/v2/tools/presentation",
                "docs/v2/tools/ruler",
                "docs/v2/tools/grid",
              ],
            },
          ],
        },
        "downloads",
        {
          ...getSidebarTranslatedLabel("Community"),
          items: [
            {
              ...getSidebarTranslatedLabel("Home"),
              slug: "community",
            },
            "community/branding",
            {
              ...getSidebarTranslatedLabel("Changelog"),
              slug: "changelog",
            },
            {
              ...getSidebarTranslatedLabel("Contributing"),
              slug: "community/contributing",
            },
            {
              ...getSidebarTranslatedLabel("Code of conduct"),
              slug: "community/code-of-conduct",
            },
            "community/embed",
            "community/embed-example",
            {
              ...getSidebarTranslatedLabel("FAQ"),
              slug: "community/faq",
            },
            "community/comparison",
            {
              ...getSidebarTranslatedLabel("Versions"),
              slug: "community/versions",
            },
            "community/nightly",
            "privacypolicy",
          ],
        },
      ],
      ...i18n,
    }),
    AstroPWA({
      workbox: {
        skipWaiting: true,
        clientsClaim: true,
        navigateFallback: "/404",
        ignoreURLParametersMatching: [/./],
        globPatterns: [
          "**/*.{html,js,css,png,svg,json,ttf,pf_fragment,pf_index,pf_meta,pagefind,wasm}",
        ],
      },
      experimental: {
        directoryAndTrailingSlashHandler: true,
      },
      registerType: "autoUpdate",
      manifest,
    }),
    react(),
  ],
});
