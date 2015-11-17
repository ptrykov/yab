class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname
end

