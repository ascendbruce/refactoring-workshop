class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    # FIXME: 5 Form Object
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    @user_update_form = UserUpdateForm.new(params[:id])
    # @user = User.find(params[:id])
    # @user.profile ||= @user.build_profile
  end

  def update
    @user_update_form = UserUpdateForm.new(params[:id])
    if @user_update_form.update(user_params)
      redirect_to user_path(@user_update_form.user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user_update_form).permit(:email,:id, :nickname, :bio)
  end
end
