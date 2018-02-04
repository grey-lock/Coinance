class TransactionsController < ApplicationController
  before_action :authenticate_user!, :set_tx
  
  def index
    @transactions = current_user.transactions
  end
  
  def show
    @transaction = current_user.transactions.find_by(id: params[:id])
  end
  
  def new
    @transaction = Transaction.new
    @transaction.coin = Coin.new
  end
  
  def create
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.transaction_params = params[:transaction]
    
    if @transaction.valid?
      @transaction.save
      flash[:success] = "Transaction successfully added!"
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = "Transaction failed to save. Did you enter valid values?"
      redirect_to new_user_transaction_path(current_user)
    end
  end
  
  private
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id, coin_attributes: [:name, :symbol, :last_known_value])
  end
  
end
