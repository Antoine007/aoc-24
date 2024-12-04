def step1(example = false)
  total = 0
  input(example)[0].scan(/mul\((\d+),(\d+)\)/) do |match|
    total += match[0].to_i * match[1].to_i
  end 
  p total
end

def step2(example = false)
  total = 0
  input(example).each do |line|
    do_it = true
    line.scan(/mul\((\d+),(\d+)\)|(don't\(\))|(do\(\))/) do |a, b, c|
      if c == "don't()"
        do_it = false
      elsif [a,b,c] == [nil, nil, nil]
        do_it = true
      elsif c == nil
        total += (a.to_i * b.to_i) if do_it
      end
    end
  end
  p total
end

def input(example)
  example == 'example' ? @input_example : @input
end
