// const priceCalculator = () => {
//   const checkOutData = document.querySelector(".checkout-data")
//   if (checkOutData) {
//     const lineQuantity = document.getElementById("line_quantity");
//     lineQuantity.addEventListener("change",(event)=>{
//       console.log(event.target.value)
//       const price = document.querySelector(".price");
//       const price_data = price.dataset.price;
//       const newPrice = price_data/100*event.target.value;
//       console.log(newPrice);
//       price.innerText = newPrice;
//     })
//   }
// } 
 
    const changeLineQuantity = () => {

      const linesPrices = document.querySelectorAll(".line_price");
      const total_price = document.querySelector(".total_price");







      const incrementers = document.querySelectorAll(".increment");
      incrementers.forEach(increment => {
        increment.addEventListener("click",(event)=>{
          event.preventDefault();
          console.log(event.target.dataset.lineId)
          const quantityText = document.getElementById(`quantity_line_${event.target.dataset.lineId}`)
          const linePrice = document.getElementById(`price_line_${event.target.dataset.lineId}`)
          const quantityInput = document.getElementById(`quantity_input_line_${event.target.dataset.lineId}`)
          console.log(quantityText.innerText)
          const actualQuantity = parseInt(quantityText.innerText)
          const actualPrice = linePrice.innerText
          const unitPrice = quantityText.dataset.mealPriceCents/100
          console.log(unitPrice)
          console.log(actualPrice)
          const newQuantity = actualQuantity+parseInt(event.target.dataset.value)
          console.log(newQuantity)
          quantityText.innerText = newQuantity
          linePrice.innerText = parseInt(actualPrice)+(parseInt(event.target.dataset.value)*unitPrice)
          quantityInput.value = newQuantity
          const actualTotal = total_price.innerText
          total_price.innerText = parseInt(actualTotal)+(parseInt(event.target.dataset.value)*unitPrice)
          console.log(quantityText.innerText === quantityInput.value )
        });
      });      

    };
// function openNav() {
//   if (document.getElementById("myNav")) {
//     document.getElementById("myNav").style.display = "block";
//   };
// }

/* Close */



export {changeLineQuantity};