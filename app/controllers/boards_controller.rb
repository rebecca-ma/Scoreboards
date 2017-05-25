class BoardsController < ApplicationController
  def show
    verify_user {
      @board = Board.find(params[:id])
      @board.set_ranks
    }
  end

  # ------ Admin CRUD ------
  def index
    verify_admin {
      @boards = Board.all
    }
  end

  def admin_show
    verify_admin {
      @board = Board.find(params[:id])
      @board.set_ranks
    }
  end

  def new
    verify_admin {
      @board = Board.new
    }
  end

  def create
    verify_admin {
      @board = Board.new(board_params)
      if @board.save
        redirect_to admin_board_path(@board)
      else
        render 'new'
      end
    }
  end

  def edit
    verify_admin {
      @board = Board.find(params[:id])
    }
  end

  def update
    verify_admin {
      @board = Board.find(params[:id])
      if @board.update(board_params)
        redirect_to admin_board_path(@board)
      else
        render 'edit'
      end
    }
  end

  def destroy
    verify_admin {
      @board = Board.find(params[:id])
      @board.destroy
      redirect_to boards_path
    }
  end

  private
    def board_params
      params.require(:board).permit(:title, :description, :visible)
    end
end
