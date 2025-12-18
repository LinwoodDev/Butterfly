import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import react from "@astrojs/react";
import { getSidebarTranslatedLabel } from "./src/translations";
import remarkHeadingID from "remark-heading-id";
import remarkGemoji from "remark-gemoji";
import rehypeKatex from 'rehype-katex'
import AstroPWA from "@vite-pwa/astro";
import manifest from "./webmanifest.json";
import remarkMath from "remark-math";

// https://astro.build/config
export default defineConfig({
  site: "https://butterfly.linwood.dev",
  markdown: {
    remarkPlugins: [remarkHeadingID, remarkGemoji, remarkMath],
    rehypePlugins: [rehypeKatex]
  },
  integrations: [
    starlight({
      title: "Linwood Butterfly",
      customCss: [
        // Relative path to your custom CSS file
        "./src/styles/linwood-style.scss",
        "./src/styles/custom.scss",
        "node_modules/katex/dist/katex.min.css"
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
        Footer: "./src/components/Footer.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
      },
      sidebar: [
        {
          ...getSidebarTranslatedLabel("Guides"),
          items: [
            {
              ...getSidebarTranslatedLabel("Introduction"),
              link: "/docs/v2/intro",
            },
            {
              ...getSidebarTranslatedLabel("Area"),
              link: "/docs/v2/areas/",
            },
            {
              ...getSidebarTranslatedLabel("Background"),
              link: "/docs/v2/background/",
            },
            {
              ...getSidebarTranslatedLabel("Color picker"),
              link: "/docs/v2/color_picker/",
            },
            {
              ...getSidebarTranslatedLabel("Layers"),
              link: "/docs/v2/layers/",
            },
            {
              ...getSidebarTranslatedLabel("Pack"),
              link: "/docs/v2/pack/",
            },
            {
              ...getSidebarTranslatedLabel("Templates"),
              link: "/docs/v2/templates/",
            },
            {
              ...getSidebarTranslatedLabel("Pages"),
              link: "/docs/v2/pages/",
            },
            {
              ...getSidebarTranslatedLabel("Shortcuts"),
              link: "/docs/v2/shortcuts/",
            },
            {
              ...getSidebarTranslatedLabel("Storage"),
              link: "/docs/v2/storage/",
            },
            {
              ...getSidebarTranslatedLabel("Waypoints"),
              link: "/docs/v2/waypoints/",
            },
            {
              ...getSidebarTranslatedLabel("Add"),
              link: "/docs/v2/add/",
            },
            {
              ...getSidebarTranslatedLabel("Utilities"),
              link: "/docs/v2/utilities/",
            },
            {
              ...getSidebarTranslatedLabel("Collaboration"),
              link: "/docs/v2/collaboration/",
            },
            {
              ...getSidebarTranslatedLabel("Arguments"),
              link: "/docs/v2/arguments/",
            },
            {
              ...getSidebarTranslatedLabel("Migrating"),
              link: "/docs/v2/migrating/",
            },
            {
              ...getSidebarTranslatedLabel("Tools"),
              items: [
                {
                  ...getSidebarTranslatedLabel("Overview"),
                  link: "/docs/v2/tools/",
                },
                {
                  ...getSidebarTranslatedLabel("Pen"),
                  link: "/docs/v2/tools/pen/",
                },
                {
                  ...getSidebarTranslatedLabel("Select"),
                  link: "/docs/v2/tools/select/",
                },
                {
                  ...getSidebarTranslatedLabel("Hand"),
                  link: "/docs/v2/tools/hand/",
                },
                {
                  ...getSidebarTranslatedLabel("Path eraser"),
                  link: "/docs/v2/tools/path_eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Eraser"),
                  link: "/docs/v2/tools/eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Undo"),
                  link: "/docs/v2/tools/undo/",
                },
                {
                  ...getSidebarTranslatedLabel("Redo"),
                  link: "/docs/v2/tools/redo/",
                },
                {
                  ...getSidebarTranslatedLabel("Shape"),
                  link: "/docs/v2/tools/shape/",
                },
                {
                  ...getSidebarTranslatedLabel("Spacer"),
                  link: "/docs/v2/tools/spacer/",
                },
                {
                  ...getSidebarTranslatedLabel("Area"),
                  link: "/docs/v2/tools/area/",
                },
                {
                  ...getSidebarTranslatedLabel("Full screen"),
                  link: "/docs/v2/tools/full_screen/",
                },
                {
                  ...getSidebarTranslatedLabel("Label"),
                  link: "/docs/v2/tools/label/",
                },
                {
                  ...getSidebarTranslatedLabel("Laser"),
                  link: "/docs/v2/tools/laser/",
                },
                {
                  ...getSidebarTranslatedLabel("Texture"),
                  link: "/docs/v2/tools/texture/",
                },
                {
                  ...getSidebarTranslatedLabel("Stamp"),
                  link: "/docs/v2/tools/stamp/",
                },
                {
                  ...getSidebarTranslatedLabel("Collection"),
                  link: "/docs/v2/tools/collection/",
                },
                {
                  ...getSidebarTranslatedLabel("Presentation"),
                  link: "/docs/v2/tools/presentation/",
                },
                {
                  ...getSidebarTranslatedLabel("Ruler"),
                  link: "/docs/v2/tools/ruler/",
                },
                {
                  ...getSidebarTranslatedLabel("Grid"),
                  link: "/docs/v2/tools/grid/",
                },
              ],
            },
          ],
        },
        {
          ...getSidebarTranslatedLabel("Downloads"),
          link: "/downloads/",
        },
        {
          ...getSidebarTranslatedLabel("Community"),
          items: [
            {
              ...getSidebarTranslatedLabel("Home"),
              link: "/community/",
            },
            {
              ...getSidebarTranslatedLabel("Branding"),
              link: "/community/branding/",
            },
            {
              ...getSidebarTranslatedLabel("Changelog"),
              link: "/changelog/",
            },
            {
              ...getSidebarTranslatedLabel("Contributing"),
              link: "/community/contributing/",
            },
            {
              ...getSidebarTranslatedLabel("Code of conduct"),
              link: "/community/code-of-conduct/",
            },
            {
              ...getSidebarTranslatedLabel("Embedding"),
              link: "/community/embed/",
            },
            {
              ...getSidebarTranslatedLabel("FAQ"),
              link: "/community/faq/",
            },
            {
              ...getSidebarTranslatedLabel("Comparison"),
              link: "/community/comparison/",
            },
            {
              ...getSidebarTranslatedLabel("Versions"),
              link: "/community/versions/",
            },
            {
              ...getSidebarTranslatedLabel("Nightly builds"),
              link: "/community/nightly/",
            },
            {
              ...getSidebarTranslatedLabel("Privacy policy"),
              link: "/privacypolicy/",
            },
          ],
        },
      ],
      locales: {
        root: {
          label: "English",
          lang: "en",
        },
        af: {
          label: "Afrikaans",
        },
        ar: {
          label: "Arabic",
        },
        ca: {
          label: "Catalan",
        },
        cs: {
          label: "Czech",
        },
        da: {
          label: "Danish",
        },
        de: {
          label: "German",
        },
        el: {
          label: "Greek",
        },
        es: {
          label: "Spanish",
        },
        fi: {
          label: "Finnish",
        },
        fr: {
          label: "French",
        },
        he: {
          label: "Hebrew",
        },
        hi: {
          label: "Hindi",
        },
        hu: {
          label: "Hungarian",
        },
        id: {
          label: "Indonesian",
        },
        it: {
          label: "Italian",
        },
        ja: {
          label: "Japanese",
        },
        ko: {
          label: "Korean",
        },
        nl: {
          label: "Dutch",
        },
        no: {
          label: "Norwegian",
        },
        or: {
          label: "Oriya",
        },
        pl: {
          label: "Polish",
        },
        pt: {
          label: "Portuguese",
        },
        "pt-br": {
          label: "Portuguese (Brazil)",
          lang: "pt-BR",
        },
        ro: {
          label: "Romanian",
        },
        ru: {
          label: "Russian",
        },
        sr: {
          label: "Serbian",
        },
        sv: {
          label: "Swedish",
        },
        th: {
          label: "Thai",
        },
        tr: {
          label: "Turkish",
        },
        uk: {
          label: "Ukrainian",
        },
        vi: {
          label: "Vietnamese",
        },
        zh: {
          label: "Chinese",
        },
        "zh-hant": {
          label: "Chinese (Traditional)",
          lang: "zh-Hant",
        },
      },
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
