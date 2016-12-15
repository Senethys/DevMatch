/* global $, Stripe */
//Document ready. 
$(document).on('turbolinks:load'), function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');
  
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form submit buttom,
  submitBtn.click(function(event) {
    //prevent default submission behaviour
    event.preventDefault();
    submitBtn.val("Processing").prop("disabled", true);
    //Collect the credit card fields
    var ccNumber = $('#card_number').val(),
      secCode = $('#card_code').val(),
      cardY = $('#card_year').val(),
      cardM = $('#card_month').val();
      
      //Use Stripe JS lib to check for card erros.
      var error = false;
      
      //Validate card number.
      if(!Stripe.card.validateCardnumber(ccNumber)) {
        error = true;
        alert('The credit card seems to be invalid');
      }
      
       //Validate CVC number.
      if(!Stripe.card.validateCVC(secCode)) {
        error = true;
        alert('The credit card CVC seems to be invalid');
      }
      
       //Validate expiration date.
      if(!Stripe.card.validateExpiry(cardM, cardY)) {
        error = true;
        alert('The expidation date seems to be invalid');
      }
  
      if (error) {
        //If there are card errors, don't send to Stripe.
        submitBtn.prop('disabled', false).val("Sign Up");
      } else {
      //Send to card info to Stripe.
        Stripe.createToken({
        number: ccNumber,
        cvc: secCode,
        exp_month: cardM,
        exp_year: cardY
      }, stripeResponseHandler);
      //exit function
    }
    return false;
  });
  
  //Stripe will return a card token.
  function stripeResponseHandler(status, response) {
  //Get the token from the response.
    var token = response.id;
    //Injekt card token as hidden field into form 
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    //Submit form to Rails app
    theForm.get(0).submit();
  }
};