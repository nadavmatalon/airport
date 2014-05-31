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

		@flying = true if !@flying 
		
	end


	def land

		@flying = false if @flying

	end

end