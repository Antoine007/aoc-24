def step1(example = false)
  lines = []
  input(example).each do |line|
    lines << line.split(' ').map(&:to_i)
  end
  result = []
  lines.each do |line|
    row = find_result_per_line(line)
    result << extrapolate(row)
  end
  p result
  p result.collect{|l| l.first.last}.sum
end

def find_result_per_line(line)
  matrix = [line]
  matrix.each_with_index do |line, index|
    if line.all? { |char| char == 0 }
      next
    else
      new_line = []
      line.each_with_index do |char, index|
        break if index == line.size - 1
        new_line <<  line[index+1] - line[index]
      end
      matrix << new_line
    end
  end
end

def extrapolate(matrix, back = false)
  result = []

  matrix.reverse.each_with_index do |line, index|
    if back
      if index == 0
        line.unshift(0)
      else
        new_value =  line.first - matrix.reverse[index - 1].first
        line.unshift(new_value)
      end
    else
      if index == 0
        line << 0
      else
        new_value = matrix.reverse[index - 1].last + line.last
        line << new_value
      end
    end
    result << line
    break if index == matrix.size - 1
  end
  result.reverse
end

def step2(example = false)
  lines = []
  input(example).each do |line|
    lines << line.split(' ').map(&:to_i)
  end
  result = []
  lines.each do |line|
    row = find_result_per_line(line)
    result << extrapolate(row, true)
  end
  # p result
  p result.collect{|l| l.first.first}.sum
end


def input(example)
  example == 'example' ? @input_example : @input
end
