class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :transaction_id, :created_at, :updated_at
  belongs_to :transaction
end
