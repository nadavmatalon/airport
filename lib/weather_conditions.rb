module WeatherConditions

	DEFAULT_SUNNY_PROBABILITY = 0.90

	def check_weather
		@weather = get_random_weather
	end

	def set_weather_to weather_type
		@weather = weather_type
	end

	def weather_sunny?
		check_weather == :sunny
	end

	def weather_stormy?
		check_weather == :stormy
	end

	def get_random_weather
		rand(100)/100.0 < DEFAULT_SUNNY_PROBABILITY ? :sunny : :stormy
	end
end

