let payInitialized = false;
const pay = () => {
  
  if (!payInitialized) {
    const publicKey = gon.public_key;
    const payjp = Payjp(publicKey);
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');
    // フォームが存在するかを確認
    const form = document.getElementById('charge-form');
    if (!form) {
      console.error('Form with id "charge-form" not found.');
      return;
    }
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
    form.addEventListener('submit', (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
          // エラー処理
        } else {
          const token = response.id;
          console.log(token)
          const renderDom = document.getElementById('charge-form');
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML('beforeend', tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      });
      e.preventDefault();
    });
    payInitialized = true;
  }
};
window.addEventListener('turbo:load', pay);
window.addEventListener('turbo:render', pay);