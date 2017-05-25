class UsersController < ApplicationController
  def home
    verify_user {}
  end
  
  # ------ User CRUD ------
  def new
    verify_not_user {
      @user = User.new
    }
  end

  def create
    verify_not_user {
      @user = User.new(user_params)
      if @user.save
        redirect_to home_user_path
      else
        render 'new'
      end
    }
  end

  def edit
    verify_user {}
  end

  def update
    verify_user {
      if @curr_user.update(user_params)
        redirect_to home_user_path
      else
        render 'edit'
      end
    }
  end

  # ------ Admin CRUD ------
  def index
    verify_admin {
      @users = User.all
    }
  end

  def destroy
    verify_admin {
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path
    }
  end

  # ------ Sessions ------ 
  def login
    verify_not_user {}
  end

  def create_login
    verify_not_user {
      user = User.authenticate(login_params[:username], login_params[:password])
      if user
        session[:user_id] = user.id
        redirect_to home_user_path
      else
        flash.now.alert = "Invalid username or password"
        render 'login'
      end
    }
  end

  def logout
    verify_user {
      session[:user_id] = nil
      redirect_to login_user_path
    }
  end
 
  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :code)
    end

    def login_params
      params.require(:user).permit(:username, :password)
    end
end
