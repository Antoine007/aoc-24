def step1(example = false)
  grid = []
  antennas = {}
  input(example).each do |line|
    grid << line.strip.chars
  end
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell != '.'
        if antennas[cell].nil?
          antennas[cell] = [[x, y]]
        else
          antennas[cell] << [x, y]
        end
      end
    end
  end
  an = []
  antennas.each do |antenna, positions|
    combos = positions.combination(2).to_a
    combos.each do |combo|
      a, b = combo

      x_diff = a[0] - b[0]
      y_diff = a[1] - b[1]

      # [[8, 1], [5, 2]]
      # 8 + 3
      # 1 - 1

      # 5 - 3
      # 2 + 1
      # [[11,0], [2,3]]
     
      y = [a[0] + x_diff, a[1] + y_diff]
      z = [b[0] - x_diff, b[1] - y_diff]
      p [combo, y, z]
      an << z
      an << y
    end
  end
  an = an.select { |a| a[0] >= 0 && a[1] >= 0 && a[0] < grid.length && a[1] < grid[0].length }.sort.uniq
  p an
  p an.count
end

def step2(example = false)
  grid = []
  antennas = {}
  input(example).each do |line|
    grid << line.strip.chars
  end
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell != '.'
        if antennas[cell].nil?
          antennas[cell] = [[x, y]]
        else
          antennas[cell] << [x, y]
        end
      end
    end
  end
  an = []
  antennas.each do |antenna, positions|
    combos = positions.combination(2).to_a
    combos.each_with_index do |combo, i|
      res = []
      a, b = combo
      # p "combo"
      # p combo

      x_diff = a[0] - b[0]
      y_diff = a[1] - b[1]

      # [[8, 1], [5, 2]]
      # 8 + 3
      # 1 - 1

      # 5 - 3
      # 2 + 1
      # [[11,0], [2,3]]

      f = [a[0], a[1]]
      while f[0] >= 0 && f[0] < grid.length && f[1] >= 0 && f[1] < grid[0].length
        # p "loop f #{f}"
        res << f
        f = [res.last[0] + x_diff, res.last[1] + y_diff]
      end
      g = [b[0], b[1]]
      while g[0] >= 0 && g[0] < grid.length && g[1] >= 0 && g[1] < grid[0].length
        # p "loop g #{g}"
        res << g
        g = [res.last[0] - x_diff, res.last[1] - y_diff]
      end
      # p "res"
      # p res
      res.each do |c|
        an << c
      end
    end
  end
  # p an
  # p "an"
  an = an.select { |a| a[0] >= 0 && a[1] >= 0 && a[0] < grid.length && a[1] < grid[0].length }.uniq.sort
  p an
  p an.count
end

def input(example)
  example == 'example' ? @input_example : @input
end

