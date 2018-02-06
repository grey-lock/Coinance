class TransactionsController < ApplicationController
  before_action :authenticate_user!, :set_tx
  
  def index
    @transactions = current_user.transactions
  end
  
  def show
    @transaction = Transaction.find(params[:id]) 
  end
  
  def new
    @transaction = Transaction.new
  end
  
  def create
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.transaction_params = params[:transaction]
    @transaction.coin = Coin.new
    
    # Split the coin name at parentheses
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    
    # Assign the params to the coin
    @transaction.coin.name = coin_name
    @transaction.coin.symbol = coin_symbol
    coin_price = CryptocompareApi.last_known_value(coin_symbol) if params[:transaction][:coin]
  
    @transaction.coin.last_known_value = coin_price if coin_price
    
    if @transaction.valid?
      @transaction.save
      flash[:success] = "Transaction successfully added!"
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      redirect_to new_user_transaction_path(current_user)
    end
  end
  
  def update
    @transaction = current_user.transactions.find(params[:id])
    @transaction.transaction_params = params[:transaction]
    
    # Split the coin name at parentheses
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    
    # Assign the params to the coin
    @transaction.coin.update(name: coin_name)
    @transaction.coin.update(symbol: coin_symbol)
    coin_price = CryptocompareApi.last_known_value(coin_symbol) if params[:transaction][:coin]
  
    @transaction.coin.update(last_known_value: coin_price) if coin_price
    
    if @transaction.valid?
      @transaction.save
      flash[:success] = "Transaction successfully updated!"
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      redirect_to 'transactions/edit'
    end
  end
  
  def destroy
    @transaction = current_user.transactions.find_by(id: params[:id])
    # binding.pry
    if @transaction.user_id == current_user.id
      flash[:success] = "Transaction deleted!"
      @transaction.destroy 
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = "Unauthorized action! The administrator has been notified."
      redirect_to user_transaction_path(current_user, @transaction)
    end
  end
  
  private
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id, coin: [:name, :symbol, :last_known_value])
  end
  
end
