import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["C'est l'heure de YUMMI ! "],
    typeSpeed: 30,
    loop: true
  });
}

export { loadDynamicBannerText };