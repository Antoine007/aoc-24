def step1(example = false)
  # input(example).each do |line|
  #   puts line
  # end
  p Day22.new.solve_part_one(input(example))
end

def step2(example = false)
  p Day22.new.solve_part_two(input(example))
end


def input(example)
  example == 'example' ? @input_example : @input
end


class Day22


  def solve_part_one(bricks_collection)
    bricks, grid, bricks_above, bricks_below = prepare_bricks_data(bricks_collection)

    bricks_that_remain_stable = bricks.find_all do |brick|
      bricks_above[brick].all? { |adjacent_brick| bricks_below[adjacent_brick].size > 1 }
    end.size

    bricks_that_remain_stable
  end

  def solve_part_two(bricks_collection)
    bricks, grid, bricks_above, bricks_below = prepare_bricks_data(bricks_collection)

    bricks_fallen_count = bricks.sum do |brick|
      felled_bricks = [brick].to_set
      queue = bricks_above[brick].to_a

      while (current_brick = queue.shift)
        next if felled_bricks.include?(current_brick)
        next unless (bricks_below[current_brick].all? { |adj_brick| felled_bricks.include?(adj_brick) })

        felled_bricks << current_brick
        queue += bricks_above[current_brick].to_a
      end

      felled_bricks.size - 1
    end

    bricks_fallen_count
  end

  Brick = Struct.new(:x1, :y1, :z1, :x2, :y2, :z2)

  def get_all_points(x1, y1, z1, x2, y2, z2)
    (x1..x2).to_a.product((y1..y2).to_a).product((z1..z2).to_a).map { |point| [point[0][0], point[0][1], point[1]] }
  end

  def prepare_bricks_data(brick_input)
    bricks = brick_input.map { |brick| Brick.new(*brick.scan(/\d+/).map(&:to_i)) }.sort_by(&:z1)

    grid = {}
    bricks.each do |brick|
      get_all_points(*brick).each { |x, y, z| grid[[x, y, z]] = brick }
    end

    bricks.each do |brick|
      until brick.z1 == 1
        points = get_all_points(*brick.to_a)
        break if points.any? { |x, y, z| grid[[x, y, z - 1]] &&  grid[[x, y, z - 1]] != brick }

        points.each { |x, y, z| grid.delete([x, y, z]); grid[[x, y, z - 1]] = brick }
        brick.z2 -= 1
        brick.z1 -= 1
      end
    end

    bricks_above = bricks.map do |brick|
      [brick, get_all_points(*brick.to_a).map { |x, y, z| grid[[x, y, z + 1]] if (grid[[x, y, z + 1]] && grid[[x, y, z + 1]] != brick) }.compact.to_set]
    end.to_h

    bricks_below = bricks.map do |brick|
      [brick, get_all_points(*brick.to_a).map { |x, y, z| grid[[x, y, z - 1]] if (grid[[x, y, z - 1]] && grid[[x, y, z - 1]] != brick) }.compact.to_set]
    end.to_h

    return bricks, grid, bricks_above, bricks_below
  end
end
