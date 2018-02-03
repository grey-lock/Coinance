class WalletsController < ApplicationController
  before_action :authenticate_user!
  
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
      flash[:notice] = "Wallet successfully created!"
      redirect_to user_wallets_path
    else
      flash[:alert] = "Wallet failed to create!"
      render :new
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
