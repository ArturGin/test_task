class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :created_at, :updated_at
end
