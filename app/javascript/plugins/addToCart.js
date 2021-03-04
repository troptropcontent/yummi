const addToCart = () => {
  const addToCartBtns = document.querySelectorAll('.meal-card-action');
  if (addToCartBtns) {
    addToCartBtns.forEach(addToCartBtn => {
      addToCartBtn.addEventListener("click",(event)=>{
        event.preventDefault();
        const mealId = event.target.dataset.mealId
        console.log(mealId);
        const otherMealInput = document.getElementById(`other_meal_added_to_basket_${mealId}`);
        const otherMealCard = document.getElementById(`other-course-meal-id-${mealId}`);
        const mealAddedToCart = event.target.innerText === "Added to cart"
        
        mealAddedToCart ? otherMealInput.value=0 : otherMealInput.value=1 
        console.log(otherMealInput.value)
        otherMealCard.classList.toggle("added-to-cart");
      });
    });
  };
};

export { addToCart };