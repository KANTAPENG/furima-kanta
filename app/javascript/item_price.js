const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const price = parseInt(inputValue, 10);

      if (isNaN(price)) {
        addTaxDom.textContent = "";
        profitDom.textContent = "";
        return;
      }

      const tax = Math.floor(price * 0.1);
      const profit = price - tax;

      addTaxDom.textContent = tax;
      profitDom.textContent = profit;
    });
  }
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);