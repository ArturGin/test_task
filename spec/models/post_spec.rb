require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create :user }
  let!(:posts) { FactoryBot.create_list :post, 5, :with_ratings }
  describe 'validation' do
    context 'success' do
      it 'when correct params are given' do
        expect(Post.new(ip: 'smth', title: 'smth', body: 'smth', user_id: user.id)).to be_valid
      end
    end

    context 'failure' do
      it 'when wrong params are given' do
        expect(Post.new(ip: 'smth', body: 'smth', user_id: user.id)).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    context '#by_average' do
      it 'first are posts with higher averages' do
        posts_ordered = Post.by_average('true')
        expect(posts_ordered.first.average_rating).to be > posts_ordered.last.average_rating
      end
    end
  end
end
