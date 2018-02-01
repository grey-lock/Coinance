class WalletsController < ApplicationController
  
  def new
    @wallet = Wallet.new
  end
  
  private
  
  # Require wallet params, as well as user_id & coin_id
  def wallet_params
    params.require(:wallet).permit(:name, :coin_amount, :user_deposit, :net_value, user_ids: [], coin_ids:[])
  end
  
  
end
