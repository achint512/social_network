require 'rails_helper'

RSpec.describe User, type: :model do
  let(:username) { 'test' }
  let(:email) { 'test@gmail.com' }

  describe '#create' do
    it 'creates new user record' do
      user = FactoryBot.create(:user, username: username, email: email)

      expect(user.username).to eql(username)
      expect(user.email).to eql(email)
      expect(user.posts.to_a).to eql([])
      expect(user.followers.to_a).to eql([])
      expect(user.follows.to_a).to eql([])

      user.destroy
    end
  end

  describe '#add_post' do
    let(:post_description) { 'Test Post' }

    it 'creates and adds new post to the user' do
      user = FactoryBot.create(:user, username: username, email: email)
      user.add_post(post_description)

      expect(user.posts.first.description).to eql(post_description)

      user.destroy
    end
  end

  describe '#follow_person' do
    let(:user1) { FactoryBot.create(:user, username: username, email: email) }
    let(:user2) { FactoryBot.create(:user, username: 'test2', email: 'test2@gmail.com') }

    it 'adds person to users follows list and user to persons followers list' do
      user1.follow_person(user2)

      expect(user1.follows.first).to eql(user2)
      expect(user2.followers.first).to eql(user1)
    end

    after do
      user1.destroy
      user2.destroy
    end
  end
end
