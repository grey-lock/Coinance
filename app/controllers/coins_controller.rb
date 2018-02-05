class CoinsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end
  
  def show
    @most_transactions = Coin.most_transactions
  end
end
