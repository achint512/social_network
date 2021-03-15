class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    followed_usernames = @user.follows.map(&:username) + [@user.username]
    @unfollowed_usernames = []
    User.find_each do |user|
      next if followed_usernames.include?(user.username)

      @unfollowed_usernames << [user.username]
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    follow_user
    create_new_post!

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email)
  end

  def follow_user
    username_to_follow = params[:user][:follow_username]
    return if username_to_follow.blank?

    user_to_follow = User.find_by(username: username_to_follow)
    @user.follow_person(user_to_follow)
  end

  def create_new_post!
    post_description = params[:user][:post_description]
    return if post_description.blank?

    @user.add_post(post_description)
  end
end
