class CryptocompareApi < ApplicationRecord
  
  def self.price_from_to(crypto, fiat)
    Cryptocompare::CoinSnapshot.find("#{crypto.upcase}","#{fiat.upcase}")['Data'].values[6]['PRICE'].to_f.round(2)
  end
  
  def self.list_all_coin_symbols
    Cryptocompare::CoinList.all['Data'].keys
  end
  
end