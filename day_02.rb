def step1(example = false)
  count = 0
  input(example).each do |line|
    report = line.split(" ").map(&:to_i)
    count += report_safety(report)
  end
  p count
end

def report_safety(report)
  direction = nil
  report.each_with_index do |x, i|
    next if i == 0
    return 0 if direction == 'up' && x < report[i - 1]
    return 0 if direction == 'down' && x > report[i - 1]
    return 0 if (x - report[i - 1]).abs > 3 || x - report[i - 1] == 0

    direction = x > report[i - 1] ? 'up' : 'down'
  end
  return 1
end

def step2(example = false)
  count = 0
  input(example).each do |line|
    report = line.split(" ").map(&:to_i)
    reports = []
    results = []
    report.length.times do |i|
      temp_report = report.dup 
      temp_report.delete_at(i) 
      reports << temp_report   
    end
    reports.each do |x|
      results << report_safety(x)
    end
    count += 1 if results.include?(1)
  end
  p count
end


def input(example)
  example == 'example' ? @input_example : @input
end
