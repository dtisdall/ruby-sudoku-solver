require_relative 'spec_helper'

describe 'solve_board' do

    let(:trivial_sudoku) {[
        "456", "3", "4", "6", "7", "8", "9", "1", "2",
        "6", "2379", "2", "1", "9", "5", "3", "4", "8",
        "1", "9", "123456789", "3", "4", "2", "5", "6", "7",
        "8", "5", "9", "6789", "6", "1", "4", "2", "3",
        "4", "2", "6", "8", "5678", "3", "7", "9", "1",
        "7", "1", "3", "9", "2", "1234", "8", "5", "6",
        "9", "6", "1", "5", "3", "7", "123", "8", "4",
        "2", "8", "7", "4", "1", "9", "6", "345", "5",
        "3", "4", "5", "2", "8", "6", "1", "7", "89"
      ]}
      let(:trivial_sudoku_2) {[
        "5", "3", "4", "6", "7", "123489", "9", "1", "2",
        "6", "7", "2", "1", "9", "5", "3", "34789", "8",
        "1", "9", "12389", "3", "4", "2", "5", "6", "7",
        "8", "5", "9", "7", "6", "1", "4", "2", "3",
        "4", "2", "6", "8", "5", "345678", "7", "9", "1",
        "7", "123456", "3", "9", "2", "4", "8", "12589", "6",
        "9", "6", "1", "5", "3", "7", "2", "8", "4",
        "123456789", "8", "7", "4", "1", "9", "34678", "3", "5",
        "3", "4", "5", "23467", "8", "6", "1", "7", "9"
      ]}

      let(:solved_trivial_sudoku) {[
        "5", "3", "4", "6", "7", "8", "9", "1", "2",
        "6", "7", "2", "1", "9", "5", "3", "4", "8",
        "1", "9", "8", "3", "4", "2", "5", "6", "7",
        "8", "5", "9", "7", "6", "1", "4", "2", "3",
        "4", "2", "6", "8", "5", "3", "7", "9", "1",
        "7", "1", "3", "9", "2", "4", "8", "5", "6",
        "9", "6", "1", "5", "3", "7", "2", "8", "4",
        "2", "8", "7", "4", "1", "9", "6", "3", "5",
        "3", "4", "5", "2", "8", "6", "1", "7", "9"
      ]}
      # invalid but filled
      let(:invalid_sudoku) {[
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "1", "2", "3", "4", "5", "6", "7", "8", "9"
      ]}
      # invalid unsolved (bad puzzle)
      let(:invalid_sudoku_2) {[
        "456", "4", "4", "6", "4", "2", "6", "1", "2",
        "6", "2379", "2", "1", "9", "5", "3", "4", "8",
        "1", "9", "123456789", "3", "4", "2", "5", "6", "7",
        "8", "5", "9", "6789", "6", "1", "4", "2", "3",
        "4", "2", "6", "8", "5678", "3", "7", "9", "1",
        "7", "1", "3", "9", "2", "1234", "8", "5", "6",
        "9", "9", "1", "5", "3", "7", "123", "8", "4",
        "2", "8", "7", "4", "1", "9", "6", "345", "5",
        "3", "4", "5", "2", "8", "6", "1", "7", "89"
      ]}
      # invalid deduction result? (in any case something really went wrong)
      let(:invalid_sudoku_3) {[
        "", "", "45", "36", "7", "8", "9", "1", "2",
        "6", "7", "2", "1", "9", "5", "3", "4", "8",
        "1", "9", "8", "3", "4", "2", "5", "6", "7",
        "8", "5", "9", "7", "6", "1", "4", "2", "3",
        "4", "2", "6", "8", "5", "3", "7", "9", "1",
        "7", "1", "3", "9", "2", "4", "8", "5", "6",
        "9", "6", "1", "5", "3", "7", "2", "8", "4",
        "2", "8", "7", "4", "1", "9", "6", "3", "5",
        "3", "4", "5", "2", "8", "6", "1", "7", "9"
      ]}
      let(:impossible_sudoku) {[
        "1", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",
        "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "9"
      ]}

  

  it 'should solve trivial board 1' do
    sudoku_game = Sudoku.new(trivial_sudoku)
    expect(sudoku_game.solve_board(trivial_sudoku)).to eq([:board_solved, solved_trivial_sudoku])
  end

  it 'should solve trivial board 2' do
    sudoku_game = Sudoku.new(trivial_sudoku)
    expect(sudoku_game.solve_board(trivial_sudoku_2)).to eq([:board_solved, solved_trivial_sudoku])
  end

  it 'should return :board_invalid status on invalid boards' do
    sudoku_game = Sudoku.new(trivial_sudoku)
    expect(sudoku_game.solve_board(invalid_sudoku)[0]).to eq(:board_invalid)
    expect(sudoku_game.solve_board(invalid_sudoku_2)[0]).to eq(:board_invalid)
    expect(sudoku_game.solve_board(invalid_sudoku_3)[0]).to eq(:board_invalid)
  end

end
