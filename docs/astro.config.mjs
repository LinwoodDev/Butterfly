import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import remarkHeadingID from "remark-heading-id";
import react from "@astrojs/react";
import { getSidebarTranslatedLabel } from "./src/translations";

// https://astro.build/config
export default defineConfig({
  outDir: "./build",
  markdown: {
    remarkPlugins: [remarkHeadingID],
  },
  integrations: [
    starlight({
      title: "Linwood Butterfly",
      customCss: [
        // Relative path to your custom CSS file
        "./src/styles/custom.css",
      ],
      logo: {
        src: "./src/assets/img/docs.svg",
      },
      favicon: './favicon.ico',
      social: {
        mastodon: "https://floss.social/@linwood",
        matrix: "https://linwood.dev/matrix",
        discord: "https://linwood.dev/discord",
        github: "https://github.com/LinwoodDev/Butterfly",
      },
      components: {
        SocialIcons: "./src/components/CustomSocialIcons.astro",
        Head: "./src/components/Head.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
      },
      sidebar: [
        {
          ...getSidebarTranslatedLabel("Guides"),
          items: [
            {
              ...getSidebarTranslatedLabel("Introduction"),
              link: "/guides/",
            },
            {
              ...getSidebarTranslatedLabel("Area"),
              link: "/guides/area/",
            },
            {
              ...getSidebarTranslatedLabel("Background"),
              link: "/guides/background/",
            },
            {
              ...getSidebarTranslatedLabel("Color picker"),
              link: "/guides/color_picker/",
            },
            {
              ...getSidebarTranslatedLabel("Layers"),
              link: "/guides/layers/",
            },
            {
              ...getSidebarTranslatedLabel("Migrating"),
              link: "/guides/migrating/",
            },
            {
              ...getSidebarTranslatedLabel("Pack"),
              link: "/guides/pack/",
            },
            {
              ...getSidebarTranslatedLabel("Pages"),
              link: "/guides/pages/",
            },
            {
              ...getSidebarTranslatedLabel("Shortcuts"),
              link: "/guides/shortcuts/",
            },
            {
              ...getSidebarTranslatedLabel("Storage"),
              link: "/guides/storage/",
            },
            {
              ...getSidebarTranslatedLabel("Waypoints"),
              link: "/guides/waypoints/",
            },
            {
              ...getSidebarTranslatedLabel("Add"),
              link: "/guides/add/",
            },
            {
              ...getSidebarTranslatedLabel("Collaboration"),
              link: "/guides/collaboration/",
            },
            {
              ...getSidebarTranslatedLabel("Arguments"),
              link: "/guides/arguments/",
            },
            {
              ...getSidebarTranslatedLabel("Tools"),
              items: [
                {
                  ...getSidebarTranslatedLabel("Overview"),
                  link: "/guides/tools/",
                },
                {
                  ...getSidebarTranslatedLabel("Pen"),
                  link: "/guides/tools/pen/",
                },
                {
                  ...getSidebarTranslatedLabel("Select"),
                  link: "/guides/tools/select/",
                },
                {
                  ...getSidebarTranslatedLabel("Hand"),
                  link: "/guides/tools/hand/",
                },
                {
                  ...getSidebarTranslatedLabel("Path eraser"),
                  link: "/guides/tools/path_eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Eraser"),
                  link: "/guides/tools/eraser/",
                },
                {
                  ...getSidebarTranslatedLabel("Undo"),
                  link: "/guides/tools/undo/",
                },
                {
                  ...getSidebarTranslatedLabel("Redo"),
                  link: "/guides/tools/redo/",
                },
                {
                  ...getSidebarTranslatedLabel("Shape"),
                  link: "/guides/tools/shape/",
                },
                {
                  ...getSidebarTranslatedLabel("Spacer"),
                  link: "/guides/tools/spacer/",
                },
                {
                  ...getSidebarTranslatedLabel("Area"),
                  link: "/guides/tools/area/",
                },
                {
                  ...getSidebarTranslatedLabel("Full screen"),
                  link: "/guides/tools/full_screen/",
                },
                {
                  ...getSidebarTranslatedLabel("Label"),
                  link: "/guides/tools/label/",
                },
                {
                  ...getSidebarTranslatedLabel("Laser"),
                  link: "/guides/tools/laser/",
                },
                {
                  ...getSidebarTranslatedLabel("Texture"),
                  link: "/guides/tools/texture/",
                },
                {
                  ...getSidebarTranslatedLabel("Stamp"),
                  link: "/guides/tools/stamp/",
                },
                {
                  ...getSidebarTranslatedLabel("Layer"),
                  link: "/guides/tools/layer/",
                },
                {
                  ...getSidebarTranslatedLabel("Presentation"),
                  link: "/guides/tools/presentation/",
                },
              ],
            },
          ],
        },
        {
          ...getSidebarTranslatedLabel("Downloads"),
          link: "/downloads/",
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
