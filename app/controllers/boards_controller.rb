class BoardsController < ApplicationController
  def create
    @board = Board.new(name: params[:board][:name], group_id: params[:group_id])
    if @board.save
      # binding.pry
      track_feed(@board)
      redirect_to group_path(@board.group)
    end
  end

  # private
  # def board_params
  #   params.require(:board).permit(:name, :group_id)
  # end
end
