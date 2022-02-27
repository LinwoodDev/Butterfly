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
        'CHANGELOG',
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
            label: 'Contribution guide',
            href: 'https://github.com/LinwoodCloud/butterfly/blob/develop/CONTRIBUTING.md',
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