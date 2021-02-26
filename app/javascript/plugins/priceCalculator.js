const priceCalculator = () => {
  const checkOutData = document.querySelector(".checkout-data")
  if (checkOutData) {
    const lineQuantity = document.getElementById("line_quantity");
    lineQuantity.addEventListener("change",(event)=>{
      console.log(event.target.value)
      const price = document.querySelector(".price");
      const price_data = price.dataset.price;
      const newPrice = price_data/100*event.target.value;
      console.log(newPrice);
      price.innerText = newPrice;
    })
  }
}

// function openNav() {
//   if (document.getElementById("myNav")) {
//     document.getElementById("myNav").style.display = "block";
//   };
// }

/* Close */



export {priceCalculator};