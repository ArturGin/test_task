class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :user_post_rating, on: :create
  validates :value, presence: true

  private

  def user_post_rating
    errors.add(:duplicate, 'User cannot rate one post twice') if Rating.where(user_id: user_id,
                                                                              post_id: post_id).present?
  end
end
