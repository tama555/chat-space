class UsersController < ApplicationController
  
  def index
    return nil if params[:keyword] ==""
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"]).where.not(id: current_user.id).limit(10) #whereメソッドを使用し、入力された値を含むかつ、ログインしているユーザーのidは除外するという条件で取得
    respond_to do |format|  #jsonがレスポンスとして返るので、jbuilderを生成しjsonを形成できるように
      format.html
      format.json
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
