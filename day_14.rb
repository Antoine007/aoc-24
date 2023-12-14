def step1(example = false)
  grid = []
  @result = 0
  input(example).each do |line|
    grid << line.strip.chars
  end

  grid = tilt(grid.transpose)
  grid = grid.transpose

  grid.each{|r| p r.join}
  count(grid)
  p @result
end

def step2(example = false)
  grid = []
  @result = 0
  input(example).each do |line|
    grid << line.strip.chars
  end
  initial_grid = grid
  1000.times do
    grid = cycle(grid)
    break if grid == initial_grid
  end

  grid.each{ |r| p r.join }
  count(grid)
  p @result
end

def cycle(grid)
  # p "North"
  grid = tilt(grid.transpose)
  grid = grid.transpose
  # p "West"
  grid = tilt(grid)
  # p "South"
  grid = tilt(grid.transpose.map(&:reverse))
  grid = grid.map(&:reverse).transpose
  # p "East"
  grid = tilt(grid.map(&:reverse))
  grid.map(&:reverse)
end


def tilt(grid)
  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next if x == 0

      case char
      when '.'
        next
      when '#'
        next
      when 'O'
        next if row[x-1] == 'O'
        next if row[x-1] == '#'

        move = true
        until move == false
          grid[y][x-1] = 'O'
          grid[y][x] = '.'
          x -= 1
          move = false if x == 0
          move = false if grid[y][x-1] == '#' || grid[y][x-1] == 'O'
        end
      end
    end
  end
  grid
end

def count(grid)
  count = grid.length
  grid.each_with_index do |row, i|
    @result += row.count('O') * (count - i)
  end
end

def input(example)
  example == 'example' ? @input_example : @input
end
