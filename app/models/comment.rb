class Comment < ApplicationRecord
  belongs_to :user, foreign_key: "comment_id", class_name: "Transaction"
end
