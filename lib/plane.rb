require_relative "airport.rb"

# check possibility of "land_in(airport)"
# known issue: planes can currently take off independently while landed in airport
# refactor weather generator to work with default

class Plane

	DEFAULT_STATUS = :flying

	def initialize (status_init = DEFAULT_STATUS)

		if (status_init == :landed || status_init == :flying) 
			@status = status_init
		else
			@status = DEFAULT_STATUS
		end
	end


	def status

		@status
	end


	def flying?

		@status == :flying
	end


	def landed?

		@status == :landed
	end


	def take_off
		
		@status == :landed ? @status = :flying : "plane is already flying"

	end


	def land

		@status == :flying ? @status = :landed : "plane is already landed"
	end
end



