module WeatherConditions

	DEFAULT_WEATHER = :sunny

	def weather

		@weather ||= DEFAULT_WEATHER

	end


	def set_weather_to(status = nil)

		if (status == :sunny)

			weather_sunny? ? "weather is already sunny" : @weather = status

		elsif (status == :stormy)

			weather_stormy? ? "weather is already stormy" : @weather = status

		else (status = nil)

			"incorrect/missing argument (:sunny/:stormy)"
		end

	end


	def check_weather(param = nil)

		if (param == nil)
			@weather = get_random_weather
		else 
			"method cannot be used with an argument"
		end

	end


	def weather_sunny?

		weather == :sunny

	end


	def weather_stormy?

		weather == :stormy

	end

	def get_random_weather

		possible_weather = [:sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :sunny, :stormy]
		current_weather = possible_weather[Random.new.rand(0..9)]

	end

end


