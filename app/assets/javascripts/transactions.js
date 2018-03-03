// An important difference between function declarations and class declarations is that 
// function declarations are hoisted and class declarations are not.

function Transaction(props) {
  this.id = props.id
  this.user_id = props.user_id
  this.wallet_id = props.wallet_id
  this.coin_id = props.coin_id
  this.amount = props.amount
  this.quantity = props.quantity
  this.price_per_coin = props.price_per_coin
  this.fee = props.fee
}

$(function() {
  $('#load_tx').on('click', function(e) {
    e.preventDefault()
    
    $.ajax({
      method: 'GET',
      url: this.href,
      dataType: "json"
    }).done(function(data) {
      debugger
      $('#load_txs').append(JSON.stringify(data)) //without JSON.stringify it does not display
    })
  })
})
