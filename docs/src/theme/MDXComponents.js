import React from 'react';
// Import the original mapper
import MDXComponents from '@theme-original/MDXComponents';
import Link from '@docusaurus/Link';
import DownloadButton from '@site/src/components/DownloadButton';

export default {
  // Re-use the default mapping
  ...MDXComponents,
  Link,
  DownloadButton,
};