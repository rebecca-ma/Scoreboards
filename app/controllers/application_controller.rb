class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    # ---- User ----
    def verify_user
      curr_user ? yield : redirect_to(login_user_path)
    end

    def verify_not_user
      curr_user ? redirect_to(home_user_path) : yield
    end
   
    def curr_user
      if session[:user_id]
        begin
          @curr_user ||= User.find(session[:user_id])
        rescue
          session[:user_id] = nil
        end
      end
    end

    # ---- Admin ----
    def verify_admin
      curr_admin ? yield : redirect_to(admin_login_path)
    end

    def verify_not_admin
      curr_admin ? redirect_to(home_admin_path) : yield
    end

    def curr_admin
      if session[:admin_id]
        begin
          @curr_admin ||= Admin.find(session[:admin_id])
        rescue
          session[:admin_id] = nil
        end
      end
    end
end
