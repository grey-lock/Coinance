// An important difference between function declarations and class declarations is that 
// function declarations are hoisted and class declarations are not.

function Transaction(prop) {
  this.id = prop.id
  this.user = prop.user
  this.wallet = prop.wallet
  this.coin = prop.coin
  this.comments = prop.comments
  this.amount = prop.amount
  this.fee = prop.fee
  this.quantity = prop.quantity
  this.price_per_coin = prop.price_per_coin
  
}

// Upon successful form submission, append new item to the template


Transaction.prototype.renderTx = function () {
  return Transaction.template(this) 
}

// This will hijack the form submission to serialize the form data and create a new object
// You need to select the empty parent container first in order to pass the 2nd arg of the new rendered form id

Transaction.formSubmitListener = function() {
  $('#new_tx_form').on('submit', '#new_transaction', function (e) { 
    e.preventDefault()
    var $form = $(this)
    var action = $form.attr('action')
    var params = $form.serialize()
    
    $.ajax({
      url: action,
      data: params,
      dataType: 'json',
      method: 'POST'
      })
      .done(function(data) {
        var tx = new Transaction(data)
        var listTx = tx.renderTx()
        $(listTx).insertBefore('#tx-list')
      })
  })
}

Transaction.ready = function() {
  Transaction.templateSource = $('#tx-list-template').html(),
  Transaction.template = Handlebars.compile(Transaction.templateSource)
  Transaction.formSubmitListener()
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
      resp = resp.tx
      
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
    const newForm = template()
    $('#new_tx_form').html(newForm)
    })
  })


$(function() {
  Transaction.ready()
})
