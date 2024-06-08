// app/javascript/packs/custom.js
document.addEventListener('DOMContentLoaded', () => {
  let elem = document.querySelector('#post_raty');
  if (elem) {
    let opt = {
      scoreName: 'book[rating]',
      starOn: '/assets/star-on.png',  // star画像のパス
      starOff: '/assets/star-off.png' // star画像のパス
    };
    raty(elem, opt);
  }
});
