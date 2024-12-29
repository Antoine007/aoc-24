def step1(example = false)
  grid = []
  position = [1,grid.length - 1]
  direction = "right"
  finish = [grid[0].length - 1, 1]
  input(example).each do |line|
    grid << line.strip.chars
  end
  display(grid)
  # until position == finish
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end

def display(grid)
  grid.each {|line| puts line.join('')}
end
