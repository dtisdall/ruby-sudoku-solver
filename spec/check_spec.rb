require_relative 'spec_helper'

test_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

test_game = Sudoku.new(test_board)

  test_group = [["123456789",
                 "123456789",
                 "123456789",
                 "6",
                 "8",
                 "123456789",
                 "1",
                 "9",
                 "123456789"]]

  solved_group = [["1",
                   "2",
                   "3",
                   "4",
                   "5",
                   "6",
                   "7",
                   "8",
                   "9"]]

  hidden_singles_group = [["4",
                 "7",
                 "159",
                 "3",
                 "8",
                 "1569",
                 "2",
                 "19",
                 "159"]]

  hidden_singles_match = [["4",
                 "7",
                 "159",
                 "3",
                 "8",
                 "6",
                 "2",
                 "19",
                 "159"]]

  unsolved_group = [["123456789",
                     "123456789",
                     "123456789",
                     "123456789",
                     "123456789",
                     "123456789",
                     "123456789",
                     "123456789",
                     "123456789"]]

  test_match = [["23457",
                 "23457",
                 "23457",
                 "6",
                 "8",
                 "23457",
                 "1",
                 "9",
                 "23457"]]

describe "check method" do

  it "returns an array" do
    expect(test_game.check(test_group)).to be_a Array
  end

  it "should return 1 elements in the array" do
    expect(test_game.check(test_group).count).to eq(1)
  end

  it "eliminates the numbers in the solved squares from the groups in the unsolved squares" do
    expect(test_game.check(test_group)).to eq(test_match)
  end

  it "finds hidden singles" do
    expect(test_game.check(hidden_singles_group)).to eq(hidden_singles_match)
  end

  it "doesn't change a solved array" do
    expect(test_game.check(test_group)).to eq(test_group)
  end

  it "doesn't change an unsolved array" do
    expect(test_game.check(unsolved_group)).to eq(unsolved_group)
  end

end
