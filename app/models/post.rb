class Post < ApplicationRecord
  has_many :ratings
  belongs_to :user

  scope :by_average, -> (average) { joins(:ratings).group('posts.id').order("avg(ratings.value) desc") if average == 'true' }
  validates :body, :title, :ip, presence: true

  def average_rating
    ratings.pluck(:value).sum / rate.count
  end
end
