    const changeLineQuantity = () => {
      
      const incrementers = document.querySelectorAll(".increment")
        if (incrementers) {
          incrementers.forEach(incrementer => {
            incrementer.addEventListener("click", (event)=>{
              event.preventDefault();
              console.log(event)
              const lineId = incrementer.dataset.lineId;
              const lineQty = document.getElementById(`quantity_line_${lineId}`);
              const inputQty = document.getElementById(`quantity_input_line_${lineId}`);
              const linePrice = document.getElementById(`price_line_${lineId}`);
              const lineSubtotal = document.getElementById('subtotal-amount');
              const lineTotal = document.getElementById('total_line_amount_cents');
              const unitPrice = parseInt(linePrice.dataset.mealPriceCents)
              const actualPrice = parseInt(linePrice.dataset.amountCents)
              const actualQuantity = parseInt(lineQty.dataset.actualQuantity)
              // delivery mode is either delivery or C&C so querySelector is OK
              const deliveryMode = document.querySelector('input[name="order[delivery_type]"]:checked').value;
              // increment value is either +1 or -1
              const incrementValue = parseInt(event.target.dataset.value);
              // calculer le nouveaux prix
              const incrementedPrice = actualPrice+(unitPrice*incrementValue)
              linePrice.dataset.amountCents = incrementedPrice
              linePrice.innerText = incrementedPrice/100
              //calculer la nouvelle quantoty
              const incrementedQuantity = actualQuantity + incrementValue
              lineQty.dataset.actualQuantity = incrementedQuantity
              lineQty.innerText = incrementedQuantity;
              // mettre a jour la quantité dns l'input cache de la ligne modifiee
              inputQty.value = incrementedQuantity;
              // mettre a jour les totaux
              updateTotals();
            });
          });
        };
      };

      const updatedSubtotal = () => {
        const priceLines = document.querySelectorAll(".line_price");
        let subtotal = 0; 
        priceLines.forEach(priceLine => {
          const lineTotal = parseInt(priceLine.dataset.amountCents)
          subtotal += lineTotal
        });
        return subtotal
      };

      const updateTotals = () => {
        const lineSubtotal = document.getElementById('subtotal-amount');
        const lineTotal = document.getElementById('total_line_amount_cents');
        const deliveryMode = document.querySelector('input[name="order[delivery_type]"]:checked').value;
        const deliveryFeeLine = document.getElementById('delivery_fee_amount_cents');
        const deliveryFee = parseInt(deliveryFeeLine.dataset.amountCents);
        const deliveryModeInput = document.getElementById("delivery-type");
        const deliveryFeeInput = document.getElementById("delivery-fee");
        const stripeBtn = document.getElementById("stripe-button");
        const actualDeliveryFee = deliveryMode === "Delivery" ? deliveryFee : 0;
        // update subtotal
        deliveryFeeLine.innerText = actualDeliveryFee/100
        lineSubtotal.dataset.amountCents = updatedSubtotal();
        lineSubtotal.innerText = (lineSubtotal.dataset.amountCents)/100;
        lineTotal.dataset.amountCents = updatedSubtotal()+actualDeliveryFee;
        lineTotal.innerText = (lineTotal.dataset.amountCents)/100;
        // update deliveryMode input
        deliveryModeInput.value = deliveryMode;
        deliveryFeeInput.value = deliveryFee;
        // update the stripe btn amount for form submission
        stripeBtn.dataset.amount = lineTotal.dataset.amountCents;
      };



export {changeLineQuantity};
export {updatedSubtotal};
export {updateTotals};

