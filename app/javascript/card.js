document.addEventListener('turbo:load', () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const meta = document.querySelector('meta[name="payjp-key"]');
  if (!meta) return;
  const publicKey = meta.getAttribute('content');

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    try {
      const response = await payjp.createToken(numberElement);
      if (response.error) {
        alert('カード情報の検証に失敗しました: ' + response.error.message);
        return;
      }

      const token = response.id || response.token;
      let tokenInput = document.getElementById('token');
      if (!tokenInput) {
        tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('id', 'token');
        form.appendChild(tokenInput);
      }
      tokenInput.value = token;

      numberElement.unmount();
      expiryElement.unmount();
      cvcElement.unmount();

      form.submit();
    } catch (err) {
      alert('予期せぬエラーが発生しました');
    }
  });
});