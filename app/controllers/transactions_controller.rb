class TransactionsController < ApplicationController
  before_action :set_user_tx
  
  def index
    @transactions = current_user.transactions
  end
  
  def show
    
  end
  
  private
  
  def set_user_tx
    @transaction = Transaction.find_by(id: params[:id])
  end
  
end
