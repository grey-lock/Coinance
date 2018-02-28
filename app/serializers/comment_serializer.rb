class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note
  belongs_to :transaction
end
