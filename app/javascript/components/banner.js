import Typed from 'typed.js';
import swal from 'sweetalert';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Missed a cocktail? ^500 Ask Mister Cocktail!"],
    typeSpeed: 35,
    showCursor: false,
    loop: false
  });
};

const createNewCocktailModal = () => {

};

export { loadDynamicBannerText };
