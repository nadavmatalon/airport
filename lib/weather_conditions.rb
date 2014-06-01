module WeatherConditions

	DEFAULT_SUNNY_PROBABILITY = 0.90

	def check_weather(param = nil)

		param.nil? ? @weather = get_random_weather : \
		"method cannot be used with an argument"
	end


	def weather_sunny?

		check_weather == :sunny
	end


	def weather_stormy?

		check_weather == :stormy
	end


	def get_random_weather

		possible_weather = []
		(DEFAULT_SUNNY_PROBABILITY*100).to_i.times{possible_weather << :sunny}
		((1.0-DEFAULT_SUNNY_PROBABILITY)*100).to_i.times{possible_weather << :stormy}
		current_weather = possible_weather[Random.new.rand(0..99)]
	end
end


