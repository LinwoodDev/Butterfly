import React from 'react';
import clsx from 'clsx';
import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import styles from './index.module.css';
import HomepageFeatures from "../components/HomepageFeatures";
import Translate from '@docusaurus/Translate';
import "animate.css/animate.min.css";
import UAParser from 'ua-parser-js';
import { AnimationOnScroll } from 'react-animation-on-scroll';

function HomepageHeader() {
  const [platform, setPlatform] = React.useState('');
  React.useEffect(() => {
    const parser = new UAParser();
    const uaPlatform = parser.getOS().name;
    // Test if it is a linux distro
    if (['Raspbian', 'Debian', 'Ubuntu', 'Linux Mint', 'Fedora', 'Arch', 'CentOS', 'Red Hat', 'Manjaro'].includes(uaPlatform)) {
      setPlatform('Linux');
    } else {
      setPlatform(uaPlatform);
    }
  }, []);
  const { siteConfig } = useDocusaurusContext();
  const Svg = require('../../static/img/logo.svg').default;
  return (
    <header className={clsx('hero shadow--lw', styles.heroBanner)}>
      <div className="container">
        <div className="row">
          <div class={clsx("col col--6", styles.center)}>
            <h1 data-aos="fade-up" className="hero__title">
              {siteConfig.title}
            </h1>
            <p data-aos="fade-up" className="hero__subtitle">
              {siteConfig.tagline}
            </p>
            <div className={styles.indexCtas}>
              <AnimationOnScroll animateIn="animate__fadeInLeft">
                <Link data-aos="fade-right"
                  className={clsx("button button--lg button--secondary", styles.button)}
                  to="/docs/1.1/intro">
                  <Translate description="homepage getting started button">
                    Getting started
                  </Translate>
                </Link>
              </AnimationOnScroll>
              <AnimationOnScroll animateIn="animate__fadeInUp">
                <div class="dropdown dropdown--hoverable">
                  <a href="/downloads" class={clsx("button button--primary button--lg", styles.button)}>Download</a>
                  <ul class="dropdown__menu">
                    <li>
                      {platform === 'Windows' &&
                        <Link
                          className="dropdown__link"
                          to="/downloads/windows">
                          <Translate description="homepage windows button">
                            Download for Windows
                          </Translate>
                        </Link>
                      }
                      {platform === 'Linux' &&
                        <Link
                          className="dropdown__link"
                          to="/downloads/linux">
                          <Translate description="homepage linux button">
                            Download for Linux
                          </Translate>
                        </Link>
                      }
                      {platform === 'Android' &&
                        <Link
                          className="dropdown__link"
                          to="/downloads/android">
                          <Translate description="homepage android button">
                            Download for Android
                          </Translate>
                        </Link>
                      }
                    </li>
                    <li>
                      <Link
                        className="dropdown__link"
                        to="https://butterfly.linwood.dev">
                        <Translate description="homepage web button">
                          Open the web app
                        </Translate>
                      </Link>
                    </li>
                    <li>
                      <Link
                        className="dropdown__link"
                        to="/downloads">
                        <Translate description="homepage downloads button">
                          Downloads
                        </Translate>
                      </Link>
                    </li>
                  </ul>
                </div>
              </AnimationOnScroll>
            </div>
          </div>
          <div className={clsx("col col--6", styles.center)}>
            <img data-aos="fade-up"
              src={require('../../static/img/main.png').default}
              className={styles.screenshot}
              alt="Screenshot"
            />
          </div>
        </div>
      </div>
    </header>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`Hello from ${siteConfig.title}`}
      description="Change the world">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
