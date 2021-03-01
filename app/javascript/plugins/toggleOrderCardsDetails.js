const toggleOrderCardsDetails = () => {
  const showDetailsBtns = document.querySelectorAll('.order-card-detail-btn')
  const hideDetailsBtns = document.querySelectorAll('.order-card-details-expanded-bottom')
  console.log(showDetailsBtns)
  if (showDetailsBtns) {
    showDetailsBtns.forEach(showDetailsBtn => {
      showDetailsBtn.addEventListener("click", (event)=>{
        event.preventDefault();
        console.log(event)
        const orderId = event.path[1].dataset.orderId;
        const orderLine = document.getElementById(`order-lines-${orderId}`);
        console.log(orderId)
        orderLine.style.display = "block";
      });
    });
    hideDetailsBtns.forEach(hideDetailsBtn => {
      hideDetailsBtn.addEventListener("click",(event)=>{
        event.preventDefault();
        const orderId = event.path[1].dataset.orderId;
        const orderLine = document.getElementById(`order-lines-${orderId}`);
        orderLine.style.display = "none";
        console.log(orderId)
      });
    });



  };
};


export {toggleOrderCardsDetails};