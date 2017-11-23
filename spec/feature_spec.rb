require 'oystercard'

card = Oystercard.new
card.top_up(40)
card.top_up(20)
card.deduct 7
