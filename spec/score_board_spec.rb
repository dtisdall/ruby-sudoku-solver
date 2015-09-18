require_relative 'spec_helper'

test_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

test_game = Sudoku.new(test_board)

describe 'score_board' do
  let (:empty_board) { Array.new(81) {"123456789"} }
  let (:board_40) { (Array.new(40) {"1"} + Array.new(41) {"123456789"}).shuffle }
  let (:bad_board_80) { Array.new(80) {"1"} + [""] }
  let (:full_board) { Array.new(81) {"1"} }

  it 'should score an unsolved board' do
    expect(test_game.score_board(board_40)).to eq(40)
  end

  it 'should score a full board' do
    expect(test_game.score_board(full_board)).to eq(81)
  end

  it 'should score an board with a bad value (i.e. "")' do
    expect(test_game.score_board(bad_board_80)).to eq(80)
  end

  it 'should score an empty board' do
    expect(test_game.score_board(empty_board)).to eq(0)
  end

end
