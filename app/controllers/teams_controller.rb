class TeamsController < ApplicationController
  def home
    verify_user {
      @team = @curr_user.team
    }
  end

  # ------ Admin CRUD ------
  def index
    verify_admin {
      @teams = Team.all
    }
  end

  def show
    verify_admin {
      @team = Team.find(params[:id])
    }
  end

  def new
    verify_admin {
      @team = Team.new
    }
  end

  def create
    verify_admin {
      @team = Team.new(team_params)
      if @team.save
        redirect_to team_path(@team)
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      @team = Team.find(params[:id])
    }
  end

  def update
    verify_admin {
      @team = Team.find(params[:id])
      if @team.update(team_params)
        redirect_to team_path(@team)
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      @team = Team.find(params[:id])
      @team.destroy
      redirect_to teams_path
    }
  end

  private
    def team_params
      params.require(:team).permit(:name, :npc, :code, :image_url)
    end
end
