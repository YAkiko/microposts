class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_to login_path
    end
    @microposts = @user.microposts.order(created_at: :desc)
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area, :discription)
  end
  
  def set_user
    @user = User.find(session[:user_id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url if @user != current_user
  end
end
