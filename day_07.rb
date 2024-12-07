def step1(example = false)
  calcs = []
  count = 0
  input(example).each do |line|
    result = line.strip.split(':').first.to_i
    numbers = line.strip.split(':').last.split(' ').map(&:to_i)
    calcs << {result: result, numbers: numbers}
  end

  calcs.each do |calc|
    p calc
    count += op(calc[:result], calc[:numbers])
  end
  p count
end

def step2(example = false)
  calcs = []
  count = 0
  input(example).each do |line|
    result = line.strip.split(':').first.to_i
    numbers = line.strip.split(':').last.split(' ').map(&:to_i)
    calcs << {result: result, numbers: numbers}
  end

  calcs.each do |calc|
    p calc
    count += op(calc[:result], calc[:numbers], true)
  end
  p count
end

def input(example)
  example == 'example' ? @input_example : @input
end

def op(result, numbers, two = false)
  count = 0
  operations = two ? [:+, :*, :z] : [:+, :*]
  # p operations
  options_length = numbers.length - 1
  options = operations.repeated_permutation(options_length).to_a
  # p options
  options.each do |option|
    total = numbers[0]
    option.each_with_index do |op, index|
      if op == :z
        total = "#{total}#{numbers[index + 1]}".to_i
      else
        total = total.send(op, numbers[index + 1])
      end
    end
    # p total
    # p result
    if total == result
      p option
      count += result
      break
    end
  end
  count
end
