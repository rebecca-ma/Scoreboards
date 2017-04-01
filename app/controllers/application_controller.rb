class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    # ---- User ----
    def verify_user
      curr_user ? yield : redirect_to(user_login_path)
    end

    def verify_not_user
      curr_user ? redirect_to(user_path(@curr_user)) : yield
    end
   
    def curr_user
      @curr_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # ---- Admin ----
    def verify_admin
      curr_admin ? yield : redirect_to(admin_login_path)
    end

    def verify_not_admin
      curr_admin ? redirect_to(admin_path(@curr_admin)) : yield
    end

    def curr_admin
      @curr_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
    end
end
