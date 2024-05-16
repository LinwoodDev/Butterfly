import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

import react from "@astrojs/react";
import { getTranslations } from "./src/translations";

// https://astro.build/config
export default defineConfig({
  outDir: "./build",
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
      social: {
        mastodon: "https://floss.social/@linwood",
        matrix: "https://linwood.dev/matrix",
        discord: "https://linwood.dev/discord",
        github: "https://github.com/LinwoodDev/Butterfly",
      },
      components: {
        SocialIcons: "./src/components/CustomSocialIcons.astro",
      },
      sidebar: [
        {
          label: "Guides",
          translations: getTranslations("guides"),
          items: [
            {
              label: "Introduction",
              translations: getTranslations("introduction"),
              link: "/guides/",
            },
            {
              label: "Area",
              translations: getTranslations("area"),
              link: "/guides/area/",
            },
            {
              label: "Add",
              translations: getTranslations("add"),
              link: "/guides/add/",
            },
            {
              label: "Background",
              translations: getTranslations("background"),
              link: "/guides/background/",
            },
            {
              label: "Collaboration",
              translations: getTranslations("collaboration"),
              link: "/guides/collaboration/",
            },
            {
              label: "Tools",
              translations: getTranslations("tools"),
              link: "/guides/tools/",
            },
          ],
        },
        {
          label: "Downloads",
          translations: getTranslations("downloads"),
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
