class AssignmentsController < ApplicationController
  def new
    verify_admin {
      @mission = Mission.find(params[:mission_id])
      @assignment = Assignment.new
    }
  end

  def create
    verify_admin {
      @mission = Mission.find(params[:mission_id])
      @assignment = Assignment.new(assignment_params)
      if @assignment.save
        redirect_to admin_mission_path(@mission)
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      @mission = Mission.find(params[:mission_id])
      @assignment = Assignment.find(params[:id])
    }
  end

  def update
    verify_admin {
      @mission = Mission.find(params[:mission_id])
      @assignment = Assignment.find(params[:id])
      if @assignment.update(assignment_params)
        redirect_to admin_mission_path(@mission)
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      @mission = Mission.find(params[:mission_id])
      @assignment = Assignment.find(params[:id])
      @assignment.destroy
      redirect_to :back
    }
  end

  private
    def assignment_params
      params.require(:assignment).permit(:mission_id, :team_id, :start_time, :completed_time)
    end
end
