def step1(example = false)
  @grid = []
  @step = 0
  @current_positions = []
  input(example).each do |line|
    @grid <<  line.strip.chars
  end
  initial_position
  64.times do
    step_once
  end
  p @current_positions.count
  @grid.each do |line|
    puts line.join
  end
end

def initial_position
  @grid.each_with_index do |line,y|
    line.each_with_index do |char,x|
      @current_positions << [x, y] if char == 'S'
    end
  end
end

def step_once
  new_positions = []
  @current_positions.each do |x, y|
    north = @grid[y-1][x] unless y == 0
    south = @grid[y+1][x] unless y == @grid.length
    west = @grid[y][x-1] unless x == 0
    east = @grid[y][x+1] unless x == @grid[0].length
    new_positions << [x, y-1] if [".","S"].include? north
    new_positions << [x, y+1] if [".","S"].include? south
    new_positions << [x-1, y] if [".","S"].include? west
    new_positions << [x+1, y] if [".","S"].include? east
  end
  @current_positions = new_positions.uniq
end

def step_once_expanded
  new_positions = []
  @current_positions.each do |x, y|
    if y == 0
      y += @initial_grid.length
      expand("north")
    end
    expand("south") if y == @grid.length - 1
    if x == 0
      x += @initial_grid[0].length
      expand("west")
    end
    expand("east") if x == @grid[0].length - 1
    north = @grid[y-1][x]
    south = @grid[y+1][x]
    west = @grid[y][x-1]
    east = @grid[y][x+1]
    new_positions << [x, y-1] if [".","S"].include? north
    new_positions << [x, y+1] if [".","S"].include? south
    new_positions << [x-1, y] if [".","S"].include? west
    new_positions << [x+1, y] if [".","S"].include? east
  end
  @current_positions = new_positions.uniq
end

def expand(direction)
  # @grid.each { |line| p line.join }
  if direction == "north"
    p direction
    @initial_grid.each do |line|
      l = line* @current_grid[0]
      @grid.prepend(l)
    end
    @current_positions.map! { |x, y| [x, y + @initial_grid.length] }
    @current_grid[1] += 1
  elsif direction == "south"
    p direction
    @initial_grid.each do |line|
      l = line* @current_grid[0]
      @grid << l
    end
    @current_grid[1] += 1
  elsif direction == "west"
    p direction
    @grid = @grid.transpose
    transposed = @initial_grid.transpose.reverse
    transposed.each do |line|
      line = line.reverse
      l = line * @current_grid[1]
      @grid.prepend(l)
    end
    @current_positions.map! { |x, y| [x + @initial_grid.length, y] }
    @current_grid[0] += 1
    @grid = @grid.transpose
    # p @grid.length
    # p @grid[0].length
  elsif direction == "east"
    p direction
    @grid = @grid.transpose
    @initial_grid.transpose.each do |line|
      l = line* @current_grid[1]
      @grid << l
    end
    @current_grid[0] += 1
    @grid = @grid.transpose
  end
  # @grid.each { |line| p line.join }
  p "---------------"
end

def step2(example = false)
  @grid = []
  @step = 0
  @current_grid = [1,1]
  @current_positions = []
  input(example).each do |line|
    @grid <<  line.strip.chars
  end
  @initial_grid = @grid
  initial_position
  50.times do
    step_once_expanded
  end
  p @current_positions.count
  # @grid.each do |line|
  #   puts line.join
  # end
end


def input(example)
  example == 'example' ? @input_example : @input
end
