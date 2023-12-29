def step1(example = false)
  Day24.new.solve(part: 1)
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end


require 'scanf'
require 'z3'

class Day24 < AOC
  def solve(part:)
    data = input(false)
    if part == 1
      solve_part_one(data)
    else
      solve_part_two(data)
    end
  end

  def solve_part_one(data)
    points = read_points_from_input
    count_collisions(points)
  end

  def solve_part_two(data)
    points = read_points_from_input
    calculate_position(points)
  end

  private

  def read_points_from_input
    File.readlines(@input_file).map { |line| line.scan(/-?\d+/).map(&:to_i) }
  end

  def count_collisions(points)
    count = 0

    points.combination(2) do |a, b|
      count += 1 if collision_occurs?(a, b)
    end

    puts count
    count
  end

  def collision_occurs?(a, b)
    apx, apy, _, avx, avy, _ = a
    bpx, bpy, _, bvx, bvy, _ = b

    d = avx * bvy - avy * bvx
    return false if d.zero?

    t = Rational((bpx - apx) * bvy - (bpy - apy) * bvx, d)
    u = Rational((bpx - apx) * avy - (bpy - apy) * avx, d)

    t >= 0 && u >= 0 &&
      (200_000_000_000_000..400_000_000_000_000).cover?(apx + t * avx) &&
      (200_000_000_000_000..400_000_000_000_000).cover?(apy + t * avy)
  end

  def calculate_position(points)
    solver = setup_solver
    solve_constraints(solver, points)
  end

  def setup_solver
    solver = Z3::Solver.new
  end

  def solve_constraints(solver, points)
    x = Z3.Int("x")
    y = Z3.Int("y")
    z = Z3.Int("z")
    vx = Z3.Int("vx")
    vy = Z3.Int("vy")
    vz = Z3.Int("vz")
    points.each_with_index do |coords, index|
      cpx, cpy, cpz, cvx, cvy, cvz = coords
      t = Z3.Int("t#{index}")

      solver.assert(x + vx * t == cpx + cvx * t)
      solver.assert(y + vy * t == cpy + cvy * t)
      solver.assert(z + vz * t == cpz + cvz * t)
    end

    answer = find_answer(solver, x, y , z)
    answer.nil? ? 0 : answer
  end

  def find_answer(solver, x, y , z)
    if solver.check == :sat
      model = solver.model
      x_val = model.model_eval(x).to_i
      y_val = model.model_eval(y).to_i
      z_val = model.model_eval(z).to_i
      x_val + y_val + z_val
    else
      0
    end
  end
end
