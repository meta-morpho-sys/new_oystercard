require 'oystercard'
require 'journey'
require 'station'

describe 'Travelling with Oystercard' do
  let(:card) { Oystercard.new }
  let(:entry_station) { Station.new :'Piccadilly Circus' }
  let(:exit_station) { Station.new :Clapton }
  let(:journey) { Journey.new(entry_station, exit_station) }
  let(:billing) { Billing.new }

  before(:each) do
    card.top_up 10
    card.touch_in entry_station
  end

  context 'when managing credit' do
    it 'it has initial credit of £0 and can be topped up' do
      card = Oystercard.new
      expect(card.balance).to eq 0
      card.top_up 10
      expect { card.top_up 100 }
        .to raise_exception Oystercard::BALANCE_OVERFLOW_MSG
      expect(card.balance).to eq 10
    end
  end

  describe 'when the journey ends' do
    it 'deducts the fare' do
      fare = 4.1
      expect do
        card.touch_out(Station.new(:Clapton))
      end.to change(card, :balance).by(-fare)
    end
    context 'penalty' do
      it 'deducts penalty fare when a touch-in is missing' do
        card = Oystercard.new
        card.top_up 10
        card.touch_in nil
        fare = Billing::PENALTY_FARE
        expect do
          card.touch_out(Station.new(:Clapton))
        end.to change(card, :balance).by(-fare)
      end

      it 'deducts penalty and no other fare' do
        card = Oystercard.new
        card.top_up 10
        card.touch_in nil
        penalty = Billing::PENALTY_FARE
        expect do
          card.touch_out(Station.new(:Clapton))
        end.to change(card, :balance).by(-penalty)
      end

      it 'deducts penalty fare when a touch-out is missing' do
        fare = Billing::PENALTY_FARE
        expect do
          card.touch_out nil
        end.to change(card, :balance).by(-fare)
      end
    end
  end

  context 'querying the card' do
    it 'prints a list of journeys' do
      card = Oystercard.new
      card.top_up 40
      entry1 = Station.new(:Clapton)
      entry3 = Station.new(:Clapton)
      entry2 = Station.new(:'Euston Square')
      exit1 = Station.new(:'Piccadilly Circus')
      # rubocop:disable Style/Semicolon
      card.touch_in(entry1); card.touch_out(exit1)
      card.touch_in(entry2); card.touch_out(exit1)
      # rubocop:enable Style/Semicolon
      expect(card.journeys)
        .to eq [
          Journey.new(entry3, exit1),
          Journey.new(entry2, exit1)
        ]
    end
  end
end
