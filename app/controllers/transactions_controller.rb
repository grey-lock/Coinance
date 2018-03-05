class TransactionsController < ApplicationController
  # Authenticate the user has logged in before all actions 
  # Set the @transaction object before the action so the form can load properly based on the route
  # Check if the current_user is the user that owns the transaction
  before_action :authenticate_user!, :set_tx
  before_action :user_is_current_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # Find tx of the current_user 
    @transactions = current_user.transactions
    
    respond_to do |f|
      # binding.pry
      f.html { render :index }
      f.json { render json: @transactions }
    end
    
  end
  
  def show
    @transaction = Transaction.find_by(id: params[:id])
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @transaction }
    end
  end
  
  def new
    @transaction = Transaction.new
    @wallet = Wallet.new
    
    respond_to do |f|
      f.html { render :new, layout: false }
      f.json { render json: @transaction }
    end
  end
  
  def create
    @transaction = current_user.transactions.build(transaction_params)
    
    # Split the coin name at parentheses
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    coin_price = CryptocompareApi.last_known_value(coin_symbol) if params[:transaction][:coin]
    coin_id = CryptocompareApi.find_coin_id(coin_symbol)
    
    # Create the coin to associate
    @transaction.coin = Coin.find_or_create_by(
                            name: coin_name, 
                            symbol: coin_symbol, 
                            last_known_value: coin_price,
                            id: coin_id)
    
    if @transaction.valid? && @transaction.coin.valid?
      @transaction.save
      @transaction.coin.save
      flash[:success] = "Transaction successfully added!"
      respond_to do |f|
        f.html { redirect_to user_transactions_path(current_user) }
        f.json { render json: @transaction }
      end
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      # Redirect preserves the visual formatting
      respond_to do |f|
        f.html { redirect_to new_user_transaction_path(current_user)}
        f.json { render json: @transaction }
      end
    end
  end
  
  def update
    @transaction.update(transaction_params)
    
    # Split the coin name
    coin_info = params[:transaction][:coin].split(" ")
    coin_name = coin_info[0...-1].join(" ")
    coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    coin_price = CryptocompareApi.last_known_value(coin_symbol) if params[:transaction][:coin]
    coin_id = CryptocompareApi.find_coin_id(coin_symbol)
    
    # Update the coin
    @transaction.coin = Coin.find_or_create_by(
                            name: coin_name, 
                            symbol: coin_symbol, 
                            last_known_value: coin_price,
                            id: coin_id)
    binding.pry
    if @transaction.valid? && @transaction.user == current_user
      @transaction.save
      flash[:success] = "Transaction successfully updated!"
      respond_to do |f|
        f.html { redirect_to user_transactions_path(current_user) }
        f.json { render json: @transaction }
      end
    else
      flash[:alert] = @transaction.errors.full_messages.to_sentence
      # Redirect preserves the visual formatting
      respond_to do |f|
        f.html { redirect_to user_transaction_path(current_user, @transaction)}
        f.json { render json: @transaction }
      end
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
