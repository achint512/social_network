class User
  include ActiveGraph::Node

  property :username, type: String
  property :email, type: String

  has_many :out, :posts, type: :HAS_POSTS
  has_many :out, :follows, type: :FOLLOWS, model_class: :User

  has_many :in, :followers, type: :HAS_FOLLOWERS, model_class: :User

  # @params [String] post_description description of the post
  def add_post(post_description)
    self.posts << Post.create!(description: post_description)
  end

  # @params [User] person User object of the person who has to be followed
  def follow_person(person)
    self.follows << person
    person.followers << self
  end
end
