class Post < ApplicationRecord
  has_many :ratings
  belongs_to :user
  attribute :include_user

  scope :by_average, lambda { |average|
                       joins(:ratings).group('posts.id').order('avg(ratings.value) desc') if average == 'true'
                     }
  validates :body, :title, :ip, presence: true

  def average_rating
    ratings.pluck(:value).sum / ratings.count
  end
end
