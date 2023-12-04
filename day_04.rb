def step1(example = false)
  cards = []
  input(example).each do |line|
    card = 0
    x = line.split(' | ')
    my_numbers = x[0].split(':')[1].split(' ').map(&:to_i)
    draw = x[1].split(' ').map(&:to_i)
    # p my_numbers
    # p draw
    my_numbers.each do |number|
      if draw.include?(number)
        card == 0 ? card += 1 : card *= 2
      end
    end
    cards << card
  end
  p cards
  p cards.sum
end

def step2(example = false)
  rough_data = input(example).map do |card|
    card.split(/[:|]/)
  end

  # p rough_data
  data = rough_data.map.with_index do |card, index|
    {id: index+1, winning_numbers: card[1].split(" ").map(&:to_i), my_numbers: card[2].split(" ").map(&:to_i), w_count: 0}
  end

  # find number of winning numbers
  data.each do |card|
    card[:my_numbers].each do |my_number|
      card[:w_count] += 1 if card[:winning_numbers].include?(my_number)
    end
  end

  # p data
  data.each do |card|
    if card[:w_count] > 0
      # index of copies are
      copies_index = (card[:id]+1)..(card[:id]+card[:w_count])
      # add the copies
      copies_index.each do |index|
        data << data[index-1]
      end
    end
  end
  p data.count
end


def input(example)
  example == 'example' ? @input_example : @input
end
