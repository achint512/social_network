class Post
  include ActiveGraph::Node

  property :description, type: String

  has_one :in, :user, origin: :posts
end
