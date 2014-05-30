require "plane"


# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do
 
	let(:plane) {Plane.new}
  
  		it "has a 'landed' (=not-flying) status when created" do

			expect(plane.flying?).to be_false

  		end
  
  
		it "can take-off only if it currently has a 'landed' status" do

			
			expect(plane.take_off).to be_true

		end	


		it "that's already flying can\'t take-off again" do

			plane.take_off
			expect(plane.take_off).to eq nil

		end


  		it "has a 'flying' status when in the air" do

  			plane.take_off
  			expect(plane.flying?).to be_true
  		end
  

  		it "has a 'landed' (=not-flying) status after landing" do

  			plane.take_off
  			plane.land
  			expect(plane.flying?).to be_false

  		end
  

  		it "can only be landed once between take-offs" do

  			plane.take_off
  			plane.land
  			expect(plane.land).to eq nil

  		end

		it "changes its status to 'flying' after taking off" do
  
			expect(plane.flying?).to be_false
			plane.take_off
			expect(plane.flying?).to be_true	

  		end

end


