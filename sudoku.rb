class Sudoku

  REFERENCE_GROUP = "123456789"
  
#
# "Public" methods
#

  def initialize(board_string)
    @board = board_string
  end


  def board
    @brd
  end

  # Returns a string representing the current state of the board
  def to_s
    output = ["┏━━━┯━━━┯━━━┳━━━┯━━━┯━━━┳━━━┯━━━┯━━━┓"]
    0.upto(8) do |row|
      string = ""
      0.upto(8) do |col|
        string += (col % 3 == 0 ? "┃" : "│") << @board[row * 9 + col].center(3)
      end
      string += "┃"
      output << string
      output << (row % 3 == 2 ? "┣━━━┿━━━┿━━━╋━━━┿━━━┿━━━╋━━━┿━━━┿━━━┫" :
                                "┠───┼───┼───╂───┼───┼───╂───┼───┼───┨")
    end
    output.last.replace("┗━━━┷━━━┷━━━┻━━━┷━━━┷━━━┻━━━┷━━━┷━━━┛")
    output.join("\n")
  end

  def solve
    working_board = create_working_board(@board)
    @status, new_board = solve_board(working_board)
    @board = decode_working_board(new_board)
  end

#
# "Private" methods
#

  def solve_board(start_board)
    unless solvable?(start_board)
      return  [:board_invalid, start_board] 
    end
    new_score = score_board(start_board)
    working_board = start_board.dup.map { |cell| cell.dup }
    start_score = nil
    until (new_score == 81) || (new_score == start_score) do
      start_score = new_score
      deduce_rows!(working_board)
      deduce_columns!(working_board)
      deduce_squares!(working_board)
      new_score = score_board(working_board)
    end
    if new_score == 81
      if validate_board(working_board)
        return [:board_solved, working_board]
      else
        return [:board_invalid, working_board]
      end
    end
    unless solvable?(working_board)
      return  [:board_invalid, working_board] 
    end
    first_unsolved_cell = working_board.index { |cell| cell.size > 1 }
    digits_to_guess = working_board[first_unsolved_cell].chars
    digits_to_guess.each do |digit|
      guess_board = working_board
      guess_board[first_unsolved_cell].replace(digit)
      result_status, guess_board = solve_board(guess_board)
      return [result_status, guess_board] if result_status == :board_solved
    end
    [:board_nondeducible, working_board]
  end

  def check(groups)
    groups.each do | group |
      solved_nums = group.select { |cell| cell.size == 1 }.join
      unless solved_nums.empty?
        group.select { |cell| cell.size > 1 }.map { |string| string.gsub!(/[#{solved_nums}]/, "") }
      end
      singles = ("1".."9")
      singles.each do |digit|
        if group.one? { |string| string.include?(digit) }
          group.find { |string| string.include?(digit) }.replace(digit)
        end
      end
    end
    groups
  end

  def score_board(working_board)
    working_board.count { |cell| cell.match(/^[1-9]{1}$/) }
  end

  def unsolvable?(working_board)
    working_board.any? { |cell| cell.empty? }
  end


  def create_working_board(board)
    board.chars.map { |char| char == "-" ? REFERENCE_GROUP.dup : char }
  end

  def decode_working_board(working_board)
    working_board.map {|cell| cell.size > 1 ? "-" : cell }.join
  end

  def get_rows(working_board)
    working_board.each_slice(9).to_a
  end

  def get_columns(working_board)
    get_rows(working_board).transpose
  end


  def get_squares(working_board)
    squarify(get_rows(working_board)).map { |row| row.flatten }
  end

  def rows_to_wkboard(groups)
    groups.flatten
  end

  def cols_to_wkboard(groups)
    groups.transpose.flatten
  end

  def sqs_to_wkboard(groups)
    squarify(groups).flatten
  end

  def squarify(groups)
    groups.map! { |group| group.each_slice(3).to_a }
    groups = groups[0..2].transpose +
             groups[3..5].transpose +
             groups[6..8].transpose
  end

  def deduce_rows!(working_board)
    rows = check(get_rows(working_board))
    working_board.replace(rows_to_wkboard(rows))
  end

  def deduce_columns!(working_board)
    columns = check(get_columns(working_board))
    working_board.replace(cols_to_wkboard(columns))
  end

  def deduce_squares!(working_board)
    squares = check(get_squares(working_board))
    working_board.replace(sqs_to_wkboard(squares))
  end

  def validate_board(working_board)
    validate_rows(working_board) && validate_columns(working_board) && validate_squares(working_board)
  end

  def validate_rows(working_board)
    rows = get_rows(working_board)
    validate(rows)
  end

  def validate_columns(working_board)
    columns = get_columns(working_board)
    validate(columns)
  end

  def validate_squares(working_board)
    squares = get_squares(working_board)
    validate(squares)
  end

  def validate(groups)
    groups.map { |group| group.sort.join }.all? { |group| group == REFERENCE_GROUP }
  end

  def solvable?(working_board)
    groups = get_rows(working_board) + get_columns(working_board) + get_squares(working_board)
    groups.all? { |group| solvable_group?(group) } && !working_board.include?("") 
  end

  def solvable_group?(group)
    solved_cells = group.select{ |cell| cell.size == 1 }
    no_dups = solved_cells.size == solved_cells.uniq.size

    digits = ('1'..'9')
    digits_possible = digits.all? { |digit| group.join('').include?(digit) }

    no_dups && digits_possible
  end

end
