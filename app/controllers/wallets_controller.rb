class WalletsController < ApplicationController
  before_action :authenticate_user!, :set_wallet
  
  def index
    @wallets = current_user.wallets
  end
  
  def show
    @wallet = Wallet.find(params[:user_id])
  end
  
  def new
    @wallet = Wallet.new
  end
  
  def create
    @wallet = current_user.wallets.build(wallet_params)
    @wallet.coin = Coin.new
    @wallet.coin.name = params[:wallet][:coin].scan(/\w+(?!\w|\()/)[0]
    @wallet.coin.symbol = params[:wallet][:coin].scan(/\w+(?!\w|\()/)[1]
    
    @wallet.coin.last_known_value = CryptocompareApi.last_known_value(params[:wallet][:coin].scan(/\w+(?!\w|\()/)[1]) if params[:coin]
    
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
  
  def update
    user_is_current_user
    # Check if the wallet belongs to the user
      @wallet.wallet_params = params[:wallet]
    
      # Split the coin name at parentheses
      coin_info = params[:wallet][:coin].split(" ")
      coin_name = coin_info[0...-1].join(" ")
      coin_symbol = coin_info[-1].scan(/\w+(?!\w|\()/)[0]
    
      # Assign the params to the coin
      @wallet.coin.update(name: coin_name)
      @wallet.coin.update(symbol: coin_symbol)
      coin_price = CryptocompareApi.price_from_to(coin_symbol) if params[:wallet][:coin]
    
      @wallet.coin.update(last_known_value: coin_price) if coin_price
        # binding.pry
      if @wallet.valid? && @wallet.user == current_user
        @wallet.save
        flash[:success] = "Wallet successfully updated!"
        redirect_to user_wallets_path(current_user)
      else
        flash[:alert] = @wallet.errors.full_messages.to_sentence
        redirect_to user_wallets_path(current_user, @wallet)
      end
  end
  
  def destroy
    @wallet = current_user.wallets.find_by(id: params[:id])
    # binding.pry
    if @wallet.user_id == current_user.id
      flash[:success] = "Wallet deleted!"
      @wallet.destroy 
      redirect_to user_wallets_path(current_user)
    else
      flash[:alert] = "Unauthorized action! The administrator has been notified."
      redirect_to user_wallet_path(current_user, @wallet)
    end
  end
  
  
  private
  
  def user_is_current_user
    unless current_user.id == params[:user_id].to_i
      flash[:alert] = "You may only view your own wallets."
      redirect_to root_path
    end
  end
  
  def set_wallet
    @wallet = Wallet.find_by(id: params[:id])
  end
  
  # Require wallet params, as well as user_id & coin_id
  def wallet_params
    params.require(:wallet).permit(:name, :coin_amount, :user_deposit, :net_value, :coin_id, coin_attributes: [:name, :symbol, :last_known_value])
  end
  
  
end
