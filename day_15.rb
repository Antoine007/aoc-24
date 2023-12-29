def step1(example = false)
  sum = 0
  input(example)[0].strip.split(",").each do |line|
    result= 0
    line.chars do |char|
      result += char.ord
      result *= 17
      result = result % 256
    end
    sum += result
  end
  p sum
end

def step2(example = false)
  sum = 0
  boxes = {}
  256.times do |i|
    boxes[i] = []
  end
  input(example)[0].strip.split(",").each do |line|
    if line.include? "-"
      label, dash= line.split('-')
      # p "--"
      # p label
      box = box_finder(label)
      # p box
      boxes[box].delete_if{|string| string[0...label.length] == label}
    else
      # p "--"
      label, lens= line.split('=')
      box = box_finder(label)
      # p label
      lens = lens.to_i
      # p box
      index = boxes[box].index do |string|
        string[0...label.length] == label
      end
    index ?
      boxes[box][index] = "#{label} #{lens}" :
      boxes[box] << "#{label} #{lens}"
    end
  end
  # p boxes
  p final_count(boxes)
end

def box_finder(label)
  result = 0
  label.chars.each do |char|
    result += char.ord
    result *= 17
    result = result % 256
  end
  result
end

def final_count(boxes)
  count = 0
  boxes.each do |key, value|
    value.each_with_index do |val, i|
      x = (key.to_i + 1) * (i+1) * val.split(" ")[1].to_i
      p x
      count += x
    end
  end
  count
end

def input(example)
  example == 'example' ? @input_example : @input
end
