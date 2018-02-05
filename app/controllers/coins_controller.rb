class CoinsController < ApplicationController
  before_action :authenticate_user!
  
  def index
     @most_transactions = Coin.most_transactions
  end
  
  def show
   
  end
 
end
