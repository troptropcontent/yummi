import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Tentez par de nouveaux plats ? ", "plutot italien ou chinois aujourd'hui ? ", "Goutez les plats de vos voisins"],
    typeSpeed: 30,
    loop: true
  });
}

export { loadDynamicBannerText };