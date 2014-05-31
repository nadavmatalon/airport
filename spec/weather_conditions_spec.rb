require "./lib/weather_conditions.rb"

class Weather; 

	include WeatherConditions; 

end


describe Weather do

	let(:weather_con) {Weather.new}


	it "initially has 'sunny' weather" do

		expect(weather_con.weather_status).to eq :sunny

	end

	it "can be changed to 'stormy' weather" do

		weather_con.set_weather_to(:stormy)
		expect(weather_con.weather_status).to eq :stormy

	end
	

	it "knows if it\'s sunny" do

		weather_con.set_weather_to(:sunny)
		expect(weather_con.weather_sunny?).to be_true
		expect(weather_con.weather_stormy?).to be_false

	end


	it "knows if it\'s stormy" do

		weather_con.set_weather_to(:stormy)
		expect(weather_con.weather_stormy?).to be_true
		expect(weather_con.weather_sunny?).to be_false

	end

	it "cannot be change to 'sunny' if already 'sunny'" do

		message = "weather is already sunny"
		weather_con.set_weather_to(:sunny)
		expect(weather_con.set_weather_to(:sunny)).to eq message

	end


	it "cannot be change to 'stormy' if already 'stormy'" do

		message = "weather is already stormy"
		weather_con.set_weather_to(:stormy)
		expect(weather_con.set_weather_to(:stormy)).to eq message

	end


	it "doesn\'t throw an error if 'weather_set_to' is used without an argument" do

		message = "incorrect/missing argument (:sunny/:stormy)"
		expect(weather_con.set_weather_to).to eq message
		expect(weather_con.set_weather_to).not_to raise_error

	end	


	it "doesn\'t throw an error if 'weather_status' is used with an argument" do

		message = "method cannot be used with an argument"
		expect(weather_con.weather_status(1)).to eq message
		expect(weather_con.weather_status(1)).not_to raise_error

	end

end


