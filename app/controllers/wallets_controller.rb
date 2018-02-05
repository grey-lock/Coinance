class WalletsController < ApplicationController
  before_action :authenticate_user!, :set_wallet
  
  def index
    @wallets = current_user.wallets
  end
  
  def show
    @wallet = current_user.wallets.find_by(id: params[:id])
  end
  
  def new
    @wallet = Wallet.new
  end
  
  def create
    @wallet = current_user.wallets.build(wallet_params)
    @wallet.coin = Coin.new
    @wallet.coin.name = params[:wallet][:coin].scan(/\w+(?!\w|\()/)[0]
    @wallet.coin.symbol = params[:wallet][:coin].scan(/\w+(?!\w|\()/)[1]
    
    @wallet.coin.last_known_value = CryptocompareApi.last_known_value(params[:wallet][:coin].scan(/\w+(?!\w|\()/)[1])
    
    # @wallet.wallet_params = params[:wallet]
    if @wallet.valid?
      @wallet.save
      flash[:success] = "Wallet successfully added!"
      redirect_to user_wallets_path(current_user)
    else
      flash[:alert] = @wallet.errors.full_messages.to_sentence
      redirect_to new_user_wallet_path(current_user)
    end
  end
  
  
  private
  
  def set_wallet
    @wallet = Wallet.find_by(id: params[:id])
  end
  
  # Require wallet params, as well as user_id & coin_id
  def wallet_params
    params.require(:wallet).permit(:name, :coin_amount, :user_deposit, :net_value, :coin_id, coin_attributes: [:name, :symbol, :last_known_value])
  end
  
  
end
