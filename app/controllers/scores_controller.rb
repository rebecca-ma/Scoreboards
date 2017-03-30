class ScoresController < ApplicationController
  def new
    @score = Score.new
    @board = Board.find(params[:id])
  end

  def create
    @score = Score.new(score_params)
    @board = Board.find(params[:id])
    if @score.save
      redirect_to board_path(@board)
    else
      render 'new'
    end
  end

  def edit
    find_score
  end

  def update
    find_score
    if @score.update(score_params)
      redirect_to board_path(@board)
    else
      render 'edit'
    end
  end

  def destroy
    find_score
    @score.destroy
    redirect_to board_path(@board)
  end

  private
    def score_params
      params.require(:score).permit(:team, :score, :board_id)
    end

    def find_score
      @score = Score.find(params[:id])
      @board = Board.find(params[:board_id])
    end
end
