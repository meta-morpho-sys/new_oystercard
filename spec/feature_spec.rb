require 'oystercard'

describe 'Travelling with Oystercard' do
  let(:card) { Oystercard.new }
  let(:entry_station) { Station.new :'Piccadilly Circus' }
  let(:exit_station) { Station.new :Clapton }
  let(:journey) { Journey.new :Clapton }

  context 'when managing credit' do
    it 'is has £0 credit but can be topped up' do
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
      expect do
        card.touch_out(Station.new(:Clapton))
      end.to change(card, :balance).by(-Oystercard::MIN_REQUIRED_AMOUNT)
    end
  end

  context 'querying the card' do
    it 'prints a list of journeys' do
      card.top_up 40
      entry1 = Station.new(:Clapton)
      entry2 = Station.new(:'Euston Square')
      exit1 = Station.new(:'Piccadilly Circus')
      # rubocop:disable Style/Semicolon
      card.touch_in(entry1); card.touch_out(exit1)
      card.touch_in(entry2); card.touch_out(exit1)
      expect(card.journeys)
        .to eq [
          { entry_station: entry1, exit_station: exit1 },
          { entry_station: entry2, exit_station: exit1 }
        ]
    end
  end
end
