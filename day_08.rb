def step1(example = false)
  directions = input(example)[0].strip.chars
  rows = make_rows(example)

  steps = 0
  current = 'AAA'

  while current != 'ZZZ'
    direction = directions[steps % directions.length]
    steps += 1
    current = rows[current][direction.to_sym]
    # p current
  end
  p steps
end

def brute_step2(example = false)
  directions = input(example)[0].strip.chars
  rows = make_rows(example)

  steps = 0
  current = rows.select{|k,v| k[2] == 'A'}.keys

  while current.select{|c| c[2] != 'Z'}.count > 0
    p steps
    direction = directions[steps % directions.length]
    steps += 1
    current = current.map do |c|
      rows[c][direction.to_sym]
    end
  end
  p steps
end

def make_rows(example)
  rows = {}
  input(example)[2..-1].map{ |row|
    place =  row.strip.split(" = ")
    left = place[1].split(", ")[0].gsub("(", "")
    right = place[1].split(", ")[1].gsub(")", "")
    rows[place[0]] = {L: left, R: right}
  }
  rows
end


def input(example)
  example == 'example' ? @input_example : @input
end

def step2(example= false)
  data = input(example)
  solve_part_two(data)
end



 def solve_part_two(data)
    info = parse_data(data)
    number_of_steps = 0
    instruction_index = 0
    origins = info[:steps].keys.select { |key| key[2] == 'A' }
    steps_separated = []
    origins.each do |origin|
      steps_separated << number_of_steps_part_2(info, origin)
    end
    p steps_separated.reduce(1, :lcm)
  end

  def number_of_steps_part_2(info, origin)
    destination = [nil, nil, nil]
    number_of_steps = 0
    instruction_index = 0
    while destination[2] != "Z"
      origin, destination, instruction_index = next_destination(info, origin, instruction_index)
      number_of_steps += 1
    end
    number_of_steps
  end

  def next_destination(info, origin, instruction_index)
    instruction = info[:instructions][instruction_index]

    if instruction == 'L'
      destination = info[:steps][origin][:left]
    else
      destination = info[:steps][origin][:right]
    end
    origin = destination
    instruction_index = (instruction_index + 1) % info[:instructions].length
    [origin, destination, instruction_index]
  end

  def parse_data(data)
    info = {
      instructions: [],
      steps: {}
    }
    data.each_with_index do |line, i|
      if i == 0
        info[:instructions] = line.strip.split('')
      elsif i == 1
        next
      else
        origin, destination = line.strip.split(' = ')
        destination.gsub!("(", "").gsub!(")", "").gsub!(" ", "")
        left, right = destination.split(',')
        info[:steps][origin] = {left: left,right: right}
      end
    end
    info
  end
