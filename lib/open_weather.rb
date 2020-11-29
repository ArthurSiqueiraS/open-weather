require 'net/http'
require 'json'

class OpenWeather
  API_URL = 'http://api.openweathermap.org/data/2.5'
  API_KEY = '2ca3dec6beffde6c7259a033eefa8f17'

  attr_accessor :lang, :units

  def initialize(lang: 'pt', units: 'metric')
    @lang = lang
    @units = units
  end

  def city_weather(id)
    data = request('/weather', { id: id })

    return unless data['main']

    conditions = data['weather'].map { |w| w['description'] }

    {
      temp: data['main']['temp'].round,
      weather_conditions: conditions,
      city: city(data),
      date: today,
    }
  end

  def city_forecast(id)
    data = request('/forecast', { id: id })

    return unless data['list']

    # Group forecast list by date
    days = data['list'].group_by { |f| f['dt_txt'][0..9] }

    forecast = {}

    # Get temp average of the next 5 days
    days.each do |day, list|
      break if forecast.keys.count == 5

      if day != today
        temp_average = list.sum { |d| d['main']['temp'] } / list.count.to_f
        forecast[day] = temp_average.round(2)
      end
    end

    { forecast: forecast, city: city(data['city']) }
  end

  private

  def request(route, params)
    query = URI.encode_www_form(params.merge({
      appid: API_KEY,
      lang: @lang,
      units: @units
    }))
    url = URI.parse("#{API_URL}#{route}?#{query}")
    res = Net::HTTP.get(url)
    JSON.parse(res)
  end

  def today
    Time.now.strftime('%F')
  end

  def city(data)
    {
      name: data['name'],
      lat: data['coord']['lat'],
      lon: data['coord']['lon']
    }
  end
end