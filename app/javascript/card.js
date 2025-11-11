document.addEventListener('turbo:load', () => {
  console.log('[card.js] turbo:load fired');

  const form = document.getElementById('charge-form');
  if (!form) {
    console.log('[card.js] no charge-form on this page -> exit');
    return;
  }
  console.log('[card.js] found charge-form', form);

  // 公開鍵を meta タグから取得
  const meta = document.querySelector('meta[name="payjp-key"]');
  if (!meta) {
    console.error('[card.js] payjp public key meta not found');
    return;
  }
  const publicKey = meta.getAttribute('content');
  console.log('[card.js] payjp publicKey:', publicKey);

  // PAY.JP の初期化
  const payjp = Payjp('pk_test_a1dfb3627b83914230575078');
  const elements = payjp.elements();

  // element を作る（div の id がビューと一致していることを確認）
  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');
  console.log('[card.js] mounted cardNumber -> #number-form');

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');
  console.log('[card.js] mounted cardExpiry -> #expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');
  console.log('[card.js] mounted cardCvc -> #cvc-form');

  // 送信イベント
  form.addEventListener('submit', async (e) => {
    console.log('[card.js] submit event fired');
    e.preventDefault();

    try {
      // createToken(elements) は v2 の elements API 用の呼び出し
      const response = await payjp.createToken(numberElement);
      console.log('[card.js] payjp.createToken response:', response);

      if (response.error) {
        // エラーのハンドリング
        console.error('[card.js] payjp error:', response.error);
        alert('カード情報の検証に失敗しました: ' + response.error.message);
        return;
      }

      const token = response.id || response.token; // APIの形式に応じて
      console.log('[card.js] token:', token);

      // hidden input を作って token をセットして form に append
      let tokenInput = document.getElementById('token');
      if (!tokenInput) {
        tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('id', 'token');
        form.appendChild(tokenInput);
        console.log('[card.js] created hidden input#token');
      }
      tokenInput.value = token;

      // card の element を消してカード情報がサーバに行かないようにする（セキュリティ）
      try { numberElement.unmount(); } catch(e){ /* ignore */ }
      try { expiryElement.unmount(); } catch(e){ /* ignore */ }
      try { cvcElement.unmount(); } catch(e){ /* ignore */ }

      // submit を続行
      form.submit();
    } catch (err) {
      console.error('[card.js] unexpected error:', err);
      alert('予期せぬエラーが発生しました');
    }
  });
});