def step1(example = false)
  @paths = [[[1,0],[1,1]]]
  @grid = []
  input(example).each do |line|
    @grid << line.strip.chars
  end
  @target = [@grid.length - 1, @grid[0].length - 1]
  @ended = []
  # p @target
  # @grid.each {|l| puts l.join}
  until @paths.length == 0
    path = @paths.first
    x,y = path.last
    options = []
    north = [x,y-1] unless y==0
    south = [x,y+1] unless y==@grid.length - 1
    west = [x-1,y] unless x==0
    east = [x+1,y] unless x==@grid.length - 1
    if north && [">","<","v","^","."].include?(@grid[north[1]][north[0]]) && !path.include?(north)
      north = correct(north)
      options << north unless path.include?(north)
    end
    if south && [">","<","v","^","."].include?(@grid[south[1]][south[0]]) && !path.include?(south)
      south = correct(south)
      options << south unless path.include?(south)
    end
    if east && [">","<","v","^","."].include?(@grid[east[1]][east[0]]) && !path.include?(east)
      east = correct(east)
      options << east unless path.include?(east)
    end
    if west && [">","<","v","^","."].include?(@grid[west[1]][west[0]]) && !path.include?(west)
      west = correct(west)
      options << west unless path.include?(west)
    end
    # p options
    if options.include? @target
      @ended << path
      @paths.delete(path)
      next
    else
      options.each do |option|
        @paths << (path.dup + [option])
      end
      @paths.delete(path)
      p @paths
    end
    p @paths.length
    break if @paths.length > 15
  end
  p @ended
end

def step2(example = false)

end


def correct(dir)
  test_val = @grid[dir[1]][dir[0]]
  return [dir[0]+1,dir[1]] if test_val == ">"
  return [dir[0]-1,dir[1]] if test_val == "<"
  return [dir[0],dir[1]+1] if test_val == "v"
  return [dir[0],dir[1]-1] if test_val == "^"
  dir
end

def input(example)
  example == 'example' ? @input_example : @input
end
