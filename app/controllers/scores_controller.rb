class ScoresController < ApplicationController
  def new
    verify_admin {
      @score = Score.new
      @board = Board.find(params[:board_id])
    }
  end

  def create
    verify_admin {
      @score = Score.new(score_params)
      @board = Board.find(params[:board_id])
      if @score.save
        redirect_to admin_board_path(@board)
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      find_score
    }
  end

  def update
    verify_admin {
      find_score
      if @score.update(score_params)
        redirect_to admin_board_path(@board)
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      find_score
      @score.destroy
      redirect_to admin_board_path(@board)
    }
  end

  private
    def score_params
      params.require(:score).permit(:team_id, :score, :board_id)
    end

    def find_score
      @score = Score.find(params[:id])
      @board = Board.find(params[:board_id])
    end
end
