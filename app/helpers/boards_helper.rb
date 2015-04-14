module BoardsHelper
  def div_for_board(board)
    content_tag :div, :"data-board-id" => board.id do
      yield 
    end
  end
end
