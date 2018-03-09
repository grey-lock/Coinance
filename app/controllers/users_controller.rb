class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @wallets = current_user.wallets
    @txs = current_user.transactions
    respond_to do |f|
      f.html { render :show}
      # binding.pry
      f.json { render json: { wallets: @wallets,
                              txs: @txs}, include: [:coin, :user]
      }
    end
  end
  
end