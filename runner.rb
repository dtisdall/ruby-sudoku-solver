require_relative 'sudoku'

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 16 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.


board_strings = File.readlines('sudoku_puzzles.txt')

def run_game(board_string, i)
  game = Sudoku.new(board_string.chomp)
  puts 
  puts "Puzzle# #{i + 1}:"
  game.solve
  puts game
  puts
end

if ARGV.empty?
  board_strings.each_with_index do | board_string, i |
    run_game(board_string, i)
  end
else
  selected_game = ARGV[0].to_i
  ARGV.clear
  run_game(board_strings[selected_game - 1], selected_game - 1)
end