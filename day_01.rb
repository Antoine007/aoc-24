def step1(example = false)
  l1 = []
  l2 = []
  total = 0
  input(example).each do |line| 
    l1 << line.split[0].to_i
    l2 << line.split[1].to_i
  end
  l1 = l1.sort  
  l2 = l2.sort

  l1.each_with_index do |x, i|
    total += (x - l2[i]).abs
  end
  p total
end


def step2(example = false)
  l1 = []
  l2 = []
  total = 0
  input(example).each do |line| 
    l1 << line.split[0].to_i
    l2 << line.split[1].to_i
  end
  l1.each do |x|
    total += (l2.count(x) * x)
  end
  p total
end

def input(example)
  example == 'example' ? @input_example : @input
end
