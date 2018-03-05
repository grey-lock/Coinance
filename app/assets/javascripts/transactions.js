// An important difference between function declarations and class declarations is that 
// function declarations are hoisted and class declarations are not.

function Transaction(prop) {
  this.id = prop.id
  this.user.id = prop.user.id
  this.wallet.id = prop.wallet.id
  this.coin.id = prop.coin.id
  this.amount = prop.amount
  this.quantity = prop.quantity
  this.price_per_coin = prop.price_per_coin
  this.fee = prop.fee
  this.comment = prop.comment
}

// Loads and renders a wallets index of transactions
$(function() {
  $('#load_tx').on('click', function(e) {
    e.preventDefault()
    
    $.ajax({
      method: 'GET',
      url: this.href,
      dataType: 'json'
    }).done(function(resp) {
      var id = resp.id
      var source = $('#wallet-tx-list-template').html()
      var template = Handlebars.compile(source)
      var context = resp
      var html = template(context)
      $('#load_txs').append(html)
    })
  })
})

// Loads and renders a Transactions details show item on the transactions index page
$(function() {
  $('#tx_list > .list-group-item').on('click', function(e) {
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

// This function will retrieve a new transaction form and render it
$(function() {
  $('#add_tx').on('click', function(e) {
    e.preventDefault()
    var source = $('#new-tx-form-template').html()
    var template = Handlebars.compile(source)
    var newForm = template()
    
    $('#tx_list').before(function() {
      debugger
      this.append(newForm)
    })
  })
})

$(function() {
  $('#tx_submit').on('submit', function(e) {
    e.preventDefault()
    alert('Clicked submit!')
  })
})