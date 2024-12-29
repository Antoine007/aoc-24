def step1(example = false)
  @grid = Array.new(example ? 7 : 101) { Array.new(example ? 7 : 101, '.') }
  bytes = []
  input(example).map {|line| bytes << line.strip.split(",").map(&:to_i)}
  p bytes
end

def step2(example = false)

end

def input(example)
  example == 'example' ? @input_example : @input
end
