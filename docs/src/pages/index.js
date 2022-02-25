import React from 'react';
import clsx from 'clsx';
import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import styles from './index.module.css';
import HomepageFeatures from "../components/HomepageFeatures";
import Translate from '@docusaurus/Translate';
import AOS from 'aos';
import 'aos/dist/aos.css';
AOS.init();


function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  const Svg = require('../../static/img/logo.svg').default;
  return (
    <header className={clsx('hero shadow--lw', styles.heroBanner)}>
      <div className="container">
        <Svg data-aos="fade-down" height="15em" width="15em" alt="Logo" />
        <h1 data-aos="fade-up" className="hero__title">
          {siteConfig.title}
        </h1>
        <p data-aos="fade-up" className="hero__subtitle">
          {siteConfig.tagline}
        </p>
        <div className={styles.indexCtas}>
          <Link data-aos="fade-right"
              className="button button--secondary button--lg"
              to="/docs/1.1/intro">
              <Translate description="homepage getting started button">
                  Getting started
              </Translate>
          </Link>
            <Link data-aos="fade-left"
                className="button button--success button--lg"
                to="/downloads">
                <Translate description="homepage downloads button">
                    Downloads
                </Translate>
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
      <main>
        <HomepageFeatures />
        <img data-aos="fade-up"
          src={require('../../static/img/main.png').default}
          className={styles.screenshot}
          alt="Screenshot"
        />
      </main>
    </Layout>
  );
}
