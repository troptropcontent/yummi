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
      if (incrementers) {incrementers.forEach(increment => {
            increment.addEventListener("click",(event)=>{
              event.preventDefault();
              console.log(event.target.dataset.lineId)
              const quantityText = document.getElementById(`quantity_line_${event.target.dataset.lineId}`)
              const linePrice = document.getElementById(`price_line_${event.target.dataset.lineId}`)
              const quantityInput = document.getElementById(`quantity_input_line_${event.target.dataset.lineId}`)
              console.log(quantityText.innerText)
              const actualQuantity = parseInt(quantityText.innerText)
              const actualPrice = linePrice.innerText
              const unitPrice = quantityText.dataset.mealPriceCents
              console.log(unitPrice)
              console.log(actualPrice)
              const newQuantity = actualQuantity+parseInt(event.target.dataset.value)
              console.log(newQuantity)
              quantityText.innerText = newQuantity
              linePrice.innerText = Math.round((parseInt(actualPrice)+(parseInt(event.target.dataset.value)*unitPrice))*100)/100
              quantityInput.value = newQuantity
              const actualTotal = total_price.innerText
              const totalexcludingDelivery = parseInt(actualTotal*100)+(parseInt(event.target.dataset.value)*unitPrice)
              total_price.innerText = totalexcludingDelivery/100
              console.log(quantityText.innerText === quantityInput.value )
              const deliveryFee = document.getElementById("delivery_fee_amount_cents")
              const deliveryFeeAmount = parseInt(deliveryFee.dataset.amountCents)
              console.log(actualTotal)
              console.log(actualTotal*100)
              console.log(parseInt(event.target.dataset.value))
              console.log(unitPrice)
              const totalIncludingDelivery = totalexcludingDelivery + deliveryFeeAmount
              const stripeBtn = document.getElementById("stripe-button")
              console.log(stripeBtn)
              console.log(totalexcludingDelivery)
              console.log(totalIncludingDelivery)
              stripeBtn.dataset.amount = totalIncludingDelivery
              const stripeButton = document.getElementById("stripe-btn")
              console.log(stripeButton)
              console.log(stripeButton.innerHTML)
            });
          });

        };
      }
// function openNav() {
//   if (document.getElementById("myNav")) {
//     document.getElementById("myNav").style.display = "block";
//   };
// }

/* Close */



export {changeLineQuantity};

