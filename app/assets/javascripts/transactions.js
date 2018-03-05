// An important difference between function declarations and class declarations is that 
// function declarations are hoisted and class declarations are not.

function Transaction(prop) {
  this.id = prop.id
  this.user_id = prop.user_id
  this.wallet_id = prop.wallet_id
  this.coin_id = prop.coin_id
  this.amount = prop.amount
  this.quantity = prop.quantity
  this.price_per_coin = prop.price_per_coin
  this.fee = prop.fee
}

$(function() {
  $('#load_tx').on('click', function(e) {
    e.preventDefault()
    
    $.ajax({
      method: 'GET',
      url: this.href,
      dataType: 'json'
    }).done(function(resp) {
      // debugger
      $('#load_txs').append(JSON.stringify(resp)) //without JSON.stringify it doesn't display
      
    })
  })
})

$(function() {
  $('.list-group-item').on('click', function(e) {
    e.preventDefault()
    
    $.ajax({
      method: 'GET',
      url: this.href,
      dataType: 'json'
    }).done(function(resp) {
      var id = resp.id
      var source = $('#tx-show-template').html()
      var template = Handlebars.compile(source)
      var context = resp
      var html = template(context)
      
      $(`#${id}`).append(html)
    })
    $(this).off("click");
  })
})

$(function() {
  $('#tx_submit').on('submit', function(e) {
    e.preventDefault()
    
  })
})