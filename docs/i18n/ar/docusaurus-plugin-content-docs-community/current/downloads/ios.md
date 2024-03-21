---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

إصدار iOS من الفراشة هو في المعاينة وقد لا يعمل كما هو متوقع.
انقر فوق [here](https://github.com/LinwoodDev/Butterfly/issues/244) لزيارة المشكلة على GitHub للعثور على الأخطاء والتحديثات المعروفة حاليا. يرجى الإبلاغ عن أي مشاكل هناك.

:::

## الروابط

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">مساء</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

اقرأ المزيد عن النسخة الليلية من الفراشة [here](/nightly).

## تثبيت

ملف IPA الذي نوزعه غير موقع. وهذا يعني أنه سيتعين عليك التوقيع عليه بنفسك قبل أن تكون قادراً على تثبيته على جهاز iOS الخاص بك. \
لحسن الحظ، هناك مشاريع مثل [AltStore](https://altstore.io) (المصدر المفتوح) أو [sideloadly](https://sideloadly.io) (مصدر مغلق). \
\
تحتاج إلى معرف أبل لتحميل الفراشة. ونوصي بإنشاء وظيفة جديدة لهذا الغرض على وجه الخصوص. الرجاء تسجيل الدخول إلى [Apple Developer](https://developer.apple.com) مرة واحدة على الأقل وقبول شروطهم.
\
إذا كان جهازك يقوم بتشغيل iOS 16.0 أو أحدث ، قم بتمكين وضع المطور في الإعدادات/rivacy/Developer.

## Installing (AltStore)

1. إعداد AltStore باستخدام التعليمات المقدمة على موقع AltStore على شبكة الإنترنت.
2. احصل على نسخة من ملف IPA على جهازك. أفضل طريقة هي تنزيله باستخدام متصفح ويب أو إرسال ملف مضغوط يحتوي على وكالة ترويج الاستثمار إلى نفسك. لا تستخدم Airdrop. كذلك لا ترسل الملف مباشرة إلى نفسك. قد لا تتمكن من فتحه.
3. افتح ملف IPA، استخدم قائمة "مشاركة" وانقر على "AltStore". إذا كان جهازك متصلاً بحاسوبك الشخصي الذي يقوم بتشغيل AltServer (سلكي أو لاسلكي) فسيتم تثبيته تلقائياً.

## التثبيت (ثنائي)

1. إعداد Sideloadly باستخدام الأدلة المقدمة على sideloadly.io.
2. فتح التحميل الجانبي على جهاز الكمبيوتر الخاص بك.
3. أضف IPA في أعلى الزاوية اليمنى، حدد جهازك ومعرف Apple الخاص بك. انقر على البقاء. سيتم تثبيت التطبيق على جهازك.
   إذا حصلت على نوافذ منبثقة تقول أن المطور غير موثوق به انتقل إلى الإعدادات/العامة/VPN وإدارة الجهاز وقم بتغيير ذلك.
