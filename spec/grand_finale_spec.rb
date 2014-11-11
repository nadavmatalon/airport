require "airport"
require "plane"

# Imstructions for the Grand Finale: 
# Given 6 planes, each plane must land at the airport. 
# When the airport is full (capacity: 6 planes), every plane 
# must take off again (this must take into consideration that
# the weather may be stormy).
# After all the planes have landed, check that they have the
# correct status 'landed'.
# Once all the planes are in the air again, check that their 
# status has updated to 'flying'.

describe "The Grand Finale" do

	let(:airport) {Airport.new(capacity: 6)}
	let(:plane_1) {Plane.new}
	let(:plane_2) {Plane.new}
	let(:plane_3) {Plane.new}
	let(:plane_4) {Plane.new}
	let(:plane_5) {Plane.new}
	let(:plane_6) {Plane.new}

	def sunny_conditions
		allow(airport).to receive(:check_weather) { :sunny }
		airport.set_weather_to :sunny and airport.update_status
	end

	it "successfully lands all planes" do
		sunny_conditions
		expect(airport.weather?).to eq :sunny
		expect(airport.open?).to be true
		airport.land(plane_1)
		airport.land(plane_2)
		airport.land(plane_3)
		airport.land(plane_4)
		airport.land(plane_5)
		airport.land(plane_6)
		planes = [plane_1, plane_2, plane_3, plane_4, plane_5, plane_6]
		expect(airport.landed_planes.count).to eq 6
		expect(airport.full?).to be true
		expect(airport.landed_planes).to eq planes
		expect(plane_1.status).to eq :landed
		expect(plane_2.status).to eq :landed
		expect(plane_3.status).to eq :landed
		expect(plane_4.status).to eq :landed
		expect(plane_5.status).to eq :landed
		expect(plane_6.status).to eq :landed
	end

	it "successfully sends off all planes" do
		sunny_conditions
		expect(airport.weather?).to eq :sunny
		expect(airport.open?).to be true
		airport.send_off(plane_1)
		airport.send_off(plane_2)
		airport.send_off(plane_3)
		airport.send_off(plane_4)
		airport.send_off(plane_5)
		airport.send_off(plane_6)
		expect(airport.landed_planes_count).to eq 0
		expect(airport.full?).to be false
		expect(airport.landed_planes).to eq []
		expect(plane_1.status).to eq :flying
		expect(plane_2.status).to eq :flying
		expect(plane_3.status).to eq :flying
		expect(plane_4.status).to eq :flying
		expect(plane_5.status).to eq :flying
		expect(plane_6.status).to eq :flying
	end
end

