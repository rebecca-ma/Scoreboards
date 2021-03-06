class AdminsController < ApplicationController
  def home
    verify_admin {}
  end

  # ------ CRUD ------  
  def index
    verify_admin {
      @admins = Admin.all
    }
  end

  def new
    verify_admin {
      @admin = Admin.new
    }
  end

  def create
    verify_admin {
      @admin = Admin.new(admin_params)
      if @admin.save
        redirect_to admins_path
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      @admin = Admin.find(params[:id])
    }
  end
  
  def update
    verify_admin {
      @admin = Admin.find(params[:id])
      if @admin.update(admin_params)
        redirect_to admins_path
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      @admin = Admin.find(params[:id])
      unless @admin == @curr_admin
        @admin.destroy
      end
      redirect_to admins_path
    }
  end

  # ------ Sessions ------
  def login
    verify_not_admin {}
  end

  def create_login
    verify_not_admin {
      admin = Admin.authenticate(login_params[:username], login_params[:password])
      if admin
        session[:admin_id] = admin.id
        redirect_to home_admin_path
      else
        flash.now.alert = "Invalid username or password"
        render 'login'
      end
    }
  end

  def logout
    verify_admin {
      session[:admin_id] = nil
      redirect_to admin_login_path
    }
  end
  
  private
    def admin_params
      params.require(:admin).permit(:username, :password, :password_confirmation)
    end
    
    def login_params
      params.require(:admin).permit(:username, :password)
    end
end
