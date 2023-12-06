def step1(example = false)
  values = Array.new(input(example).length, [])
  input(example).each_with_index do |line,index|
    line.split(":")[1].strip.split(' ').each_with_index do |number,i|
      new_v = values[i] ? [values[i], number.to_i].flatten : [number.to_i]
      values[i] = new_v
    end
  end

  min_time = []
  values.each do |time, distance|
    distances = []
    (0..time).each_with_index do |pressed_x_seconds|
      distances << pressed_x_seconds * (time - pressed_x_seconds)
    end
    min_time << distances.select{|x| x > distance}.count
  end
  p min_time.inject(:*)
end

def step2(example = false)
  time = input(example)[0].split(":")[1].gsub(" ", "").to_i
  distance = input(example)[1].split(":")[1].gsub(" ", "").to_i
  distances = []
  (0..time).each_with_index do |pressed_x_seconds|
    distances << pressed_x_seconds * (time - pressed_x_seconds)
  end

  p distances.select{|x| x > distance}.count
end


def input(example)
  example == 'example' ? @input_example : @input
end
