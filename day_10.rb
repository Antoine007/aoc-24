def step1(example = false)
  @side_length = input(example).length
  @position = nil
  grid = []
  input(example).each_with_index do |line, y|
    grid << line.strip.chars
    line.strip.chars.each_with_index do |char, x|
      @position = [x,y] if char == 'S'
    end
  end
  p grid
  p @side_length
  p @position


  # ---
  @trips  = [@position]
  loop()
  trips.each do |t|
    p "trip"
    p t
  end;0
end


def loop
  trips = [@position]
  while true
    x,y = position
    n = [x, y + 1]
    s = [x, y - 1]
    w = [x - 1, y]
    e = [x + 1, y]
    trips = []
    [n,s,w,e].each do |pos|
      next if pos[0] < 0 || pos[1] < 0 || pos == '.' || pos[0] > @side_length || pos[1] > @side_length

      new_trip = old_trips.dup
      new_trip << pos
      trips << new_trip
      break if pos == @position
    end
  end
  trips
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
