class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :value, presence: true
  validate :user_post_rating, :value_in_range?, on: :create

  private

  def user_post_rating
    errors.add(:duplicate, 'User cannot rate one post twice') if Rating.where(user_id: user_id,
                                                                              post_id: post_id).present?
  end

  def value_in_range?
    errors.add(:not_in_range, 'Value is not in range') unless (1..5).to_a.include?(value)
  end
end
