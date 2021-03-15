class CreateUser < ActiveGraph::Migrations::Base
  disable_transactions!

  def up
    add_constraint :User, :uuid
  end

  def down
    drop_constraint :User, :uuid
  end
end
