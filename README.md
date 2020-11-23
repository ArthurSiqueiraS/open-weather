# OpenWeather SDK

## Instalação local da gem

```bash
./install_open_weather_gem.sh
```

## Inicialização

```ruby
require 'open_weather'

client = OpenWeather.new
```

Opções

```ruby
OpenWeather.new(lang: 'en', units: 'imperial')

# lang => idioma de textos
# units => unidade de medida da temperatura
```

## Temperatura atual de cidade por ID

```ruby
client.city_weather('2172797')
#=> {:temp=>31, :weather_conditions=>["nublado"], :city=>"Cairns"}
```

## Previsão de temperatura para próximos 5 dias de cidade por ID

```ruby
client.city_forecast('2172797')
#=> {"2020-11-23"=>25.67, "2020-11-24"=>26.03, "2020-11-25"=>26.75, "2020-11-26"=>26.42, "2020-11-27"=>26.17}
```

[Lista de IDs de cidades](http://bulk.openweathermap.org/sample/)
