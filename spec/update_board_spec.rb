require_relative 'spec_helper'

test_working_board = ["1",  "12349",  "5",  "8", "126789", "2", "123456789",
    "123456789","123456789","123456789","9", "123456789", "123456789", "7", "6",
     "4", "123456789", "5", "2", "123456789", "123456789", "4", "123456789",
     "123456789", "8", "1", "9", "123456789", "1", "9", "123456789", "123456789",
     "7", "3", "123456789", "6", "7", "6", "2", "123456789", "8", "3", "123456789",
     "9", "123456789", "123456789", "123456789", "123456789", "123456789", "6", "1",
     "123456789", "5", "123456789", "123456789", "123456789", "7", "6", "123456789",
     "123456789", "123456789", "3", "123456789", "4", "3", "123456789", "123456789",
     "2", "123456789", "5", "123456789", "1", "6", "123456789", "123456789", "3",
      "123456789", "8", "9", "123456789", "123456789"]

test_board = Sudoku.new(test_working_board)
match_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

REFERENCE_GROUP = "123456789"

describe "update board method" do

  it "converts the array into a string" do
    expect(test_board.decode_working_board(test_working_board)).to be_a String
  end

  it "converts the array into a string with 81 characters" do
    expect(test_board.decode_working_board(test_working_board).size).to eq(81)
  end

  it "replaces anything longer than 1 character with dashes" do
    expect(test_board.decode_working_board(test_working_board)[1]).to eq("-")
    expect(test_board.decode_working_board(test_working_board)[4]).to eq("-")
  end

  it "does not alter the numbers that are already solved" do
    expect(test_board.decode_working_board(test_working_board)[0]).to eq("1")
    expect(test_board.decode_working_board(test_working_board)[78]).to eq("9")
  end

  it "replaces all elements longer than one character with dashes, and leaves all numbers that are already solved" do
    expect(test_board.decode_working_board(test_working_board)).to eq(match_board)
  end

end
