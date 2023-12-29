def step1(example = false)
  @grid = [["#"]]

  # left,right,top,bottom
  edges = [0,1,0,1]
  current = [0,0] #x,y

  input(example).each_with_index do |line, index|
    # break if index == 7
    dir, distance, color = line.split(" ")
    i = dir == 'R' || dir == 'L' ? 0 : 1
    distance = distance.to_i

    new_current = current.dup
    new_current[i] += distance * (dir == 'R' || dir == 'D' ? 1 : -1)

    if i == 0 # horizontal move
      until current[0] == new_current[0]
        if dir == "L"
          if new_current[0] < 0
            diff = new_current[0] - edges[0]
            edges[0] = 0
            new_current[0] = 0
            grid.each do |line|
              diff.times { line.prepend('.') }
            end
            current[0] -= diff

            edges[1] = edges[1] - diff
          else
            edges[0] = new_current[i]  unless new_current[i] > edges[0]
          end
          current[0] -= 1
        else
          edges[1] = new_current[i] unless new_current[i] < edges[1]
          current[0] += 1
        end
        if (edges[0]..edges[1]).include? current[0] #existing row
          @grid[current[1]][current[0]] = '#'
        else
          if dir == "L"
            @grid[current[1]].prepend('#')
          else
            @grid[current[1]].append('#')
          end
        end
      end
    else # vertical move
      until current[1] == new_current[1]
        if dir == "U"
          edges[2] = new_current[1]
          current[1] -= 1
          @grid.prepend(Array.new(@grid[0].length, '.')) unless @grid[current[1]]
        else
          edges[3] = new_current[1]
          current[1] += 1
          @grid.append(Array.new(@grid[0].length, '.')) unless @grid[current[1]]
        end
        @grid[current[1]][current[0]] = '#'
      end
    end
  end
  @grid.each do |line|
    fill = false
    toggled = false
    line.each_with_index do |char, i|
      if char == '#'
        toggled ?
         fill = false :
          fill = true
      else
        toggled = true if fill
        line[i] = "#" if fill
      end
    end
  end
  sum = 0
  @grid.each do |line|
    sum += line.count('#')
    p line.join
  end
  p sum
end

def step2(example = false)

end

def input(example)
  example == 'example' ? @input_example : @input
end
