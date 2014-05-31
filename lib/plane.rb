require_relative "airport.rb"

# check possibility of "land_in(airport)"
# change flying status to symbols
# add status method (and tests when no argument provided)
# update return values of land and take_off methods to symbols
# add brand, model, etc.
# planes can currently take off when landed in airport


class Plane

	DEFAULT_STATUS = :landed

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


	def take_off
		if @status == :landed 
			@status = :flying 
			true 
		else
			false
		end
	end


	def land
		if @status == :flying
			@status = :landed
			true
		else
			false
		end
	end

end