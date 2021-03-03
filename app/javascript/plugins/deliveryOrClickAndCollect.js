const deliveryOrClickAndCollect = () => {

  const delivery = document.querySelector(".delivery-wrapper");

  console.log(delivery)
  
  if (delivery) {
    delivery.addEventListener("change", (event)=>{
      console.log(event.target.defaultValue)
      console.log(event)
      const address = document.querySelector('.delivery-address')
      address.classList.toggle("delivery-mode-delivery")
      const deliveryHiddenInput = document.getElementById("delivery-type")
      deliveryHiddenInput.value = event.target.defaultValue
      console.log(deliveryHiddenInput)
      const deliveryFee = document.getElementById("delivery_fee_amount_cents")
      const deliveryFeeAmount = event.target.defaultValue === "delivery" ? parseInt(deliveryFee.dataset.amountCents) : 0
      console.log(deliveryFeeAmount) 
      const deliveryFeeHiddenInput = document.getElementById("delivery-fee")
      deliveryFeeHiddenInput.value = deliveryFeeAmount
      console.log(deliveryFeeHiddenInput.value)
      
      })
  };

};


export { deliveryOrClickAndCollect };