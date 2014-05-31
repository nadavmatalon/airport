require "./lib/weather_conditions.rb"

class Weather; include WeatherConditions; end

describe Weather do

	let(:weather_con) {Weather.new}

	def sunny_conditions

			allow(weather_con).to receive(:get_random_weather) {:sunny}
	end


	def stormy_conditions

			allow(weather_con).to receive(:get_random_weather) {:stormy}
	end


	it "can display the weather if weather is sunny" do

		sunny_conditions
		expect(weather_con.weather).to eq :sunny
	end


	it "can display the weather if weather is stormy" do

		stormy_conditions
		expect(weather_con.weather).to eq :stormy
	end


	it "knows if it\'s sunny" do

		sunny_conditions
		expect(weather_con.weather_sunny?).to be_true

	end


	it "knows if it\'s stormy" do

		stormy_conditions
		expect(weather_con.weather_stormy?).to be_true

	end


	it "can change from \'sunny\' to \'stormy\'" do

		sunny_conditions
		expect(weather_con.check_weather).to eq :sunny
		stormy_conditions
		expect(weather_con.check_weather).to eq :stormy
	end

	
	it "can change from \'stormy\' to \'sunny\'" do

		stormy_conditions
		expect(weather_con.check_weather).to eq :stormy
		sunny_conditions
		expect(weather_con.check_weather).to eq :sunny
	end


	it "doesn\'t throw an error if \'check weather\' method is used with an argument" do

		expect(weather_con.check_weather(1)).not_to raise_error
	end


	it "gives relevant message if \'check-weather\' method is used with an argument" do

		message = "method cannot be used with an argument"
		expect(weather_con.check_weather(1)).to eq message
	end

end


