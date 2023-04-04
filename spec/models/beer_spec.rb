require 'rails_helper'

RSpec.describe Beer, type: :model do
  it 'entry is not valid without a name' do
    beer = Beer.create brewery:"South Coast Brewing"
    expect(beer.errors[:name]).to_not be_empty
  end

  it 'entry is not valid without a brewery' do
    beer = Beer.create name: "Budweiser"
    expect(beer.errors[:brewery]).to_not be_empty
  end

  it 'name must be unique to the brewery' do
    beer1 = Beer.create name: 'Ale', brewery: 'South Coast Brewing'
    beer2 = Beer.create name: 'Ale', brewery: 'South Coast Brewing'
    beer3 = Beer.create name: 'Ale', brewery: 'North Coast Brewing'
    expect(beer2.errors[:name]).to_not be_empty
    expect(beer3.errors[:name]).to be_empty
  end
  it 'name and brewery must be at least 2 characters' do
    beer1 = Beer.create name: 'a', brewery:'a long enough name'
    beer2 = Beer.create name: 'long enough name', brewery: 'b'
    expect(beer1.errors[:name]).to_not be_empty
    expect(beer2.errors[:brewery]).to_not be_empty
  end
end
