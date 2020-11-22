require 'open_weather'
require 'active_support/core_ext' # Date operations support

RSpec.describe OpenWeather do
  city_id = '2172797'
  client = described_class.new

  context 'get weather from valid city id' do
    before do
      @res = client.city_weather(city_id)
    end

    it 'returns hash object' do
      expect(@res).to_not be_nil
      expect(@res).to be_instance_of(Hash)
    end

    it 'response contains temperature, weather conditions and city name' do
      [:temp, :weather_conditions, :city].each do |key|
        expect(@res).to have_key(key)
      end
    end
  end

  context 'get weather from invalid city id' do
    before do
      @res = client.city_weather('A')
    end

    it 'returns nil' do
      expect(@res).to be_nil
    end
  end


  context 'get forecast from valid city id' do
    before do
      @res = client.city_forecast(city_id)
    end

    it 'returns hash object' do
      expect(@res).to_not be_nil
      expect(@res).to be_instance_of(Hash)
    end

    it 'hash contains 5 keys' do
      expect(@res.keys.length).to eq(5)
    end

    it "hash contains forecast temperatures for the next 5 days" do
      today = Time.now
      days = 1
      @res.each do |date_key, _|
        expected_date = (today + days.days)
        expect(date_key.to_date).to eq(expected_date.to_date)
        days += 1
      end
    end
  end

  context 'get forecast from invalid city id' do
    before do
      @res = client.city_forecast('A')
    end

    it 'returns nil' do
      expect(@rest).to be_nil
    end
  end
end