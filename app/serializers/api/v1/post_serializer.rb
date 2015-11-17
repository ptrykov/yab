class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_one :user, serializer: Api::V1::UserSerializer
end
