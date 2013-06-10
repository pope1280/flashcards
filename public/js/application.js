$(document).ready(function() {
  $('.add_card').on('click', function(e){
    e.preventDefault();
    $.ajax({
      method: 'post',
      url: $('.add_cards_to_deck').attr('action'),
      data: $('#card_adder').serialize()
    }).done(function(response){
      parseResponse(response);
    });
  });
  $('.unselected').on('click', function(){
    switchSelected();
    switchInfo();
  });
  $('.selected').on('click', function(){
    switchSelected();
    switchInfo();
  });
}); //document ready

function parseResponse(response) {
  if(response['success'] === true )
  {
      //refactor this at some point
      $('.add-cards-container').prepend('<div class="saved-card">Card Successfully Saved</div>');
      $('.errors').empty();
      resetForm('add_cards_to_deck');
      addNewCardToList('current_cards-list', response['card']['card']['question']);
      $('.current_cards-list').effect('highlight');
      $('.saved-card').fadeOut(5000);
    }
    else
    {
      // refactor this at some point too
      $('.errors').empty();
      $('.errors').append('<li>Sorry! Question or answer fields can\'t be blank!</li>');
      $('.add_cards_to_deck').effect('shake');
      resetForm('add_cards_to_deck');
    }
}

function addNewCardToList(list, item) {
  $('.'+list).append('<li>' + item + '</li>');
}

function switchSelected(){
  var unselected = $('.unselected');
  var selected = $('.selected');
  unselected.removeClass('unselected');
  unselected.addClass('selected');
  selected.removeClass('selected');
  selected.addClass('unselected');
}

function switchInfo(){
  var view = $('.selected a').attr('href');
  console.log(view);
  if(view === '#stats')
  {
    $('.decks').hide(100, function(){
      $('.stats').show(100);
    });
  }
  else
  {
    $('.stats').hide(100, function(){
    $('.decks').show(100);
    });
  }

}

function resetForm(klass) {
$('.'+klass).each(function(){
  this.reset();
  });
}


