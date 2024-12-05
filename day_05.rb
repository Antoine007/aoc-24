def step1(example = false)
  rule_mode = true
  rules = []
  all_pages = []
  valid_pages = []
  count = 0
  
  input(example).each do |line|
    if line.strip == ""
      rule_mode = false 
      next
    end
    if rule_mode
      rules << line.strip.split("|").map(&:to_i)
    else
      all_pages << line.strip.split(",").map(&:to_i)
    end
  end

  all_pages.each do |pages|
    valid = true
    applied_rules = rules.select { |rule| pages.include?(rule[0]) && pages.include?(rule[1]) }
    
    valid = false if invalid_pages?(pages, applied_rules)
    valid_pages << pages if valid
  end

  # p valid_pages
  valid_pages.each do |p|
    count += p[(p.length - 1) / 2]
  end
  p count
end

def invalid_pages?(pages, applied_rules)
  # p applied_rules
  applied_rules.each do |rule|
    return true if pages.index(rule[0]) && pages.index(rule[1]) && pages.index(rule[0]) > pages.index(rule[1])
  end
  false
end

def step2(example = false)
  rule_mode = true
  rules = []
  all_pages = []
  valid_pages = []
  invalid_pages = []
  count = 0
  
  input(example).each do |line|
    if line.strip == ""
      rule_mode = false 
      next
    end
    if rule_mode
      rules << line.strip.split("|").map(&:to_i)
    else
      all_pages << line.strip.split(",").map(&:to_i)
    end
  end

  all_pages.each do |pages|
    valid = true
    applied_rules = rules.select { |rule| pages.include?(rule[0]) && pages.include?(rule[1]) }
    
    valid = false if invalid_pages?(pages, applied_rules)
    if valid
      valid_pages << pages 
    else
      invalid_pages << pages
    end
  end

  # p valid_pages
  # [
  sorted_invalid_pages = []
  invalid_pages.each do |pages|
    # Create a directed graph from the rules
    dependencies = Hash.new { |h, k| h[k] = [] }
    applied_rules = rules.select { |rule| pages.include?(rule[0]) && pages.include?(rule[1]) }
    
    applied_rules.each do |rule|
      dependencies[rule[0]] << rule[1]  # rule[0] must come after rule[1]
    end

    # Topological sort
    sorted = []
    remaining = pages.dup
    
    while remaining.any?
      # Find a number that has no dependencies on remaining numbers
      node = remaining.find { |n| 
        dependencies[n].none? { |dep| remaining.include?(dep) }
      }
      
      break unless node  # Break if circular dependency
      sorted.unshift(node)
      remaining.delete(node)
    end

    sorted_invalid_pages << (remaining.any? ? pages : sorted)  # Fall back to original if circular
  end

  # p sorted_invalid_pages
  sorted_invalid_pages.each do |p|
    count += p[(p.length - 1) / 2]
  end
  p count
end


def input(example)
  example == 'example' ? @input_example : @input
end
