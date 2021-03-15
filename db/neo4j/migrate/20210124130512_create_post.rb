class CreatePost < ActiveGraph::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Post, :uuid
  end

  def down
    drop_constraint :Post, :uuid
  end
end
