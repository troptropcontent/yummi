

const checkoutStripeCustom = () => {
  function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
      if ((new Date().getTime() - start) > milliseconds){
        break;
      }
    }
  }



  const stripeBtn = document.getElementById("stripe-button")
  if (stripeBtn) {
    var handler = StripeCheckout.configure({
      key: stripeBtn.dataset.key,
      image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
      locale: 'auto',
      token: function(token) {
        // You can access the token ID with `token.id`.
        // Get the token ID to your server-side code for use.
      }
    });
    
    document.getElementById('customButton').addEventListener('click', function(e) {
      // Open Checkout with further options:
      handler.open({
        name: 'Stripe.com',
        description: 'Your order',
        amount: stripeBtn.dataset.amount,
        closed: ()=>{
          const form = stripeBtn.closest('form')
          form.submit()
        },
      });

      // sleep(3000)
      e.preventDefault();
    });
    
    // Close Checkout on page navigation:
    window.addEventListener('popstate', function() {
      handler.close();
    });    
  };
};

export { checkoutStripeCustom };