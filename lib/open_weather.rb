require 'net/http'
require 'json'

# class OpenWeather
  # class << self
    API_KEY = '2ca3dec6beffde6c7259a033eefa8f17'

    def city_weather
      url = URI.parse("http://api.openweathermap.org/data/2.5/weather?id=2172797&appid=#{API_KEY}&lang=pt&units=metric")
      res = Net::HTTP.get(url)
      data = JSON.parse(res)
      conditions = data['weather'].map { |w| w['description'] }

      {
        temp: data['main']['temp'].round,
        weather_conditions: conditions,
        city: data['name']
      }
    end
  # end
# end

city_weather