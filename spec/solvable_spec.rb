require_relative 'spec_helper'

test_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

test_game = Sudoku.new(test_board)

describe 'solvable?' do
  let(:solvable_board) {["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
   "123456789","123456789","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"
    ]}
  let(:unsolvable_dups_row) {["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
   "123456789","1","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"
    ]}
  let(:unsolvable_dups_col) {["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
   "123456789","123456789","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "1", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"
    ]}
  let(:unsolvable_dups_square) {["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
   "123456789","123456789","123456789","9", "1", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"]}
  let(:unsolvable_empty_cell) {["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
   "123456789","123456789","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"
    ]}
  let(:unsolvable_missing_digit_row) {["1",  "12345789",  "5",  "8", "12345789", "2", "12345789",
   "12345789","12345789","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"
    ]}
  let(:unsolvable_missing_digit_col) {
     ["1",  "123456789",  "5",  "8", "123456789", "2", "123456789", "123456789","123456789",
      "12345678", "9", "123456789", "123456789", "7", "6", "4", "123456789", "5", 
      "2", "123456789", "123456789", "4", "123456789", "123456789", "8", "1", "9", 
      "12345678", "1", "9", "123456789", "123456789", "7", "3", "123456789", "6", 
      "7", "6", "2", "123456789", "8", "3", "123456789", "9", "123456789", 
      "12345678", "123456789", "123456789", "123456789", "6", "1", "123456789", "5", "123456789", 
      "12345678", "123456789", "7", "6", "123456789", "123456789", "123456789", "3", "123456789", 
      "4", "3", "123456789", "123456789", "2", "123456789", "5", "123456789", "1", 
      "6", "123456789", "123456789", "3", "123456789", "8", "9", "123456789", "123456789"
      ]}

   let(:unsolvable_missing_digit_square) {
     ["1",  "123456789",  "5",  "8", "123456789", "2", "123456789", "123456789","123456789",
      "123456789", "9", "123456789", "123456789", "7", "6", "4", "123456789", "5", 
      "2", "123456789", "123456789", "4", "123456789", "123456789", "8", "1", "9", 
      "123456789", "1", "9", "123456789", "123456789", "7", "3", "123456789", "6", 
      "7", "6", "2", "123456789", "8", "3", "123456789", "9", "123456789", 
      "123456789", "123456789", "123456789", "123456789", "6", "1", "123456789", "5", "123456789", 
      "123456789", "123456789", "7", "6", "123456789", "123456789", "12345689", "3", "12345689", 
      "4", "3", "123456789", "123456789", "2", "123456789", "5", "12345689", "1", 
      "6", "123456789", "123456789", "3", "123456789", "8", "9", "12345689", "12345689"
      ]}
  it 'should return true for a solvable board' do
    expect(test_game.solvable?(solvable_board)).to be true
  end

  it 'should return false for a board with duplicates in a group' do
    expect(test_game.solvable?(unsolvable_dups_row)).to be false
    expect(test_game.solvable?(unsolvable_dups_col)).to be false
    expect(test_game.solvable?(unsolvable_dups_square)).to be false
  end

  it 'should return false for a board with cells with no possible values' do
    expect(test_game.solvable?(unsolvable_empty_cell)).to be false
  end

  it 'should return true for a board with a group that has no possible cells for a digit' do
    expect(test_game.solvable?(unsolvable_missing_digit_row)).to be false
    expect(test_game.solvable?(unsolvable_missing_digit_col)).to be false
    expect(test_game.solvable?(unsolvable_missing_digit_square)).to be false
  end

end