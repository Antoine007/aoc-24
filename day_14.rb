def step1(example = false)
  grid_size = example ? [11,7] : [101,103]
  grid = Array.new(grid_size[1]) { Array.new(grid_size[0], 0) }
  grid_display(grid)
  robots = []
  input(example).each do |line|
    position, vector = line.strip.split(' ')
    x,y = position.split('=')[1].split(",")
    vx,vy = vector.split('=')[1].split(",")
    robots << [x.to_i,y.to_i,vx.to_i,vy.to_i]
  end
  # p robots
  initial_placement(robots, grid)
  grid_display(grid)
  
  100.times do |t|
    robots.map! do |robot|
      one_turn(robot, grid, grid_size)
    end
  end
  grid_display(grid)

  # nw, ne, sw, se 
  corners = [0,0,0,0]
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, i|
      next if cell == 0
      corners[0] += cell if y < ((grid_size[1] - 1) / 2) && i < ((grid_size[0] - 1) / 2)
      corners[1] += cell if y < ((grid_size[1] - 1) / 2) && i > ((grid_size[0] - 1) / 2)
      corners[2] += cell if y > ((grid_size[1] - 1) / 2) && i < ((grid_size[0] - 1) / 2)
      corners[3] += cell if y > ((grid_size[1] - 1) / 2) && i > ((grid_size[0] - 1) / 2)
    end
  end
  p corners
  p corners.reduce(:*)
end

def step2(example = false)
  grid_size = example ? [11,7] : [101,103]
  grid = Array.new(grid_size[1]) { Array.new(grid_size[0], 0) }
  grid_display(grid)
  robots = []
  input(example).each do |line|
    position, vector = line.strip.split(' ')
    x,y = position.split('=')[1].split(",")
    vx,vy = vector.split('=')[1].split(",")
    robots << [x.to_i,y.to_i,vx.to_i,vy.to_i]
  end
  # p robots
  initial_placement(robots, grid)
  
  Array(0..20000).each do |t|
    p t if t % 100 == 0
    robots.map! do |robot|
      grid_display_egg(grid, t)
      one_turn(robot, grid, grid_size)
    end
  end
  
end

def input(example)
  example == 'example' ? @input_example : @input
end

def grid_display(grid)
  grid.each do |row|
    p row.join
  end
end
def grid_display_egg(grid, t)
  if grid.any? { |row| row.join.match?(/([^0])\1{19}/) }
    grid.each do |row|
      p row.join
    end
    p "t: #{t}"
  end
end

def one_turn(robot, grid, grid_size)
  x,y,vx,vy = robot
  grid[y][x] -= 1
  proper_y = y + vy
  proper_x = x + vx
  if proper_y >= grid_size[1] 
    proper_y -= grid_size[1]
  end
  if proper_x >= grid_size[0]
    proper_x -= grid_size[0]
  end
  if proper_y < 0
    proper_y += grid_size[1]
  end
  if proper_x < 0
    proper_x += grid_size[0]
  end
  # p "proper_y: #{proper_y}, proper_x: #{proper_x}"
  robot = [proper_x, proper_y, vx, vy]
  grid[proper_y][proper_x] += 1
  robot
end

def initial_placement(robots, grid)
  robots.each do |robot|
    x,y,vx,vy = robot
    grid[y][x] += 1
  end
end