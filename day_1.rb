def step1(example = false)
  numbers = []
  input(example).each do |line|
    number = ""
    number << line.gsub(/[^0-9]/, '')[0]
    number << line.reverse.gsub(/[^0-9]/, '')[0]
    numbers << number.to_i
  end
  # p numbers
  p numbers.sum
end

NUMBERS = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9
}

def step2(example = false)
  numbers = []
  input(example).each do |line|
    number = ""
    ar = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
    if NUMBERS[ar[0]]
      number << NUMBERS[ar[0]].to_s
    else
      number << ar[0].to_s
    end

    if NUMBERS[ar[-1]]
      number << NUMBERS[ar[-1]].to_s
    else
      number << ar[-1].to_s
    end
    numbers << number.to_i
  end
  # p numbers
  p numbers.sum
end

def input(example)
  example == 'example' ? @input_example : @input
end
