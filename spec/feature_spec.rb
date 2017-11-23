require 'oystercard'

card = Oystercard.new
card.top_up 89
card.deduct 86
# card.deduct 1.5
card.touch_in
card.touch_out
p card.in_journey?
