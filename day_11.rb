def step1(example = false)
  rocks = []
  input(example).each do |line|
    rocks = line.strip.split(' ').map(&:to_i)
  end
  # p rocks
  25.times do |i|
    p i
    rocks = turn(rocks)
  end
  p rocks.count
end 

def step2(example = false)
  rocks = []
  input(example).each do |line|
    rocks = line.strip.split(' ').map(&:to_i)
  end
  tally = rocks.tally
  p tally
  75.times do
    next_tally = Hash.new { 0 }
  
    input = tally.each do |i,n|
      if i == 0 
        next_tally[1] += n
        next
      end
  
      d = i.to_s
      if d.size.even?
        next_tally[d[0,d.size/2].to_i] += n
        next_tally[d[d.size/2..].to_i] += n
        next
      end
  
      next_tally[i*2024] += n
    end
    # p tally
    tally = next_tally
  end
  p tally.values.sum
end

def input(example)
  example == 'example' ? @input_example : @input
end

def turn(rocks)
  new_rocks = []
  rocks.map do |rock|
    if rock == 0
      rock = 1
      new_rocks << rock
    elsif rock.to_s.length.even?
      rock_length = rock.to_s.length
      first_half = rock.to_s[0,rock_length / 2].to_i
      second_half = rock.to_s[rock_length / 2, rock_length].to_i
      new_rocks << first_half
      new_rocks << second_half
    else
      rock *= 2024
      new_rocks << rock
    end
  end

  

  # p new_rocks
  new_rocks
end
