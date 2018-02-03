class TransactionsController < ApplicationController
  
  def index
    @transactions = current_user.transactions
  end
  
  def show
    @transaction = current_user.transactions.find_by(id: params[:id])
  end
  
  def new
    @transaction = Transaction.new
  end
  
  def create
    @transaction = current_user.transactions.build(transaction_params)
    
    if @transaction.valid?
      @transaction.save
      flash[:message] = "Transaction successfully created."
      redirect_to user_transactions_path(current_user)
    else
      flash[:alert] = "Transaction failed to save."
      redirect_to new_user_transaction_path(current_user)
    end
  end
  
  private
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id)
  end
  
end
