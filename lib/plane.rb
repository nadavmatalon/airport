require_relative "airport.rb"

# check possibility of "land_in(airport)"
# change flying status to symbols
# add status method (and tests when no argument provided)
# update return values of land and take_off methods to symbols

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