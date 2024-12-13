def step1(example = false)
  lines = []
  input(example).each do |line|
    next if line.strip.empty?
    puts line
    if line[7] == "A" 
      lines << ["A",line[12..13].to_i,line[18..19].to_i]
    elsif line[7] == "B"
      lines << ["B",line[12..13].to_i,line[18..19].to_i]
    else
      lines << ["P",line.split(" ")[1][2..-1].to_i,line.split(" ")[2][2..-1].to_i]
    end
  end
  eqs = []
  lines.reverse.each_slice(3) do |ls|
    eqs << [ls[0][1],ls[0][2],ls[1][1],ls[1][2],ls[2][1],ls[2][2]]
  end
  eqs = eqs.reverse

  count = 0
  final = []
  eqs.each do |eq|
    a,b,bx,by,ax,ay = eq
    valids = []
    (0..100).each do |i|
      (0..100).each do |y|
        if [a,b] == [(ax * i) + (bx * y), (ay * i) + (by * y)]
          valids << [eq,i,y]
        end
      end
    end
    p valids
    final << valids
  end
  final.flatten(1).each do |f|
    count += (f[1]*3) + f[2]
  end
  # p count
end

def step2(example = false)
  lines = []
  input(example).each do |line|
    next if line.strip.empty?
    # puts line
    if line[7] == "A" 
      lines << ["A",line[12..13].to_i,line[18..19].to_i]
    elsif line[7] == "B"
      lines << ["B",line[12..13].to_i,line[18..19].to_i]
    else
      lines << ["P",line.split(" ")[1][2..-1].to_i + 10000000000000,line.split(" ")[2][2..-1].to_i + 10000000000000]
    end
  end
  eqs = []
  lines.reverse.each_slice(3) do |ls|
    eqs << [ls[0][1],ls[0][2],ls[1][1],ls[1][2],ls[2][1],ls[2][2]]
  end
  eqs = eqs.reverse
  # p eqs
  count = 0
  final = []
  eqs.each do |eq|
    a,b,bx,by,ax,ay = eq
    valids = []
    # p [ax,ay,bx,by,a,b]
    solution = solve_linear_system(ax, ay, bx, by, a, b)
    if solution
      valids << [eq, solution[0], solution[1]]
    end
    # p valids.count
    final << valids
  end
  final.flatten(1).each do |f|
    count += (f[1]*3) + f[2]
  end
  p count
end


def input(example)
  example == 'example' ? @input_example : @input
end


# Given equations:
# a = ax*i + bx*y
# b = ay*i + by*y

# We can rewrite this as a matrix equation:
# [ax bx] [i] = [a]
# [ay by] [y]   [b]

def solve_linear_system(ax, ay, bx, by, a, b)
  # Using Cramer's rule to solve the system
  determinant = (ax * by) - (bx * ay)
  return nil if determinant == 0 # No unique solution

  # Solve for i and y
  i = ((a * by) - (b * bx)) / determinant.to_f
  y = ((ax * b) - (ay * a)) / determinant.to_f
  p [i,y]
  # Check if solutions are non-negative integers
  if i >= 0 && y >= 0 && i == i.to_i && y == y.to_i
    return [i.to_i, y.to_i]
  end
  
  nil
end