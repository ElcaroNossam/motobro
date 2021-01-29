class UsersController < ApplicationController


  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
    
def new
    @user = User.new
end

def show 

end

def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

def edit
    
end

def update
  if @user.update(user_params)
    flash[:notice] = "Ваш профиль был успешно обновлён!"
    redirect_to @user
  else
    render 'edit'
  end
end

def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Добро пожаловать в наше сообщество #{@user.username}!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Ваш аккаунт успешно удалён!"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "Вы можете обновить и удалить только свой аккаунт!"
      redirect_to @user
    end
  end
end