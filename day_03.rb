SYMBOLS = ["%","&","$","*","#", "+", "@", "/", "=", "-"]
def step1(example = false)
  sum = 0
  input = input(example)
  input.each_with_index do |line, i|
    # break if i > 5
    number_pattern = /\d+/
    matches = line.enum_for(:scan, number_pattern).map do
      match = Regexp.last_match
      { value: match[0].to_i, row: i, column: match.begin(0) }
    end

    matches.each do |match|
      values = []
      values <<  to_scan(input[match[:row] - 1], match[:value].to_s.length, match[:column]) unless match[:row] == 0
      values << to_scan(line, match[:value].to_s.length, match[:column])
      values << to_scan(input[match[:row] + 1], match[:value].to_s.length, match[:column]) unless match[:row] == input.length - 1

      add = true
      # p values.flatten.join("").strip
      values.flatten.join("").strip.chars.each do |char|
        add = false if SYMBOLS.include?(char)
      end
      p match[:value] if add
      sum += match[:value] unless add
    end
  end
  p sum
end

def  to_scan(row, value_length, index)
  a = [index - 1, 0].max
  b = [index + value_length, row.length - 1].min
  row[a..b].strip + " "
end

def step2(example = false)
  sum = 0
  input = input(example)
  input.each_with_index do |line, i|
    # break if i > 5
    number_pattern = /\d+/
    matches = line.enum_for(:scan, /\*/).map do
      match = Regexp.last_match
      { row: i, column: match.begin(0) }
    end

    matches.each do |match|
      # p match
      values = []
      values <<  to_scan_number(input[match[:row] - 1], match[:column]) unless match[:row] == 0
      values << to_scan_number(line, match[:column])
      values << to_scan_number(input[match[:row] + 1], match[:column]) unless match[:row] == input.length - 1

      number_pattern = /\d+/
      matches = line.enum_for(:scan, number_pattern).map do
        match = Regexp.last_match
        { value: match[0].to_i, row: i, column: match.begin(0) }
      end
      add = true
      values = values.flatten
      p values
      sum += values.inject(:*) if values.length == 2
    end
  end
  p sum
end

def  to_scan_number(row, index)
  matches = []
  row.enum_for(:scan, /\d+/).each do
    match = Regexp.last_match
    indices = (match.begin(0)..match.end(0) - 1)
    matches << match[0].to_i  if indices.include?(index) || indices.include?(index + 1) || indices.include?(index - 1)
  end
  # p matches
  matches
end


def input(example)
  example == 'example' ? @input_example : @input
end
