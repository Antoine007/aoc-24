def step1(example = false)
  rows = []
  input(example).each do |line|
    row = line.split(' ')
    row[1] = row[1].to_i
    row << hand(row[0])
    rows << row
  end
  sorted_by_hand_rows = rows.sort{ |a,b| a[2] <=> b[2] }
  result = []
  (1..7).each do |i|
    same_hand = sorted_by_hand_rows.select{ |value| value[2] == i}

    to_add = same_hand.length >= 2 ? sort_games_by_alpha(same_hand) : same_hand
    to_add.each{|t| result << t  unless t.empty?}
  end
  # p result
  sum = 0
  result.each_with_index do |v, index|
    sum +=  v[1] * (index + 1)
  end
  p sum
end

def hand(val)
  cards = val.split('')
  c = {}
  cards.each do |card|
    c[card] = c[card] ?  c[card] + 1 : 1
  end
  c = c.values.sort.reverse

  return 7 if c.first == 5 # five of a kind
  return 6 if c.first == 4 # four of a kind
  return 5 if c.first == 3 && c[1] == 2 # full house
  return 4 if c.first == 3 # three of a kind
  return 3 if c.first == 2 && c[1] == 2 # two pair
  return 2 if c.first == 2 # pair
  return 1 # card
end

def sort_games_by_alpha(games)
  cards = %w(2 3 4 5 6 7 8 9 T J Q K A)
  p games
  games.sort do |a, b|
    letter_a = nil
    letter_b = nil
    a[0].split('').each_with_index do |letter, index|
      letter_a = cards.index(letter)
      letter_b = cards.index(b[0][index])
      p "#{a[0]}, letter_a: #{letter_a}, #{b[0]} letter_b: #{letter_b}"
      if letter_a == letter_b
        next
      else
        break
      end
    end
    letter_a <=> letter_b
  end
end

def step2(example = false)
    rows = []
    input(example).each do |line|
      row = line.split(' ')
      row[1] = row[1].to_i
      row << hand_j(row[0])
      rows << row
    end
    sorted_by_hand_rows = rows.sort{ |a,b| a[2] <=> b[2] }
    result = []
    (1..7).each do |i|
      same_hand = sorted_by_hand_rows.select{ |value| value[2] == i}

      to_add = same_hand.length >= 2 ? sort_games_by_alpha(same_hand) : same_hand
      to_add.each{|t| result << t  unless t.empty?}
    end
    # p result
    sum = 0
    result.each_with_index do |v, index|
      sum +=  v[1] * (index + 1)
    end
    p sum
end

def hand_j(val)
  cards = val.split('')
  c = {}
  cards.each do |card|
    c[card] = c[card] ?  c[card] + 1 : 1
  end
  c = c.values.select{|v| v != "J"}.sort.reverse
  j_count = c.values.select{|v| v == "J"}.count

  mid =  7 if c.first == 5 # five of a kind

  mid = 6 if c.first == 4 # four of a kind
  mid = 5 if c.first == 3 && c[1] == 2 # full house
  mid = 4 if c.first == 3 # three of a kind
  mid = 3 if c.first == 2 && c[1] == 2 # two pair
  mid = 2 if c.first == 2 # pair
  mid = 1 # card

  return mid if j_count == 0
  if j_count == 1
    return mid + 1 unless mid == 5
    return [5].include?(mid) ? mid : mid + 1
  end
  if j_count == 2
    return [1,3,5].include?(mid) ?  mid + 1 : mid + 2
  end

  if j_count == 3
    return mid == 2 ? 7 : 6
  end

  if j_count == 4
    return 7
  end
end


def input(example)
  example == 'example' ? @input_example : @input
end
