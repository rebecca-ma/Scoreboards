class BoardsController < ApplicationController
  def index
    # admin only
    @boards = Board.all
  end

  def show
    # conditional on whether the board can be seen by non-admin
    @board = Board.find(params[:id])
    @board.set_ranks
  end

  def new
    # admin only
    @board = Board.new
  end

  def create
    # admin only
    @board = Board.new(board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      render 'new'
    end
  end

  def edit
    #admin only
    @board = Board.find(params[:id])
  end

  def update
    #admin only
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board)
    else
      render 'edit'
    end
  end

  def destroy
    # admin only
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end

  private
    def board_params
      params.require(:board).permit(:title, :description, :visible)
    end
end
