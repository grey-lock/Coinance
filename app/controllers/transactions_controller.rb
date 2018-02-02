class TransactionsController < ApplicationController
  
  def index
    @transactions = current_user.transactions
  end
  
  def show
    set_tx
  end
  
  def new
    @transaction = Transaction.new
  end
  
  def create
  
  end
  
  private
  
  def set_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:amount, :quantity, :price_per_coin, :fee, :coin_id)
  end
  
end
