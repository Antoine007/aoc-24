def step1(example = false)
  data_list = [
    :seed_to_soil,
    :soil_to_fertilizer,
    :fertilizer_to_water,
    :water_to_light,
    :light_to_temperature,
    :temperature_to_humidity,
    :humidity_to_location
  ]
  dict = {}
  seeds = input(example)[0].split(" ").map(&:to_i).select{|x| x > 0}
  p seeds

  category = data_list[0]
  input(example).each_with_index do |line, index|
    next if index == 0 || index == 1
    if line[0].match?(/\d/)
      split_line = line.strip.split(" ").map(&:to_i)
      dest_start = split_line[0]
      source_start = split_line[1]
      range = split_line[2]
      new_value = {dest_start: dest_start, source_start: source_start, range: range}
      new_dict = dict[category] ? [dict[category], new_value].flatten : [new_value]

      dict[category] = new_dict
    elsif line[0].match?(/\w/)
      category = line.split(" ")[0].gsub("-", "_").to_sym
    else
      next
    end
  end
  p dict

  dict.each do |cat, value|
    seeds.map!.with_index do |number, index|
      value.each do |v|
        if number >= v[:source_start] && number < (v[:source_start] + v[:range])
          if index == 1 && number == 49
            p number
            p cat
            p v
            p (number - v[:source_start])
            p v[:dest_start] + (number - v[:source_start])
          end
          if index == 1 && number == 53
            p number
            p cat
            p v
            p (number - v[:source_start])
            p v[:dest_start] + (number - v[:source_start])
          end
          number = v[:dest_start] + (number - v[:source_start])
        end
      end
      number
    end
    p seeds
  end
  p seeds.min
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
