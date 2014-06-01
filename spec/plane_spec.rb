require "plane"

describe Plane do
 
	let(:flying_plane) {Plane.new}
  
	let(:landed_plane) {Plane.new(:landed)}


    it "has a \'flying\' status when created by default" do

		expect(Plane.new.flying?).to be_true
  	end
  
  
    it "can take-off" do

        landed_plane.take_off
		expect(landed_plane.status).to eq :flying
	end	


	it "that's already flying can\'t take-off again" do

        message = "plane is already flying"
		expect(flying_plane.take_off).to eq message
	end


  	it "has a \'flying\' status when in the air" do

        expect(landed_plane.status).to eq :landed
  		landed_plane.take_off
  		expect(landed_plane.status).to eq :flying
  	end
  

  	it "changes it\'s status to \'landed\' after landing" do

        expect(flying_plane.status).to eq :flying
  		flying_plane.land
  		expect(flying_plane.status).to eq :landed
  	end
  

  	it "can only be landed once between take-offs" do

        message = "plane is already landed"
  		flying_plane.land
  		expect(flying_plane.land).to eq message
  	end


	it "changes its status to \'flying\' after taking off" do
  
		expect(landed_plane.flying?).to be_false
		landed_plane.take_off
		expect(landed_plane.flying?).to be_true	
  	end


    it "can be initialized with 'flying' status" do

  		expect(Plane.new(:flying).status).to eq :flying
  	end


    it "can be initialized with 'landed' status" do

        expect(Plane.new(:landed).status).to eq :landed
  	end


  	it "knows if it\'s landed" do

  		expect(landed_plane.landed?).to be_true
  		expect(flying_plane.landed?).to be_false
  	end


    it "knows if it\'s flying" do

        expect(landed_plane.flying?).to be_false
        expect(flying_plane.flying?).to be_true
    end

    it "doesn't throw an error if initialized with wrong argument" do

        expect(Plane.new(1)).not_to raise_error
    end


	it "can only be initialized as either \'landed\' or 'flying'" do
 
  		expect(Plane.new(1).status).to eq Plane::DEFAULT_STATUS
  	end
end


