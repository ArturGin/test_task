class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  attribute :user, if: :include_user?

  def user
    UserSerializer.new(object.user).as_json
  end

  def include_user?
    object.include_user
  end
end
