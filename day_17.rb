def step1(example = false)
  input(example).each do |line|
    puts line
  end
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
