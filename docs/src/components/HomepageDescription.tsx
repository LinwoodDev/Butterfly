import React from 'react';
import clsx from 'clsx';
import styles from './HomepageDescription.module.css';
import Translate from '@docusaurus/Translate';

export default function HomepageDescription() {
  return (
    <section className={`${styles.description} margin-vert--xl padding--md`}>
      <span>
        <Translate description="Features simple description">
            Create and manage your notes with ease in a simple, beautiful and powerful application.
        </Translate>
      </span>
    </section>
  );
}
