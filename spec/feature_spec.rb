require 'oystercard'

card = Oystercard.new
card.top_up 89
card.deduct 45
card.touch_in
card.touch_out
card.in_journey?
