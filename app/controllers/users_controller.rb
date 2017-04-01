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
        redirect_to user_path(@user)
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
        redirect_to user_path(@curr_user)
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

  def admin_new
    verify_admin {
      @user = User.new
    }
  end

  def admin_create
    verify_admin {
      @user = User.new(user_params_admin)
      if @user.save
        redirect_to users_path
      else
        render 'admin_new'
      end
    }
  end

  def admin_edit
    verify_admin {
      @user = User.find(params[:id])
    }
  end
  
  def admin_update
    verify_admin {
      @user = User.find(params[:id])
      if @user.update(user_params_admin)
        redirect_to users_path
      else
        render 'admin_edit'
      end
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

  def create_session
    verify_not_user {
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        flash.now.alert = "Invalid username or password"
        render 'login'
      end
    }
  end

  def logout
    verify_user {
      session[:user_id] = nil
      redirect_to user_login_path
    }
  end
 
  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :code)
    end

    def user_params_admin
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :team_id)
    end
end
