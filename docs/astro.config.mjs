import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import remarkHeadingID from "remark-heading-id";
import react from "@astrojs/react";
import { getSidebarTranslatedLabel } from "./src/translations";
import remarkGemoji from "remark-gemoji";

// https://astro.build/config
export default defineConfig({
  outDir: "./build",
  markdown: {
    remarkPlugins: [remarkHeadingID, remarkGemoji],
  },
  integrations: [
    starlight({
      title: "Linwood Butterfly",
      customCss: [
        // Relative path to your custom CSS file
        "./src/styles/custom.css",
      ],
      logo: {
        src: "./public/img/docs.svg",
      },
      favicon: "./favicon.ico",
      social: {
        mastodon: "https://floss.social/@linwood",
        matrix: "https://linwood.dev/matrix",
        discord: "https://linwood.dev/discord",
        github: "https://github.com/LinwoodDev/Butterfly",
      },
      components: {
        SocialIcons: "./src/components/CustomSocialIcons.astro",
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
              link: "/docs/",
            },
            {
              ...getSidebarTranslatedLabel("Area"),
              link: "/docs/area/",
            },
            {
              ...getSidebarTranslatedLabel("Background"),
              link: "/docs/background/",
            },
            {
              ...getSidebarTranslatedLabel("Color picker"),
              link: "/docs/color_picker/",
            },
            {
              ...getSidebarTranslatedLabel("Layers"),
              link: "/docs/layers/",
            },
            {
              ...getSidebarTranslatedLabel("Migrating"),
              link: "/docs/migrating/",
            },
            {
              ...getSidebarTranslatedLabel("Pack"),
              link: "/docs/pack/",
            },
            {
              ...getSidebarTranslatedLabel("Pages"),
              link: "/docs/pages/",
            },
            {
              ...getSidebarTranslatedLabel("Shortcuts"),
              link: "/docs/shortcuts/",
            },
            {
              ...getSidebarTranslatedLabel("Storage"),
              link: "/docs/storage/",
            },
            {
              ...getSidebarTranslatedLabel("Waypoints"),
              link: "/docs/waypoints/",
            },
            {
              ...getSidebarTranslatedLabel("Add"),
              link: "/docs/add/",
            },
            {
              ...getSidebarTranslatedLabel("Collaboration"),
              link: "/docs/collaboration/",
            },
            {
              ...getSidebarTranslatedLabel("Arguments"),
              link: "/docs/arguments/",
            },
            {
              ...getSidebarTranslatedLabel("Tools"),
              items: [
                {
                  ...getSidebarTranslatedLabel("Overview"),
                  link: "/docs/tools/",
                },
                {
                  ...getSidebarTranslatedLabel("Pen"),
                  link: "/docs/tools/pen/",
                },
                {
                  ...getSidebarTranslatedLabel("Select"),
                  link: "/docs/tools/select/",
                },
                {
                  ...getSidebarTranslatedLabel("Hand"),
                  link: "/docs/tools/hand/",
                },
                {
                  ...getSidebarTranslatedLabel("Path eraser"),
                  link: "/docs/tools/path_eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Eraser"),
                  link: "/docs/tools/eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Undo"),
                  link: "/docs/tools/undo/",
                },
                {
                  ...getSidebarTranslatedLabel("Redo"),
                  link: "/docs/tools/redo/",
                },
                {
                  ...getSidebarTranslatedLabel("Shape"),
                  link: "/docs/tools/shape/",
                },
                {
                  ...getSidebarTranslatedLabel("Spacer"),
                  link: "/docs/tools/spacer/",
                },
                {
                  ...getSidebarTranslatedLabel("Area"),
                  link: "/docs/tools/area/",
                },
                {
                  ...getSidebarTranslatedLabel("Full screen"),
                  link: "/docs/tools/full_screen/",
                },
                {
                  ...getSidebarTranslatedLabel("Label"),
                  link: "/docs/tools/label/",
                },
                {
                  ...getSidebarTranslatedLabel("Laser"),
                  link: "/docs/tools/laser/",
                },
                {
                  ...getSidebarTranslatedLabel("Texture"),
                  link: "/docs/tools/texture/",
                },
                {
                  ...getSidebarTranslatedLabel("Stamp"),
                  link: "/docs/tools/stamp/",
                },
                {
                  ...getSidebarTranslatedLabel("Layer"),
                  link: "/docs/tools/layer/",
                },
                {
                  ...getSidebarTranslatedLabel("Presentation"),
                  link: "/docs/tools/presentation/",
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
              link: "/community/changelog/",
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
              link: "/faq/",
            },
            {
              ...getSidebarTranslatedLabel("Versions"),
              link: "/community/versions/",
            },
            {
              ...getSidebarTranslatedLabel("Nightly builds"),
              link: "/nightly/",
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
        "pt-BR": {
          label: "Portuguese (Brazil)",
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
        "zh-Hant": {
          label: "Chinese (Traditional)",
        },
      },
    }),
    react(),
  ],
});
