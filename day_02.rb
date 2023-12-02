def step1(example = false)
  sum = 0
  possible  = {
    red: 12,
    green: 13,
    blue: 14
  }
  input(example).each do |line|
    splitted = line.strip.split(':')
    draws = splitted[1].split(";")
    id = splitted[0].split(' ')[1]
    sum += id.to_i
    puts "ID: #{id}, sum: #{sum}"
    # counter = {
    #   red: 0,
    #   green: 0,
    #   blue: 0
    # }
    draws.each do |draw|
      begin
        draw.strip.split(',').each do |colour|
          p colour
          x = colour.strip.split(' ')
          if x[0].to_i > possible[x[1].to_sym]
            sum -= id.to_i
            raise "Breaking out of inner cycle."
          end
        end
      rescue
        break
      end
    end
  end
  p sum
end

def step2(example = false)
  sum = 0
  input(example).each do |line|
    splitted = line.strip.split(':')
    draws = splitted[1].split(";")
    id = splitted[0].split(' ')[1]
    puts "ID: #{id}, sum: #{sum}"
    counter = {
      red: 0,
      green: 0,
      blue: 0
    }
    draws.each do |draw|
      draw.strip.split(',').each do |colour|
        x = colour.strip.split(' ')
        if x[0].to_i > counter[x[1].to_sym]
          counter[x[1].to_sym] = x[0].to_i
        end
      end
    end
    p counter
    sum += (counter[:red] * counter[:green] * counter[:blue])
  end
  p sum
end


def input(example)
  example == 'example' ? @input_example : @input
end
