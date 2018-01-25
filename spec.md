# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
  - User has_many transactions, wallets
  - Coin has_many transactions, wallets
  - Wallet has_many transactions
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  - Transaction belongs_to coin, wallet, user
  - Wallet belongs_to user, coin
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  - Coin has_many :users, through: :transactions
  - User has_many :coins, through: :transactions
- [ ] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
- [ ] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [ ] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
- [x] Include signup (how e.g. Devise)
  - Devise works
- [x] Include login (how e.g. Devise)
  - Devise works
- [x] Include logout (how e.g. Devise)
  - Devise works
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  - Facebook omniauth works
- [ ] Include nested resource show or index (URL e.g. users/2/recipes)
- [ ] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
