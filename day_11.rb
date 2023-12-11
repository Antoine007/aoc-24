def step1(example = false)
  @galaxy = []
  build_galaxy(input(example))
  p @galaxy.length
  p @galaxy[0].length
  # p @galaxy
  expand_galaxy
  p @galaxy.length
  p @galaxy[0].length

  stars = {}

  @galaxy.each_with_index do |line, y|
    # p line.join
    line.each_with_index do |char, x|
      stars[stars.length + 1] = [x,y] if char == '#'
    end
  end
  # p stars
  pairs = make_pairs(stars)
  distances = []
  pairs.each do |pair|
    x1, y1 = stars[pair[0]]
    x2, y2 = stars[pair[1]]

    distance = (x2 - x1).abs + (y2 - y1).abs
    distances << distance
  end
  p distances.sum
end

def make_pairs(stars)
  stars.keys.combination(2).to_a
end

def build_galaxy(input)
  input.each do |line, y|
    @galaxy << line.strip.chars
  end
end

def expand_galaxy(huge = false)
  time = huge == 'huge' ? 10 : 1
  time -= 1
  @xs = []
  @galaxy[0].length.times do |x|
    add = true
    @galaxy.each do |line|
      if line[x] == '#'
        add = false
        break
      end
    end
    @xs << x if add
  end

  # @xs.reverse.each do |i|
  #   time.times do
  #     @galaxy.each{|line| line.insert(i, '.')}
  #   end
  # end

  new_array = Array.new(@galaxy[0].length, '.')
  @indices = []
  @galaxy.length.times do |y|
    @indices << y if @galaxy[y].uniq.count == 1
  end
  # indices.reverse.each do |i|
  #   time.times do
  #     @galaxy.insert(i, new_array)
  #   end
  # end
end

def step2(example = false)
  @galaxy = []
  build_galaxy(input(example))
  p @galaxy.length
  p @galaxy[0].length
  # p @galaxy
  expand_galaxy('huge')
  p @galaxy.length
  p @galaxy[0].length

  stars = {}

  @galaxy.each_with_index do |line, y|
    # p line.join
    line.each_with_index do |char, x|
      stars[stars.length + 1] = [x,y] if char == '#'
    end
  end
  # p stars
  pairs = make_pairs(stars)
  distances = []
  pairs.each do |pair|
    x1, y1 = stars[pair[0]]
    x2, y2 = stars[pair[1]]

    distance = (x2 - x1).abs + (y2 - y1).abs
    x_array  = x1 < x2 ? (x1..x2) : (x2..x1)
    y_array  = y1 < y2 ? (y1..y2) : (y2..y1)
    x_array.each do |x|
      distance += 999_999 if @xs.include?(x)
    end
    y_array.each do |y|
      distance += 999_999 if @indices.include?(y)
    end
    distances << distance
  end
  p distances.sum
end


def input(example)
  example == 'example' ? @input_example : @input
end
