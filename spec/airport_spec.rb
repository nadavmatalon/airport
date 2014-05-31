
require "airport"
 
# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do

	let(:airport) {Airport.new}

	let(:open_airport) {Airport.new(status: :open)}

	let(:closed_airport) {Airport.new(status: :closed)}

	let(:landed_plane) {Plane.new}

	let(:flying_plane) {Plane.new(:flying)}

	def fill_airport

		airport.capacity.times {airport.land(Plane.new(:flying))}

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

		it "can be initialized with ':open' status" do

			test_airport = Airport.new(status: :open)
			expect(test_airport.status).to eq :open

		end


		it "can be initialized with ':closed' status" do

			test_airport = Airport.new(status: :closed)
			expect(test_airport.status).to eq :closed

		end

		it "can be initialized with a given capacity" do

			test_airport = Airport.new(capacity: 200)
			expect(test_airport.capacity).to eq 200

		end


		it "can have it's defualt capacity changed" do

			expect(airport.set_capacity_to(40)).to eq airport.capacity

		end


		it "doesn\'t throw an error if the 'set_capacity_to' method is used without an argument" do
			expect(airport.set_capacity_to).not_to raise_error

		end

		it "can display a printable log of the planes that are currently landed in it" do
			
			plane_a = (Plane.new(:flying))
			plane_b = (Plane.new(:flying))
			airport.land(plane_a)
			airport.land(plane_b)
			expect(airport.landed_planes_log).to eq "#{plane_a}, #{plane_b}"
		end

		it "displays an appropriate message instead of currently landed planes log if airport is empty" do

			expect(airport.landed_planes_log).to eq "No planes are currently landed at the airport"

		end

		xit "can display a log of all the planes which landed in it at least once" do

		end


		xit "can display a log of all the planes which were sent off from it at least once" do

		end

	end


	context "landing & sending off planes" do

		it "can land a plane" do

			airport.land(flying_plane)
			expect(airport.landed_planes_count).to eq 1
		end


		it "can land more than one plane" do

			airport.land(Plane.new(:flying))
			airport.land(Plane.new(:flying))
			expect(airport.landed_planes_count).to eq 2

		end


		it "can land the same plane only once between take-offs" do

			airport.land(flying_plane)
			airport.land(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]

		end

		it "cannot land a plane if the airport is closed" do

			closed_airport.land(flying_plane)
			expect(closed_airport.landed_planes).to eq []

		end


		it "can only land a flying plane" do

			airport.land(landed_plane)
			airport.land(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]

		end

		it "updates a plane's flying status to 'landed' after landing it" do

			airport.land(flying_plane)
			expect(flying_plane.flying?).to be_false

		end


		it "doesn\'t throw an error if the 'land' method is used without an argument" do

			expect(airport.land).not_to raise_error

		end


		it "can send off a plane" do

			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq []

		end

		it "cannot send off a plane if not currently landed in it" do

			expect(airport.send_off(flying_plane)).to eq false

		end


		it "cannot send off a plane if the airport is closed" do

			airport.land(flying_plane)
			airport.close
			airport.send_off(flying_plane)
			expect(airport.landed_planes).to eq [flying_plane]

		end


		it "cannot send off the same plane more than once between landings" do

			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(airport.send_off(flying_plane)).to eq false

		end


		it "updates a plane's flying status to 'flying' after sending it off" do

			airport.land(flying_plane)
			airport.send_off(flying_plane)
			expect(flying_plane.flying?).to be_true

		end


		it "doesn\'t throw an error if 'send_off' method is used with no argument" do

			expect(airport.send_off).not_to raise_error

		end

	end


	context 'traffic control' do

    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
 

 	end


 	context "status & weather conditions" do

 		it "knows if it\'s open" do

 			expect(airport.open?).to eq true

 		end


 		it "can change it's status from 'open' to 'closed'" do

 			airport.close
 			expect(airport.status).to eq :closed

 		end


 		it "knows if it\'s closed" do

 			airport.close
 			expect(airport.open?).to eq false

 		end


 		it "can change it's status from 'closed' to 'open'" do

 			airport.open
 			expect(airport.status).to eq :open

 		end


 		it "cannot be openned if already open" do

 			expect(open_airport.open).to eq nil

 		end


 		it "cannot be closed if already closed" do
 			airport.close
 			expect(airport.close).to eq nil


 		end


 		it "can only be initialized as either ':open' or ':closed'" do

 			# expect(Airport.new(status: 40)).to 

 		end


 		it "initializes with default capacity unless an integer is given" do

			airport_test = Airport.new(capacity: "a")

 			expect(airport_test.capacity).to eq Airport::DEFAULT_CAPACITY

 		end


		it "initializes with default capacity unless a positive integer is given" do

			airport_test = Airport.new(capacity: -40)

 			expect(airport_test.capacity).to eq Airport::DEFAULT_CAPACITY

 		end


		it "initializes with default status unless legitimate status is provided" do

			airport_test = Airport.new(status: 40)

 			expect(airport_test.status).to eq Airport::DEFAULT_STATUS

 		end


 		it 'a plane cannot take off when there is a storm brewing' do


 		end


 		it 'a plane cannot land in the middle of a storm' do


 		end

 	end

 end
 

 
