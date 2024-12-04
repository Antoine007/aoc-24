def step1(example = false)
  count = 0
  grid = []
  # row 
  input(example).each do |line|
    count += line.scan(/XMAS/).count
    count += line.reverse.scan(/XMAS/).count
    grid << line.strip.chars
  end
  # vertical
  vertical_grid = grid.transpose
  vertical_grid.each do |line|
    count += line.join("").scan(/XMAS/).count
    count += line.reverse.join("").scan(/XMAS/).count
  end

  reversed_grid = grid.reverse
  x_rev = grid.map{ |row| row.reverse }
  xy_rev = reversed_grid.map{ |row| row.reverse }

  # diagonal 
  [grid,reversed_grid, x_rev, xy_rev].each do |g|
    g.each_with_index do |row, index|
      row.each_with_index do |char, char_index|
        next if g[index + 3] == nil
        next if g[index + 3][char_index + 3] == nil

        if char == "X" && g[index+1][char_index+1] == "M" && g[index+2][char_index+2] == "A" && g[index+3][char_index+3] == "S"
          count += 1 
        end
      end
    end
  end
  p count
end

def step2(example = false)
  count = 0
  grid = []
  input(example).each do |line|
    grid << line.strip.chars
  end
  grid.each_with_index do |row, index|
    row.each_with_index do |char, char_index|
      next if index == 0 || index == grid.length - 1
      next if char_index == 0 || char_index == row.length - 1
      next unless char == "A"

      if grid[index - 1][char_index - 1] == "M" && grid[index - 1][char_index + 1] == "M" && grid[index + 1][char_index + 1] == "S" && grid[index + 1][char_index - 1] == "S"
        count += 1 
      elsif grid[index + 1][char_index - 1] == "M" && grid[index + 1][char_index + 1] == "M" && grid[index - 1][char_index + 1] == "S" && grid[index - 1][char_index - 1] == "S"
        count += 1
      elsif grid[index - 1][char_index + 1] == "M" && grid[index + 1][char_index + 1] == "M" && grid[index + 1][char_index - 1] == "S" && grid[index - 1][char_index - 1] == "S"
        count += 1
      elsif grid[index - 1][char_index - 1] == "M" && grid[index + 1][char_index - 1] == "M"  && grid[index + 1][char_index + 1] == "S" && grid[index - 1][char_index + 1] == "S"
        count += 1
      end
    end
  end
  p count
end


def input(example)
  example == 'example' ? @input_example : @input
end
