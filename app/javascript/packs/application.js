/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'bootstrap';
import { loadDynamicBannerText } from '../components/banner';

console.log('Hello World from Webpacker')

loadDynamicBannerText();

const btnCreateCocktail = document.getElementById("btn-create-cocktail");
const simpleFormCocktailName = document.getElementById("cocktail_name");
const simpleFormCocktailSubmit = document.getElementById("btn-simpleform-create-cocktail");
const swalCreateCocktailName = () => {
  swal("Enter your cocktail name:", {
    content: "input",
  })
  .then((value) => {
    simpleFormCocktailName.value = value;
    setTimeout(500);
    simpleFormCocktailSubmit.click();
  })
};

btnCreateCocktail.addEventListener("click", (event) => {
  swalCreateCocktailName();
});

