# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
  - Clicking on a transaction in the index will load the individual show info for that item.
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
  - Clicking on a wallet or transaction in users/show will render a list of either transactions or wallets
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
  - Users show will show a transactions index when the user clicks their transactions
  - Users show will show a wallets index when the user clicks their wallets
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.
  - Transaction index load a form to create a new transaction and append it to the DOM list of transactions.
- [x] Translate JSON responses into js model objects.
  - New transaction object will be instantiated and then appended to the DOM
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
  - One function renders the newly made Transaction to the DOM

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message