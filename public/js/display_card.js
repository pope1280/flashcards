$(document).ready(function() {
  var card = $("#card");
  var flip = $("#flip_button");
  var form = $("#guess_form");

  form.on("submit", function(e) {
    e.preventDefault();

    card.toggleClass("flipped");
    flip.attr("disabled", true);

    $.ajax({
      type: 'post',
      url:  '/guesses',
      data: $(this).serialize(),
      dataType: 'json'
    }).done(function(data) {
      var guess = data.guess;
      var nextCard = data.card.card;
      var deckTopic = $("#card_question");
      var guessBox = $("#guess_box");

      if (guess === "correct")
        {
        color = "black";
        alert = "Correct!!!";
        }
      else
        {
        color = "red";
        alert = "Wrong :-/";
        }

      var message = $('h2');

      message.text(alert).css("color", color).hide();
      message.slideDown();

      setTimeout(function() {
        message.fadeIn();
      }, 1000);

      setTimeout(function() {
        message.slideUp("slow");
        card.toggleClass("flipped");
      }, 2000);


      if (data.status) {
        setTimeout(function() {
          window.location.href = data.redirect;
        }, 3000);
      }
      else {
        setTimeout(function() {
          flip.attr("disabled", false);
          guessBox.val("");
          deckTopic.text(nextCard.question);
          card.find(".back").text(""+nextCard.answer+"");
          form.find("#card_id").attr('value', nextCard.id);
        }, 3000);
      }
    });
  });
});