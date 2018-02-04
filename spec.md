# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
  - User has_many transactions, wallets
  - Coin has_many transactions, wallets
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  - Transaction belongs_to coin, user
  - Wallet belongs_to user, coin
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  - Coin has_many :users, through: :transactions
  - User has_many :coins, through: :transactions
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
  - User can submit a transaction that has an amount, fee, quantity, price_per_coin. The transaction has attributes and belongs to a specific user
  - User can submit a wallet that has a name, coin_amount, user_deposit, and a net_value. The wallet has attributes and belongs to a specific user
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  - Coin: validates name, symbol presence/uniqueness, User: validates email, passsword thru devise, Transaction: validates amount, fee, quantity, price_per_coin
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  - 
- [ ] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
  -
- [x] Include signup (how e.g. Devise)
  - Devise works
- [x] Include login (how e.g. Devise)
  - Devise works
- [x] Include logout (how e.g. Devise)
  - Devise works
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  - Facebook omniauth works
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  - users/1/transactions, users/2/wallets
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
  - users/1/transactions/new, users/2/wallets/new
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
