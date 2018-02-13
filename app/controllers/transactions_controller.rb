class TransactionsController < ApplicationController
  # Authenticate the user has logged in before all actions 
  # Set the @transaction object before the action so the form can load properly based on the route
  # Check if the current_user is the user that owns the transaction
  before_action :authenticate_user!, :set_tx
  before_action :user_is_current_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # Find all of the current_user transactions
    @transactions = current_user.transactions
  end
  
  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def new
    @transaction = Transaction.new
    @wallet = Wallet.new
  end
  
  def create
      # binding.pry
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.coin = Coin.new
    
    # Split the coin name at parentheses
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    coin_price = CryptocompareApi.last_known_value(coin_symbol) if params[:transaction][:coin]
  
    # Assign the params to the coin
    @transaction.coin.name = coin_name
    @transaction.coin.symbol = coin_symbol
    @transaction.coin.last_known_value = coin_price if coin_price
    
    if @transaction.valid?
      @transaction.save
      flash[:success] = "Transaction successfully added!"
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      # Redirect preserves the visual formatting
      redirect_to new_user_transaction_path(current_user)
    end
  end
  
  def update
    # binding.pry
    @transaction.update(transaction_params)
    # @wallet.update(wallet_params)
    
    # Split the coin name at parentheses
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    
    # Assign the params to the coin
    @transaction.coin.update(name: coin_name)
    @transaction.coin.update(symbol: coin_symbol)
    coin_price = CryptocompareApi.price_from_to(coin_symbol) if params[:transaction][:coin]
    
    @transaction.coin.update(last_known_value: coin_price) if coin_price
    
    if @transaction.valid? && @transaction.user == current_user
      @transaction.save
      flash[:success] = "Transaction successfully updated!"
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      # Redirect preserves the visual formatting
      redirect_to user_transaction_path(current_user, @transaction)
    end
  end
  
  def destroy
    @transaction = current_user.transactions.find_by(id: params[:id])
    
    if @transaction.user_id == current_user.id
      flash[:success] = "Transaction deleted!"
      @transaction.destroy 
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = "Unauthorized action! The administrator has been notified."
      # Redirect preserves the visual formatting
      redirect_to user_transaction_path(current_user, @transaction)
    end
  end
  
  private

  def user_is_current_user
    unless current_user.id == params[:user_id].to_i
      flash[:alert] = "You may only view your own transactions."
      redirect_to root_path
    end
  end
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id, coin: [:name, :symbol, :last_known_value], wallet: [:id, :name, :coin_amount, :user_deposit])
  end
  
end
