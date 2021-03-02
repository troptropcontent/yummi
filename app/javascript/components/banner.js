import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  const homePage = document.querySelector(".home-page")
  if (homePage) {    
    new Typed('#banner-typed-text', {
      strings: ["C'est l'heure de YUMMI ! "],
      typeSpeed: 50,
      loop: true
    });
  }
}

export { loadDynamicBannerText };