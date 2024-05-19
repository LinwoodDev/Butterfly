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
              link: "/docs/v2/",
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
              ...getSidebarTranslatedLabel("Migrating"),
              link: "/docs/v2/migrating/",
            },
            {
              ...getSidebarTranslatedLabel("Pack"),
              link: "/docs/v2/pack/",
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
              ...getSidebarTranslatedLabel("Collaboration"),
              link: "/docs/v2/collaboration/",
            },
            {
              ...getSidebarTranslatedLabel("Arguments"),
              link: "/docs/v2/arguments/",
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
                  ...getSidebarTranslatedLabel("Layer"),
                  link: "/docs/v2/tools/layer/",
                },
                {
                  ...getSidebarTranslatedLabel("Presentation"),
                  link: "/docs/v2/tools/presentation/",
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
              link: "/community/faq/",
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
