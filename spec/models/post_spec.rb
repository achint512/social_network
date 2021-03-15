require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:description) { 'Test post' }

  describe '#create' do
    it 'creates new post record with the relevant description' do
      post = FactoryBot.create(:post, description: description)

      expect(post.description).to eql(description)
      expect(post.user).to be_nil

      post.destroy
    end
  end
end
