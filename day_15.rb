def step1(example = false)
  grid = []
  p = [0, 0]
  directions = input(example).last.strip.split("")
  input(example).each_with_index do |line, index|
    break if line.strip.empty?
    if line.strip.include?('@')
      p = [index, line.strip.index('@')]
    end
    grid << line.strip.split("")
  end
  display_grid(grid)
  p directions
  p p
  directions.each do |direction|
    case direction
    when '>'
      if grid[p[0]][p[1] + 1] == '0' && grid[p[0]][p[1] + 1..-1].include?('.')
        move_attempt(grid[p[0]][p[1] + 1..-1], "right")
      elsif grid[p[0]][p[1] + 1] == '.'
        p[1] += 1
      end
    when '<'
      if grid[p[0]][p[1] - 1] == '0' && grid[p[0]][0..p[1] - 1].include?('.')
        move_attempt(grid[0..p[1] - 1].reverse, "left")
      elsif grid[p[0]][p[1] - 1] == '.'
        p[1] -= 1
      end
    when '^'
      if grid[p[0] - 1][p[1]] == '0' && grid[0..p[0] - 1][p[1]].include?('.')
        move_attempt(grid[0..p[0] - 1][p[1]], "up")
      elsif grid[p[0] - 1][p[1]] == '.'
        p[0] -= 1
      end
    when 'v'
      if grid[p[0] + 1][p[1]] == '0' && grid[p[0] + 1..-1][p[1]].include?('.')
        move_attempt(grid[p[0] + 1..-1][p[1]], "down")
      elsif grid[p[0] + 1][p[1]] == '.'
        p[0] += 1
      end
    end
  end
end

def step2(example = false)
  
end

def display_grid(grid)
  grid.each do |row|
    p row.join
  end
end

def input(example)
  example == 'example' ? @input_example : @input
end


def move_attempt(grid_row, direction)
  p "here"
  if grid_row.index('0') && grid_row.index('.') && grid_row.index('#')
    if grid_row.index('0') < grid_row.index('.') && grid_row.index('.') < grid_row.index('#')
      p true
    end
  end
  p grid
  p direction
end