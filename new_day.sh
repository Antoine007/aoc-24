#!/bin/bash

current_day=$(date +%d)

new_example="data/day_${current_day}_example.txt"
new_data="data/day_${current_day}.txt"
new_day="day_${current_day}.rb"

touch "$new_example"
touch "$new_data"
touch "$new_day"

cp "data/day_0_example.txt" "$new_example"
cp "data/day_0.txt" "$new_data"
cp "day_0.rb" "$new_day"

echo "Copied and renamed: /day_0.rb to $new_day"
