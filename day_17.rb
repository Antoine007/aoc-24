def step1(example = false)
  a = input(example).first.split(" ").last.to_i
  b = input(example)[1].split(" ").last.to_i
  c = input(example)[2].split(" ").last.to_i

  program = input(example).last.split(" ").last.split(",").map(&:to_i)
  p [a,b,c,program]
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
