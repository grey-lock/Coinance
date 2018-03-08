class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @wallets = current_user.wallets
    @txs = current_user.transactions
    respond_to do |f|
      f.html { render :show}
      f.json { render json: @wallets,
                      json: @txs
      }
    end
  end
  
end