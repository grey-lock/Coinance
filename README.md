# Coinance

Coinance is a Ruby on Rails web application that allows you to to manage a portfolio of your digital currency assets and investments.

* Live demo deployed to [Heroku](https://coinance.herokuapp.com)
* Users can create an account to store data on transactions and wallets where they have any cryptocurrencies.
* Leverages the [Cryptocompare API](https://www.cryptocompare.com/api/) to retrieve real-time info & price data on 2,000+ cryptocurrencies and tokens.
* Users can save a transaction or a wallet by selecting from a real-time list of digital currencies and tokens to save to the database.
* Coins are selected in real-time, and persisted to the database as an associated coin to either a wallet, or a transaction.
* Users can submit their own prices if purchased at a different time for their own transactions/wallets.
* User sign-in, sign-out, and session security is handled with Devise [Devise](https://github.com/plataformatec/devise)
* Users can log in with Facebook using [Omniauth](https://github.com/omniauth/omniauth)
* Displays updated price data on Bitcoin, Ethereum, and Litecoin on the Coin index page.
* Displays stats on the Coins saved with the most transactions.
* Users can ONLY create, read, update, or delete their own transactions and wallets.
* All user data is validated using ActiveRecord ORM & Rails model validations.
* Database schema is created in PostgresQL.
* Styled custom SCSS with an open-source [Bootstrap theme](https://bootswatch.com/lux/).

## Installation

Fork and clone this repository, and then execute:

    $ bundle install

    $ rake db:migrate

Then run:

    $ rails s

Open up a new browser window and navigate to:

    localhost:3000
    
# Models

This app uses 5 ActiveRecord Models: ```User, Coin, Wallet, Transaction, and CryptocompareApi```. The join table is ```Transaction```.

User:
  ```
  has_many :transactions
  has_many :coins, through: :transactions
  has_many :wallets
  ```
  
Coin:
  ```
  has_many :transactions
  has_many :users, through: :transactions
  has_many :wallets
  
  validates :name, :symbol
  ```
  
Wallet:
  ```
  belongs_to :user
  belongs_to :coin
  
  validates :name, :coin_amount, :user_deposit (presence, and greater than 0)
  ```
  
Transaction:
  ```
  belongs_to :user
  belongs_to :coin
  
  validates :amount, :quantity, :price_per_coin, :fee (presence, and greater than 0)
  ```
  
Cryptocompare API:
  
  ```
  Uses custom methods, to parse real-time price data, symbols, coin names, and coin IDs.
  ```
  
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TheInvalidNonce/coinance. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
