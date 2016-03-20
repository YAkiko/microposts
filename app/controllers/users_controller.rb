class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]

  def show
    @microposts = @user.microposts.order(created_at: :desc)
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to user_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'edit'
    end
  end

  # フォローしているユーザー
  def followings
    @following_users = @user.following_users
    return redirect_to login_path if @following_users.nil?
  end

  # フォローされているユーザー  
  def followers
    @follower_users = @user.follower_users
    return redirect_to login_path if @follower_users.nil?
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area, :discription)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url if @user != current_user
  end
end
