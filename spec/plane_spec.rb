require "plane"


# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do
 
	let(:plane) {Plane.new}
  
	let(:landed_plane) {Plane.new(:landed)}

	let(:flying_plane) {Plane.new(:flying)}


  		it "has a 'landed' status when created" do

			expect(plane.flying?).to be_false

  		end
  
  
		it "can take-off" do

			expect(plane.take_off).to be_true

		end	

		it "can take-off only if it currently has a 'landed' status" do

			expect(flying_plane.take_off).to be_false

		end	

		it "that's already flying can\'t take-off again" do

			plane.take_off
			expect(plane.take_off).to be_false

		end


  		it "has a 'flying' status when in the air" do

  			plane.take_off
  			expect(plane.flying?).to be_true
  		end
  

  		it "changes it\'s status to 'landed' after landing" do

  			plane.take_off
  			plane.land
  			expect(plane.flying?).to be_false

  		end
  

  		it "can only be landed once between take-offs" do

  			flying_plane.land
  			expect(flying_plane.land).to be_false

  		end

		it "changes its status to 'flying' after taking off" do
  
			expect(plane.flying?).to be_false
			plane.take_off
			expect(plane.flying?).to be_true	

  		end

  		it "can be initialized with 'flying' status" do

  			test_plane = Plane.new(:flying)
  			expect(test_plane.flying?).to be_true

  		end

  		it "can be initialized with 'landed' status" do

  			test_plane = Plane.new(:landed)
  			expect(test_plane.flying?).to be_false

  		end

  		it "knows if it\'s landed" do

  			expect(landed_plane.landed?).to be_true
  			expect(flying_plane.landed?).to be_false

  		end


		it "can only be initialized as either 'landed' or 'flying'" do
  			test_plane = Plane.new("a")
  			expect(test_plane.status).to eq :landed
  		end

end


