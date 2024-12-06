def step1(example = false)
  map = []
  direction = "n"
  guard = [nil,nil]
  input(example).each_with_index do |line, index|
    map << line.strip.split('')
    guard = [line.strip.index("^"), index] if line.strip.include?("^")
  end
  p guard
  # p map
  while guard[0] > 0 && guard[0] < map.length && guard[1] > 0 && guard[1] < map[0].length
    direction = move(guard, direction, map)
    # map.each do |line|
    #   p line.join
    # end
  end

  count = 0
  map.each do |line|
    count += line.count("X")
  end
  p count
end

def step2(example = false)
  map = []
  direction = "n"
  guard = [nil,nil]
  input(example).each_with_index do |line, index|
    map << line.strip.split('')
    guard = [line.strip.index("^"), index] if line.strip.include?("^")
  end
  # p guard
  # p map
  obstacles = [] 
  map.each_with_index do |line, index|
    line.each_with_index.select { |c, i| obstacles << [i,index] if c == "." }
  end
  # p obstacles
  valid = []
  obstacles.each do |obstacle|
    new_map = Marshal.load(Marshal.dump(map))
    new_map[obstacle[1]][obstacle[0]] = "#"
    # Reset guard position for each iteration
    current_guard = guard.dup
    visited = Set.new
    # p current_guard
    # p direction

    while current_guard[0] > 0 && current_guard[0] < map.length && current_guard[1] > 0 && current_guard[1] < map[0].length
      state = [current_guard[0], current_guard[1], direction]
      if visited.include?(state)
        # p obstacle
        valid << obstacle
        break
      end
      visited.add(state)

      direction = move2(current_guard, direction, new_map)
    end
    direction = "n"
  end

  p valid.count
end


def input(example)
  example == 'example' ? @input_example : @input
end

def move(guard, direction, map)  
  case direction
  when "n"
    if map[guard[1] - 1] && map[guard[1] - 1][guard[0]] == "#"
      "e"
    else
      map[guard[1]][guard[0]] = "X"
      guard[1] -= 1
      "n"
    end
  when "s"
    if map[guard[1] + 1] && map[guard[1] + 1][guard[0]] == "#"
      "w"
    else
      map[guard[1]][guard[0]] = "X"
      guard[1] += 1
      "s"
    end
  when "e"
    if map[guard[0]+1] && map[guard[1]][guard[0] + 1] == "#"
      "s"
    else
      map[guard[1]][guard[0]] = "X"
      guard[0] += 1
      "e"
    end
  when "w"
    if map[guard[0]-1] && map[guard[1]][guard[0] - 1] == "#"
      "n"
    else
      map[guard[1]][guard[0]] = "X"
      guard[0] -= 1
      "w"
    end
  end
end
def move2(guard, direction, map)  
  case direction
  when "n"
    if map[guard[1] - 1] && map[guard[1] - 1][guard[0]] == "#"
      "e"
    else
      guard[1] -= 1
      "n"
    end
  when "s"
    if map[guard[1] + 1] && map[guard[1] + 1][guard[0]] == "#"
      "w"
    else
      guard[1] += 1
      "s"
    end
  when "e"
    if map[guard[0]+1] && map[guard[1]][guard[0] + 1] == "#"
      "s"
    else
      guard[0] += 1
      "e"
    end
  when "w"
    if map[guard[0]-1] && map[guard[1]][guard[0] - 1] == "#"
      "n"
    else
      guard[0] -= 1
      "w"
    end
  end
end
