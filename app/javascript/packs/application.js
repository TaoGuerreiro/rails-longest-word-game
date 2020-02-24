/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import Sortable from 'sortablejs';

const items1 = document.getElementById('drag');
const items2 = document.getElementById('drop');

new Sortable(items1, {
    group: 'shared', // set both lists to same group
    animation: 150
});

new Sortable(items2, {
    group: 'shared',
    animation: 150
});
const word = document.querySelector("#box");
const sub = document.querySelector(".monform");

sub.addEventListener('submit', (event) => {
  event.preventDefault();
  const answere = document.querySelectorAll("#drop .letter");
  const answere_string = []
  answere.forEach((letter) => {
    answere_string.push(letter.firstChild.data)
  });
  console.log(answere_string.join(''));
  word.value = answere_string.join('');
  event.currentTarget.submit();
});



