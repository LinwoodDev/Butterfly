/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

module.exports = {
  // By default, Docusaurus generates a sidebar from the docs folder structure
  sidebar: [
    'community',
    'branding',
    'changelog',
    'contributing',
    'code-of-conduct',
    {
      type: 'category',
      label: "Embedding",
      items: [
        'embed/intro',
        'embed/playground',
      ]
    },
    'faq',
    'versions',
    'nightly',
    'privacypolicy',
    {
      type: 'link',
      href: 'https://discord.linwood.dev',
      label: 'Discord'
    },
    {
      type: 'link',
      href: 'https://github.com/LinwoodCloud/Butterfly',
      label: 'GitHub'
    }
  ],

  // But you can create a sidebar manually
  /*
  tutorialSidebar: [
    {
      type: 'category',
      label: 'Tutorial',
      items: ['hello'],
    },
  ],
   */
};