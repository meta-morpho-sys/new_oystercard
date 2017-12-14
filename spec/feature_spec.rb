require 'oystercard'
require 'journey'
require 'station'

describe 'Travelling with Oystercard' do
  let(:card) { Oystercard.new }
  let(:entry_station) { Station.new :'Piccadilly Circus' }
  let(:exit_station) { Station.new :Clapton }
  let(:journey) { Journey.new(entry_station, exit_station) }

  context 'when managing credit' do
    it 'it has £0 credit but can be topped up' do
      expect(card.balance).to eq 0
      card.top_up 10
      expect { card.top_up 100 }
        .to raise_exception Oystercard::BALANCE_OVERFLOW_MSG
      expect(card.balance).to eq 10
    end
  end

  context 'when starting the journey' do
    it 'checks for sufficient credit and records the entry station' do
      card.top_up 10
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
      expect(entry_station.name).to eq :'Piccadilly Circus'
      expect(entry_station.zone).to eq '1'
    end
  end

  context 'when the journey ends' do
    it 'deducts the fare and stores a list of journeys' do
      card.top_up 10
      card.touch_in(entry_station)
      fare = card.journey.calculate_fare
      expect do
        card.touch_out(Station.new(:Clapton))
      end.to change(card, :balance).by(-fare)
    end
  end

  context 'querying the card' do
    it 'prints a list of journeys' do
      card.top_up 40
      entry1 = Station.new(:Clapton)
      entry3 = Station.new(:Clapton)
      entry2 = Station.new(:'Euston Square')
      exit1 = Station.new(:'Piccadilly Circus')
      # rubocop:disable Style/Semicolon
      card.touch_in(entry1); card.touch_out(exit1)
      card.touch_in(entry2); card.touch_out(exit1)
      expect(card.journeys)
        .to eq [
          Journey.new(entry3, exit1),
          Journey.new(entry2, exit1)
        ]
    end
  end
end
