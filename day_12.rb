def step1(example = false)
  total = 0
  input(example).each do |line|
    line = line.strip
    status, damaged_lengths = line.split(" ")
    damaged_lengths = damaged_lengths.split(",").map(&:to_i)

    known_damaged = status.each_char.with_index.select { |c, _| c == '#' }.map(&:last)
    unknown = status.each_char.with_index.select { |c, _| c == '?' }.map(&:last)
    remaining = damaged_lengths.sum - known_damaged.length
    raise "Invalid input: remaining damage cannot be negative" if remaining.negative?

    ways = 0
    unknown.combination(remaining).each do |t|
      ranges = []
      range_len = 0
      status.each_char.with_index do |c, i|
        if c == '?'
          c = t.include?(i) ? '#' : '.'
        end
        if range_len > 0
          if c == '#'
            range_len += 1
          else
            ranges << range_len
            range_len = 0
          end
        else
          if c == '#'
            range_len += 1
          end
        end
      end
      ranges << range_len if range_len > 0

      ways += 1 if ranges == damaged_lengths
    end
    total += ways
  end
  puts total
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
