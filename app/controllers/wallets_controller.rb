class WalletsController < ApplicationController
  
  def index
    @wallets = current_user.wallets
  end
  
  def show
    set_wallet
  end
  
  def new
    @wallet = Wallet.new
  end
  
  def create
    @wallet = current_user.wallets.build(wallet_params)
    
    if @wallet.valid?
      @wallet.save
      flash[:notice] = "Wallet added!"
      redirect_to user_wallets_path
    else
      render user_wallets_path
    end
  end
  
  
  private
  
  def set_wallet
    @wallet = Wallet.find_by(id: params[:id])
  end
  
  # Require wallet params, as well as user_id & coin_id
  def wallet_params
    params.require(:wallet).permit(:name, :coin_amount, :user_deposit, :net_value, user_ids: [], coin_ids:[])
  end
  
  
end
