import React from 'react';
import clsx from 'clsx';
import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import styles from './index.module.css';
import HomepageFeatures from "../components/HomepageFeatures";

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  const Svg = require('../../static/img/logo.svg').default;
  return (
    <header className={clsx('hero shadow--lw', styles.heroBanner)}>
      <div className="container">
        <Svg height="15em" width="15em" alt="Logo" />
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.indexCtas}>
          <Link
              className="button button--secondary button--lg"
              to="/docs/1.0.0-rc.4/intro">
              Getting started
          </Link>
            <Link
                className="button button--success button--lg"
                to="/downloads">
                Downloads
            </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`Hello from ${siteConfig.title}`}
      description="Change the world">
      <HomepageHeader />
      <main><img
          src={require('../../static/img/main.png').default}
          className={styles.screenshot}
          alt="Screenshot"
      />
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
