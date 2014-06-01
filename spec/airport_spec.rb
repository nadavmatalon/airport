
require "airport"

describe Airport do

	let(:airport) {Airport.new}

	let(:landed_plane) {Plane.new}

	let(:flying_plane) {Plane.new(:flying)}

	def sunny_conditions

			allow(airport).to receive(:check_weather) {:sunny}
			airport.update_status
	end


	def stormy_conditions

			allow(airport).to receive(:check_weather) {:stormy}
			airport.update_status
	end


	def fill_airport

		sunny_conditions
		airport.capacity.times{airport.land(Plane.new(:flying))}	
	end


	context "capacity" do

		it "knows if it\'s not full" do

			expect(airport.full?).to eq false
		end


		it "knows if it\'s full" do

			fill_airport
			expect(airport.full?).to eq true
		end


		it "does not land more planes if it is full" do

			fill_airport
			airport.land(flying_plane)
			expect(airport.landed_planes_count).to eq airport.capacity
		end


		it "can be initialized with a given capacity" do

			airport = Airport.new(capacity: 200)
			expect(airport.capacity).to eq 200
		end


		it "can have it's defualt capacity changed" do

			expect(airport.set_capacity_to(40)).to eq airport.capacity
		end


		it "doesn\'t throw an error if the 'set_capacity_to' method is used without an argument" do

			expect(airport.set_capacity_to).not_to raise_error
		end


		it "can display a printable log of the planes that are currently landed in it" do

			sunny_conditions
			plane_a = (Plane.new(:flying))
			plane_b = (Plane.new(:flying))
			airport.land(plane_a)
			airport.land(plane_b)
			expect(airport.landed_planes_log).to eq "#{plane_a}, #{plane_b}"
		end


		it "landed planes log returns appropriate message if airport is empty" do

			message = "No planes are currently landed at the airport"
			expect(airport.landed_planes_log).to eq message
		end


		it "knows how many planes are currently landed in it" do

			sunny_conditions
			20.times{airport.land(Plane.new(:flying))}
			expect(airport.landed_planes_count).to eq 20
		end


		it "can display a log of all the planes which landed in it at least once" do

			sunny_conditions
			plane_a = (Plane.new(:flying))
			plane_b = (Plane.new(:flying))
			airport.land(plane_a)
			airport.land(plane_b)
			airport.send_off(plane_a)
			expect(airport.landing_history).to eq [plane_a, plane_b]
		end


		it "can display a log of all the planes which took off from it at least once" do

			sunny_conditions
			plane_a = (Plane.new(:flying))
			plane_b = (Plane.new(:flying))
			airport.land(plane_a)
			airport.land(plane_b)
			airport.send_off(plane_a)
			airport.send_off(plane_b)
			expect(airport.takeoff_history).to eq [plane_a, plane_b]
		end
	end


	context "landing & sending off planes" do

		it "can land a plane" do

			sunny_conditions
			airport.land(flying_plane)
			expect(airport.landed_planes_count).to eq 1
		end


		it "can land more than one plane" do

			sunny_conditions
			2.times{airport.land(Plane.new(:flying))}
			expect(airport.landed_planes_count).to eq 2
		end


		it "can land the same plane only once between take-offs" do

			sunny_conditions
			2.times {airport.land(flying_plane)}
			expect(airport.landed_planes).to eq [flying_plane]
		end


 		it "cannot land a plane if the weather is stormy" do

			stormy_conditions
			airport.land(flying_plane)
			expect(airport.landed_planes).to eq []
 		end


		it "can only land flying planes" do

			sunny_conditions
			airport.land(landed_plane)
			airport.land(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]
		end


		it "updates a plane's flying status to \'landed\' after landing it" do

			sunny_conditions
			airport.land(flying_plane)
			expect(flying_plane.flying?).to be_false
		end

		it "returns the plane's status after succesfully landing it" do

			sunny_conditions
			expect(airport.land(flying_plane)).to eq :landed
		end


		it "returns a message if cannot perform plane landing" do

			stormy_conditions
			message = "plane could not be landed"
			expect(airport.land(flying_plane)).to eq message
		end


		it "doesn\'t throw an error if the \'land\' method is used without an argument" do

			expect(airport.land).not_to raise_error
		end


		it "can send off a plane" do

			sunny_conditions
			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq []
		end


		it "cannot send off a plane if it\'s not currently landed in it" do

			sunny_conditions
			message = "plane could not take off"
			expect(airport.send_off(flying_plane)).to eq message
		end


 		it "cannot send off a plane if the weather is stormy" do

			sunny_conditions
			airport.land(flying_plane)
			stormy_conditions
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]
 		end


		it "cannot send off the same plane more than once between landings" do

			sunny_conditions
			message = "plane could not take off"
			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(airport.send_off(flying_plane)).to eq message
		end


		it "returns the plane's status after succesful take off" do

			sunny_conditions
			airport.land(flying_plane)
			expect(airport.send_off(flying_plane)).to eq :flying
		end


		it "returns a message if cannot send off a plane" do

			stormy_conditions
			message = "plane could not take off"
			expect(airport.send_off(flying_plane)).to eq message
		end


		it "updates a plane's flying status to 'flying' after sending it off" do

			sunny_conditions
			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(flying_plane.flying?).to be_true
		end


		it "doesn\'t throw an error if 'send_off' method is used with no argument" do

			sunny_conditions
			expect(airport.send_off).not_to raise_error
		end
	end


	context 'traffic control' do

 	end


 	context "status & weather conditions" do

 		it "knows if it\'s open" do

			sunny_conditions
 			expect(airport.open?).to eq true
 		end

		it "can change it's status from \'open\' to \'closed\' due to weather conditions" do

			sunny_conditions
			stormy_conditions
 			expect(airport.status).to eq :closed
 		end


 		it "can change it's status from \'open\' to \'closed\' independently of weather" do

			sunny_conditions
			airport.close
 			expect(airport.status).to eq :closed
 		end


 		it "knows if it\'s closed" do

			stormy_conditions
 			expect(airport.status).to eq :closed
 		end


 		it "can change it's status from \'closed\' to \'open\' due to weather conditions" do

 			stormy_conditions	
 			sunny_conditions	
 			expect(airport.status).to eq :open
 		end


 		it "can change it's status from \'closed\' to \'open\' independently of weather" do

 			stormy_conditions	
			airport.open
 			expect(airport.status).to eq :open
 		end


 		it "cannot be openned if already open" do

 			sunny_conditions	
 			expect(airport.open).to eq nil
 		end


 		it "cannot be closed if already closed" do

 			stormy_conditions	
 			expect(airport.close).to eq nil
 		end


 
 		it "initializes with default capacity unless an integer is given" do

			airport = Airport.new(capacity: "a")
 			expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
 		end


		it "initializes with default capacity unless a positive integer is given" do

			airport = Airport.new(capacity: -40)
 			expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
 		end


 		it "can check if the weather is sunny" do

 			sunny_conditions	
 			expect(airport.check_weather).to eq :sunny
 		end


		it "can check if the weather is stormy" do

 			stormy_conditions	
 			expect(airport.check_weather).to eq :stormy
 		end
 	end
 end
 



