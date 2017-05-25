class MissionsController < ApplicationController
# ------ User View ------
  def show
    verify_user {
      @mission = Mission.find(params[:id])
    }
  end

# ------ Admin CRUD ------
  def index
    verify_admin {
      @missions = Mission.all
    }
  end

  def admin_show
    verify_admin {
      @mission = Mission.find(params[:id])
    }
  end

  def new
    verify_admin {
      @mission = Mission.new
    }
  end

  def create
    verify_admin {
      @mission = Mission.new(mission_params)
      if @mission.save
        redirect_to admin_mission_path(@mission)
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      @mission = Mission.find(params[:id])
    }
  end

  def update
    verify_admin {
      @mission = Mission.find(params[:id])
      if @mission.update(mission_params)
        redirect_to admin_mission_path(@mission)
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      @mission = Mission.find(params[:id])
      @mission.destroy
      redirect_to missions_path
    }
  end

  private
    def mission_params
      params.require(:mission).permit(:title, :description, :giver)
    end
end
