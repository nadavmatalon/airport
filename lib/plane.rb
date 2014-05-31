require_relative "airport.rb"

# check possibility of "land_in(airport)"

class Plane

	def initialize (flying = false)

		@flying = flying

	end


	def flying?

		@flying

	end


	def take_off
		if !@flying 
			@flying = true 
		else 
			false
		end
	end


	def land
		if @flying
			@flying = false
			true
		else
			false
		end
	end

end