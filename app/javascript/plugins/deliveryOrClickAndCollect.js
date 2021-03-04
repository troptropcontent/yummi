import {updatedSubtotal} from "../plugins/priceCalculator";
import {updateTotals} from "../plugins/priceCalculator";

const deliveryOrClickAndCollect = () => {

  const delivery = document.querySelector(".delivery-wrapper");

  console.log(delivery)
  
  if (delivery) {
    delivery.addEventListener("change", (event)=>{
      console.log(event.target.defaultValue)
      console.log(event)
      const address = document.querySelector('.delivery-address')
      address.classList.toggle("delivery-mode-delivery")
      updateTotals();
      })
  };

};


export { deliveryOrClickAndCollect };