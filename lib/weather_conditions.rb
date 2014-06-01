module WeatherConditions


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

		possible_weather = [:sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :stormy]
		current_weather = possible_weather[Random.new.rand(0..9)]
	end
end


