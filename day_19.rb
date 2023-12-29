def step1(example = false)
  initial = true
  @rules = {}
  @parts = []
  input(example).each do |line|
    initial = false if line == "\n"
    if initial
      name, rs = line.gsub("}","").strip.split("{")
      rs = rs.split(",")
      @rules[name] = rs
      # p [name, rules, accepted]
    else
      next if line == "\n"
      split = line.gsub("{","").gsub("}","").strip.split(",")
      o = {}
      split.each do |l|
        k,v = l.split("=")
        o[k] = v.to_i
      end
      @parts << o
    end
  end
  # p @rules
  # p @parts
  @valid_parts = []

  find_valid_parts
  p @valid_parts
  sum = 0
  @valid_parts.each do |part|
    sum += part.values.sum
  end
  p sum
end

def find_valid_parts
  @parts.each do |part|
    current_rule = "in"
    go = true
    i = 0
    until go == false
      rule = @rules[current_rule][i]
      if rule[0] == "A"
        @valid_parts << part
        go = false
      elsif rule[0] == "R"
        go = false
      elsif rule[1] == "<" || rule[1] == ">"
        test, right = rule.split(/[>,<]/)
        amount, new_instruction = right.split(":")
        sign = rule.include?('<') ? "<" : ">"
        # p [test, sign, amount, new_instruction]
        # p part[test].send(sign, amount.to_i)
        if part[test].send(sign, amount.to_i)
          if new_instruction == "A"
            @valid_parts << part
            go = false
          elsif new_instruction == "R"
            go = false
          else
            # p new_instruction
            current_rule = new_instruction
            i = 0
          end
          i += 1
        else
          i += 1
        end
      else
        current_rule = rule
        i = 0
      end
    end
  end
end

def step2(example = false)

end


def input(example)
  example == 'example' ? @input_example : @input
end
