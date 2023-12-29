def step1(example = false)
  @grid = []
  @activated = []
  @existing = []
  @beams = [[0,0,:e]]
  input(example).each do |line|
    @grid << line.chars
    @activated << Array.new(line.strip.length,'.')
  end
  @grid.each {|line| puts line.join('')}

  until @beams.length == 0
  # 500.times do
    # p @beams
    move
  end
  @activated.each {|line| puts line.join('')}
  sum = 0
  @activated.each do |line|
    line.each do |char|
      sum += 1 if char == '#'
    end
  end
  p sum
end

def move
  new_beams = []
  @beams.map do |beam|
    @existing << beam
    x,y,dir = beam
    @activated[y][x] = '#'
    if dir == :e
      x += 1
    elsif dir == :s
      y += 1
    elsif dir == :w
      x -= 1
    elsif dir == :n
      y -= 1
    end

    if x < 0 || y < 0 || x == (@grid.length) || y == (@grid.length)
      next
    end

    if @grid[y][x] == '/'
      case dir
      when :e
        dir = :n
      when :s
        dir = :w
      when :w
        dir = :s
      when :n
        dir = :e
      end
    elsif @grid[y][x] == '|'
      if dir == :e || dir == :w
        dir = :n
        new_beams << [x,y,:s] unless @existing.include?([x,y,dir])
      end
    elsif @grid[y][x] == '-'
      if dir == :s || dir == :n
        dir = :w
        new_beams << [x,y,:e] unless @existing.include?([x,y,dir])
      end
    elsif @grid[y][x] == '\\'
      case dir
      when :e
        dir = :s
      when :s
        dir = :e
      when :w
        dir = :n
      when :n
        dir = :w
      end
    end
    new_beams << [x,y,dir] unless @existing.include?([x,y,dir])
  end
  # p new_beams
  @beams = new_beams
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
