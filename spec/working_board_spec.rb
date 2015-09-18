require_relative 'spec_helper'


test_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

test_game = Sudoku.new(test_board)

REFERENCE_GROUP = "123456789"

test_match = ["1",  "123456789",  "5",  "8", "123456789", "2", "123456789",
  "123456789","123456789","123456789","9", "123456789", "123456789", "7", "6",
   "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
   "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
   "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
   "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
   "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
   "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
   "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
    "123456789", "8", "9", "123456789", "123456789"]

describe "working board creator method" do
  let (:board) { test_board }

  it "converts the string into an array" do
    expect(test_game.create_working_board(board)).to be_a Array
  end

  it "converts the string into an array with 81 elements" do
    expect(test_game.create_working_board(board).length).to eq(81)
  end

  it "replaces dashes with reference group strings" do
    expect(test_game.create_working_board(board)[1]).to eq(REFERENCE_GROUP)
    expect(test_game.create_working_board(board)[4]).to eq(REFERENCE_GROUP)
  end

  it "does not alter the numbers that are already solved" do
    expect(test_game.create_working_board(board)[2]).to eq("5")
    expect(test_game.create_working_board(board)[5]).to eq("2")
  end

  it "replaces all dashes with reference group strings, and leaves all numbers that are already solved" do
    expect(test_game.create_working_board(board)).to eq(test_match)
  end

end
