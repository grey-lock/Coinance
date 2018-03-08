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
  this.created_at = prop.created_at
  this.updated_at = prop.updated_at
  
}

// Upon successful form submission, append new item to the template
Transaction.prototype.renderTx = function () {
  // debugger
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
        deleteForm()
        // console.log("tx: ", tx)
        var listTx = tx.renderTx()
        $('#tx-list').before((listTx))
      })
  })
}

// Model object method to compile the handlebars templates
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
  $('#tx-list > .list-group-item').on('click', function(e) {
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
  
// This deletes the new tx form on form submit
function deleteForm(){
    $("#new_transaction").empty();
}

// This will ready all of the templates on document.ready
$(function() {
  Transaction.ready()
})
