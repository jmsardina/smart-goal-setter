class BoardsController < ApplicationController
  def create
    @board = Board.new(name: params[:board][:name], group_id: params[:group_id])
    if @board.save
      redirect_to group_path(@board.group)
    end
  end
end
