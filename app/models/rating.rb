class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :user_post_rating, on: :create

  private

  def user_post_rating
    if Rating.where(user_id: user_id, post_id: post_id).present?
      errors.add(:duplicate, 'User cannot rate one post twice')
    end
  end
end
