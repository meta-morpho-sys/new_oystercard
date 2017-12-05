require 'oystercard'

describe 'Travelling with Oystercard' do
  let(:card) { Oystercard.new }
  let(:entry_station) { Station.new :'Piccadilly Circus' }
  let(:exit_station) { Station.new :Clapton }

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
end
