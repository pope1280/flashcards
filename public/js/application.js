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
  $('.profile-tabs').on('click', function(){
    navigateTabs(this);
  });
}); //document ready

function parseResponse(response) {
  if(response['success'] === true )
  {
      //refactor this at some point
      $('.container').prepend('<div class="saved-card">Card Successfully Saved</div>');
      $('.errors').empty();
      resetForm('add_cards_to_deck');
      addNewCardToList('current_cards-list', response['card']['card']['question']);
      $('.current_cards-list').effect('highlight');
      $('.saved-card').fadeOut(2000);
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
function resetForm(klass) {
$('.'+klass).each(function(){
  this.reset();
  });
}

function navigateTabs(list) {
  var elements = [];
  $('.profile-tabs').each(function() {
    elements.push($(this).html());
    for(var i = 0; i < elements.length; i ++)
      {
        console.log(elements[i]);

      }
  });
}