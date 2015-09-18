require_relative 'spec_helper'

test_board = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

test_game = Sudoku.new(test_board)

describe"Get/Set/Deduce methods:" do

  describe 'get_columns' do
    let(:board) { (1..81).to_a }

    it 'should return 9 arrays of length 9' do
      expect(test_game.get_columns(board).length).to eq(9)
      test_game.get_columns(board).each do |group_of_9|
        expect(group_of_9.length).to eq(9)
      end
    end

    it 'should get column 0 correctly' do
      expect(test_game.get_columns(board)[0]).to eq([1, 10, 19, 28, 37, 46, 55, 64, 73])
    end

    it 'should get column 8 correctly' do
      expect(test_game.get_columns(board)[8]).to eq([9, 18, 27, 36, 45, 54, 63, 72, 81])
    end

  end

  describe 'get_rows' do
    let(:board) { (1..81).to_a }

    it 'should return 9 arrays of length 9' do
      expect(test_game.get_rows(board).length).to eq(9)
      test_game.get_rows(board).each do |group_of_9|
        expect(group_of_9.length).to eq(9)
      end
    end


    it 'should get row 0 correctly' do
      expect(test_game.get_rows(board)[0]).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it 'should get row 8 correctly' do
      expect(test_game.get_rows(board)[8]).to eq([73, 74, 75, 76, 77, 78, 79, 80, 81])
    end

  end

  describe 'get_squares' do
    let(:board) { (1..81).to_a }

    it 'should return 9 arrays of length 9' do
      expect(test_game.get_squares(board).length).to eq(9)
      test_game.get_squares(board).each do |group_of_9|
        expect(group_of_9.length).to eq(9)
      end
    end

    it 'should get square 0 correctly' do
      expect(test_game.get_squares(board)[0]).to eq([1, 2, 3, 10, 11, 12, 19, 20, 21])
    end

    it 'should get square 1 correctly' do
      expect(test_game.get_squares(board)[1]).to eq([4, 5, 6, 13, 14, 15, 22, 23, 24])
    end

    it 'should get square 4 correctly' do
      expect(test_game.get_squares(board)[4]).to eq([31, 32, 33, 40, 41, 42, 49, 50, 51])
    end

    it 'should get square 5 correctly' do
      expect(test_game.get_squares(board)[5]).to eq([34, 35, 36, 43, 44, 45, 52, 53, 54])
    end

    it 'should get square 8 correctly' do
      expect(test_game.get_squares(board)[8]).to eq([61, 62, 63, 70, 71, 72, 79, 80, 81])
    end

    describe 'deduce_*!' do
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
        let(:trivial_sudoku_part_2) {[
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
        let(:solved_board) {[
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

      it 'should deduce columns' do
        expect(test_game.deduce_columns!(trivial_sudoku)).to eq(solved_board)
      end

      it 'should deduce rows' do
        expect(test_game.deduce_rows!(trivial_sudoku)).to eq(solved_board)
      end

      it 'should deduce squares' do
        expect(test_game.deduce_squares!(trivial_sudoku_part_2)).to eq(solved_board)
      end
    end
  end

end