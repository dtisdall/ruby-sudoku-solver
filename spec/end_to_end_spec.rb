require_relative 'spec_helper'

sudoku1_problem = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"
sudoku1_solution = "145892673893176425276435819519247386762583194384961752957614238438729561621358947"
sudoku2_problem = "--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3"
sudoku2_solution = "475936281932851764681274359517492836349768125268315497153687942794523618826149573"
sudoku3_problem = "29-5----77-----4----4738-129-2--3-648---5--7-5---672--3-9--4--5----8-7---87--51-9"
sudoku3_solution = "293541687718296453654738912972813564846952371531467298369174825125389746487625139"
sudoku4_problem = "-8--2-----4-5--32--2-3-9-466---9---4---64-5-1134-5-7--36---4--24-723-6-----7--45-"
sudoku4_solution = "783426915946518327521379846658197234279643581134852769365984172417235698892761453"
sudoku5_problem = "6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--"
sudoku5_solution = "648732915275189463319564827486325791927618354531947682864271539752893146193456278"
sudoku6_problem = "---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----"
sudoku7_problem = "-3-5--8-45-42---1---8--9---79-8-61-3-----54---5------78-----7-2---7-46--61-3--5--"
sudoku8_problem = "-96-4---11---6---45-481-39---795--43-3--8----4-5-23-18-1-63--59-59-7-83---359---7"
sudoku9_problem = "----754----------8-8-19----3----1-6--------34----6817-2-4---6-39------2-53-2-----"
sudoku10_problem = "3---------5-7-3--8----28-7-7------43-----------39-41-54--3--8--1---4----968---2--"
sudoku11_problem = "3-26-9--55--73----------9-----94----------1-9----57-6---85----6--------3-19-82-4-"
sudoku12_problem = "-2-5----48-5--------48-9-2------5-73-9-----6-25-9------3-6-18--------4-71----4-9-"
sudoku13_problem = "--7--8------2---6-65--79----7----3-5-83---67-2-1----8----71--38-2---5------4--2--"
sudoku14_problem = "----------2-65-------18--4--9----6-4-3---57-------------------73------9----------"
sudoku15_problem = "---------------------------------------------------------------------------------"
sudoku6_solution = "732689145846571329159324678413968257278135496695247831384756912521893764967412583"
sudoku7_solution = "239517864574268319168439275792846153381975426456123987843651792925784631617392548"
sudoku8_solution = "396245781178369524524817396287951643931486275465723918712638459659174832843592167"
sudoku9_solution = "693875412145632798782194356357421869816957234429368175274519683968743521531286947"
sudoku10_solution ="387419526259763418641528379716285943594631782823974165472396851135842697968157234"

def cells_match?(initial_sudoku, solved_sudoku)
    initial_sudoku.chars.each_with_index.all? do |cell, index| 
      cell == "-" || cell == solved_sudoku[index]
    end
end

# Meta-test for testing method
describe "cells_match?" do
  it 'should return true when non-empty ("-") cells are unchanged' do
    expect(cells_match?(sudoku1_problem, sudoku1_solution)).to be true
    expect(cells_match?(sudoku2_problem, sudoku2_solution)).to be true
    expect(cells_match?(sudoku3_problem, sudoku3_solution)).to be true
    expect(cells_match?(sudoku4_problem, sudoku4_solution)).to be true
    expect(cells_match?(sudoku5_problem, sudoku5_solution)).to be true
    expect(cells_match?(sudoku6_problem, sudoku6_solution)).to be true
    expect(cells_match?(sudoku7_problem, sudoku7_solution)).to be true
    expect(cells_match?(sudoku8_problem, sudoku8_solution)).to be true
    expect(cells_match?(sudoku9_problem, sudoku9_solution)).to be true
    expect(cells_match?(sudoku10_problem, sudoku10_solution)).to be true
    expect(cells_match?("---------", "123456789")).to be true
    expect(cells_match?("123456789", "123456789")).to be true
  end

  it 'should return false when non-empty ("-") cells are changed' do
    expect(cells_match?(sudoku1_problem, sudoku2_solution)).to be false
    expect(cells_match?("12345----", "123465789")).to be false
    expect(cells_match?("1--------", "2--------")).to be false
    expect(cells_match?("---------1", "---------9")).to be false
  end

end

describe "End to End:" do

  describe "Solve Sudoku Challenge 1 -" do

    sudoku_game = Sudoku.new(sudoku1_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku1_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku1_solution
    end

    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku1_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 2 -" do

    sudoku_game = Sudoku.new(sudoku2_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku2_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku2_solution
    end

    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku2_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 3 -" do

    sudoku_game = Sudoku.new(sudoku3_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku3_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku3_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku3_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 4 -" do

    sudoku_game = Sudoku.new(sudoku4_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku4_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku4_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku4_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 5 -" do

    sudoku_game = Sudoku.new(sudoku5_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku5_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku5_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku5_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 6 -" do

    sudoku_game = Sudoku.new(sudoku6_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku6_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku6_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku6_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 7 -" do

    sudoku_game = Sudoku.new(sudoku7_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku7_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku7_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku7_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 8 -" do

    sudoku_game = Sudoku.new(sudoku8_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku8_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku8_solution
    end
    
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku8_problem, sudoku_game.board)).to be true
    end

  end  

  describe "Solve Sudoku Challenge 9 -" do

    sudoku_game = Sudoku.new(sudoku9_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku9_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku9_solution
    end
  
    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku9_problem, sudoku_game.board)).to be true
    end

  end

  describe "Solve Sudoku Challenge 10 -" do

    sudoku_game = Sudoku.new(sudoku10_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku10_problem
    end

    it "Attempt to solve the game" do
      sudoku_game.solve
      expect(sudoku_game.board).to eq sudoku10_solution
    end

    it "has a valid solution" do
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku10_problem, sudoku_game.board)).to be true
    end

  end  

  describe "Solve Sudoku Challenge 11 -" do

    sudoku_game = Sudoku.new(sudoku11_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku11_problem
    end

    it "has a valid solution" do
      sudoku_game.solve
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku11_problem, sudoku_game.board)).to be true
    end

  end 

    describe "Solve Sudoku Challenge 12 -" do

    sudoku_game = Sudoku.new(sudoku12_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku12_problem
    end

    it "has a valid solution" do
      sudoku_game.solve
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku12_problem, sudoku_game.board)).to be true
    end

  end 

    describe "Solve Sudoku Challenge 13 -" do

    sudoku_game = Sudoku.new(sudoku13_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku13_problem
    end

    it "has a valid solution" do
      sudoku_game.solve
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku13_problem, sudoku_game.board)).to be true
    end

  end 

    describe "Solve Sudoku Challenge 14 -" do

    sudoku_game = Sudoku.new(sudoku14_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku14_problem
    end

    it "has a valid solution" do
      sudoku_game.solve
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku14_problem, sudoku_game.board)).to be true
    end

  end 

    describe "Solve Sudoku Challenge 15 -" do

    sudoku_game = Sudoku.new(sudoku15_problem)

    it "Initialise the game with the correct board" do
      expect(sudoku_game.board).to eq sudoku15_problem
    end

    it "has a valid solution" do
      sudoku_game.solve
      working_board = sudoku_game.create_working_board(sudoku_game.board)
      expect(sudoku_game.score_board(working_board)).to eq(81)      
      expect(sudoku_game.validate_board(working_board)).to be true
    end

    it "shouldn't modify initial cells" do
      expect(cells_match?(sudoku15_problem, sudoku_game.board)).to be true
    end

  end 
end