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
    # @transaction.transaction_params = params[:transaction]
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.coin = Coin.new
    @transaction.coin.name = params[:transaction][:coin].scan(/\w+(?!\w|\()/)[0]
    @transaction.coin.symbol = params[:transaction][:coin].scan(/\w+(?!\w|\()/)[1]
    
    @transaction.coin.last_known_value = CryptocompareApi.last_known_value(params[:transaction][:coin].scan(/\w+(?!\w|\()/)[1]) if params[:coin]
    
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
    
  end
  
  def destroy
    
  end
  
  private
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id, coin_attributes: [:name, :symbol, :last_known_value])
  end
  
end
