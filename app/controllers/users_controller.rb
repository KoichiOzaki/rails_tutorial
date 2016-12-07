class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # メモ：railsのform_forメソッドにて、authenticity_tokenを自動で作成し、Cross-Site Request Forgery (CSRF) 対策もしてくれている
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # 保存の成功をここで扱う。
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    # マスアサインメント脆弱性対策
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
