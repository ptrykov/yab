class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  has_one :user, serializer: Api::V1::UserSerializer
end
