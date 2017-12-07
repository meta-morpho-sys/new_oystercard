require 'journey'

describe Journey do
  it 'does not start when initialized' do
    expect(subject.started?).to be false
  end
  it 'starts' do
    expect(subject.start).to be true
  end
end
