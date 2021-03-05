const toggleOrderCardsDetails = () => {
  const showDetailsBtns = document.querySelectorAll('.order-card-detail-btn')
  console.log(showDetailsBtns)
  if (showDetailsBtns) {
    showDetailsBtns.forEach(showDetailsBtn => {
      showDetailsBtn.addEventListener("click", (event)=>{
        event.preventDefault();
        console.log(event)
        const orderId = event.target.parentElement.dataset.orderId;
        const orderLine = document.getElementById(`order-lines-${orderId}`);
        console.log(orderId)
        orderLine.classList.toggle("d-block");
        showDetailsBtn.classList.toggle("active");
      });
    });
    /* hideDetailsBtns.forEach(hideDetailsBtn => {
      hideDetailsBtn.addEventListener("click",(event)=>{
        event.preventDefault();
        const orderId = event.path[1].dataset.orderId;
        const orderLine = document.getElementById(`order-lines-${orderId}`);
        orderLine.style.display = "none";
        console.log(orderId)
      });
    }); */



  };
};


export {toggleOrderCardsDetails};
