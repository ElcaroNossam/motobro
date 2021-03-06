class UsersController < ApplicationController


  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
    
def new
    @user = User.new
end

def show 
  @microposts = @user.microposts.paginate(page: params[:page])
end

def otzuv 
  @user = User.find(session[:user_id])
  @microposts = @user.microposts.paginate(page: params[:page])
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
    usercode = params[:user][:code].downcase
    
    if usercode == "motobro24" 
      @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Добро пожаловать в наше сообщество #{@user.username}!"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
    else
      flash[:danger] = "Неправильный код! Не знаешь? Тогда пиши в инстаграмм!"
      redirect_to signup_path
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