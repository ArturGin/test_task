require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:user) { FactoryBot.create :user }
  let(:post) { FactoryBot.create :post }

  describe 'validation' do
    context 'success' do
      it 'when correct params are given' do
        expect(Rating.new(value: rand(1..5), user: user, post: post)).to be_valid
      end
    end

    context 'failure' do
      it 'when wrong params are given' do
        expect(Rating.new(user: user, value: 4)).not_to be_valid
      end

      it 'when user rated this post before' do
        Rating.create(value: rand(1..5), user: user, post: post)
        expect(Rating.new(user: user, post: post, value: 3)).not_to be_valid
      end

      it 'when value is not in range' do
        expect(Rating.new(user: user, post: post, value: 30)).not_to be_valid
      end
    end
  end
end
