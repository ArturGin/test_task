require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    context 'success' do
      it 'when correct params are given' do
        expect(User.new(login: 'radical')).to be_valid
      end
    end

    context 'failure' do
      it 'when wrong params are given' do
        expect(User.new(login: nil)).not_to be_valid
      end
    end
  end
end
