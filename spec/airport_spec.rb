
require "airport"

describe Airport do

	let(:airport) {Airport.new}

	let(:flying_plane) {Plane.new}

	let(:landed_plane) {Plane.new(:landed)}

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


	context "capacity management:" do

		it "knows if it\'s not full" do

			expect(airport.full?).to eq false
		end


		it "knows if it\'s full" do

			fill_airport
			expect(airport.full?).to eq true
		end


		it "can be initialized with a given capacity" do

			airport = Airport.new(capacity: 200)
			expect(airport.capacity).to eq 200
		end


		it "can have it\'s defualt capacity changed" do

			expect(airport.set_capacity_to(40)).to eq airport.capacity
		end


		it "doesn\'t throw an error if the \'set_capacity_to\' method is used without an argument" do

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


		it "returns appropriate message if airport is empty" do

			message = "No planes are currently landed at the airport"
			expect(airport.landed_planes_log).to eq message
		end


		it "initializes with default capacity unless an integer is given" do

			airport = Airport.new(capacity: "a")
 			expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
 		end


		it "initializes with default capacity unless a positive integer is given" do

			airport = Airport.new(capacity: -40)
 			expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
 		end
	end


	context "landing & sending off planes management:" do

		it "can land a plane (if the weather is sunny)" do

			sunny_conditions
			airport.land(flying_plane)
			expect(airport.landed_planes_count).to eq 1
			expect(airport.landed_planes).to eq [flying_plane]
		end


		it "can land more than one plane (if the weather is sunny)" do

			sunny_conditions
			2.times{airport.land(Plane.new(:flying))}
			expect(airport.landed_planes_count).to eq 2
		end


 		it "cannot land planes if the weather is stormy" do

			stormy_conditions
			airport.land(flying_plane)
			expect(airport.landed_planes).to eq []
 		end


		it "can land the same plane only once between take-offs" do

			sunny_conditions
			2.times {airport.land(flying_plane)}
			expect(airport.landed_planes).to eq [flying_plane]
		end


		it "cannot land more planes if it\'s full" do

			fill_airport
			airport.land(flying_plane)
			expect(airport.landed_planes_count).to eq airport.capacity
		end


		it "can only land planes that are currently flying" do

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


		it "returns a message if cannot land a plane" do

			stormy_conditions
			message = "plane could not be landed"
			expect(airport.land(flying_plane)).to eq message
		end


		it "doesn\'t throw an error if the \'land\' method is used without an argument" do

			expect(airport.land).not_to raise_error
		end


		it "returns message if the \'land\' method is used without an argument" do

			message = "method requires an argument (plane)"
			expect(airport.land).to eq message
		end


		it "can send off a plane (if the weather is sunny)" do

			sunny_conditions
			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq []
		end


		it "cannot send off a plane if the weather is stormy" do

			sunny_conditions
			airport.land(flying_plane)
			stormy_conditions
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]
 		end


		it "cannot send off a plane that\'s not currently landed in it" do

			sunny_conditions
			message = "plane could not take off"
			expect(airport.send_off(flying_plane)).to eq message
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


		it "updates a plane's flying status to \'flying\' after sending it off" do

			sunny_conditions
			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(flying_plane.flying?).to be_true
		end


		it "doesn\'t throw an error if \'send_off\' method is used with no argument" do

			sunny_conditions
			expect(airport.send_off).not_to raise_error
		end
	

		it "returns a message if the \'send off\' method is used with no argument" do

			message = "method requires an argument (plane)"
			expect(airport.send_off).to eq message
		end
	end	

 	context "status & weather conditions menagement:" do

 		it "knows if the airport is open" do

			sunny_conditions
 			expect(airport.open?).to eq true
 		end


		it "knows if airport is closed" do

			stormy_conditions
 			expect(airport.status).to eq :closed
 		end


		it "changes airport status from \'open\' to \'closed\' according to weather conditions" do

			sunny_conditions
			stormy_conditions
 			expect(airport.status).to eq :closed
 		end


 		it "can change airport status from \'open\' to \'closed\' independently of weather conditions" do

			sunny_conditions
			airport.close
 			expect(airport.status).to eq :closed
 		end


 		it "changes airport status from \'closed\' to \'open\' according to weather conditions" do

 			stormy_conditions
 			expect(airport.status).to eq :closed	
 			sunny_conditions	
 			expect(airport.status).to eq :open
 		end


 		it "can change it's status from \'closed\' to \'open\' independently of weather conditions" do

 			stormy_conditions
 			expect(airport.status).to eq :closed	
			airport.open
 			expect(airport.status).to eq :open
 		end


 		it "airport cannot be openned if it\'s already open" do

 			sunny_conditions
 			expect(airport.status).to eq :open
 			message = "airport is already open"
 			expect(airport.open).to eq message
 		end


 		it "airport cannot be closed if it\'s already closed" do

 			stormy_conditions
 			expect(airport.status).to eq :closed
 			message = "airport is already closed"	
 			expect(airport.close).to eq message
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


 	context "logging and history management:" do

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
 end
 



