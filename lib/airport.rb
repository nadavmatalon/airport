require_relative "plane.rb"
require_relative "weather_conditions.rb"

# overwrite include method
# remove parenthesis

class Airport

	DEFAULT_CAPACITY = 100

	DEFAULT_STATUS = :open


	include WeatherConditions

	def initialize(params={}, landed_planes=[])

		@capacity = set_capacity_to(params.fetch(:capacity, DEFAULT_CAPACITY))

		@weather = self.check_weather

		@status = update_status(weather)

		@landed_planes = landed_planes
	end


	def capacity

		@capacity ||= DEFAULT_CAPACITY 

	end


	def status

		@status ||= DEFAULT_STATUS

	end


	def close

		@status = :closed unless status == :closed

	end


	def open

		@status = :open unless status == :open

	end


	def open?

		status == :open

	end

	def closed?

		status == :closed

	end

	
	def set_capacity_to(value = DEFAULT_CAPACITY)    

		if (value >= 0 && value.integer?rescue false)

			@capacity = value 

		else

			@capacity = DEFAULT_CAPACITY

		end

	end


	# def set_status_to(value = DEFAULT_STATUS)



	# 	if (value == :open || value == :closed)


	# 		@status = value

	# 	else

	# 		@status = DEFAULT_STATUS

	# 	end

	# end


	def update_status (value = check_weather)

		(value == :sunny) ? @status = :open : @status = :closed

		@status

	end


	def landed_planes

		@landed_planes ||= []

	end


	def landed_planes_count

		@landed_planes.count
		
	end


	def full?

    	landed_planes.count == capacity

	end

	def land (plane = nil)

		update_status unless closed?

		if 	((open?) && (!full?) && 
			(plane.is_a?Plane) && 
			(plane.flying?) &&
			(!landed_planes.include?plane))

			landed_planes << plane
			plane.land
			true

		else

			false

		end

	end


	def send_off (plane = nil)

		update_status unless closed?

		if (open? && landed_planes.include?(plane))

			landed_planes.delete(plane)
			plane.take_off
			return true
		else
			return false
		end
	end


	def landed_planes_log

		if landed_planes.empty?

			"No planes are currently landed at the airport"

		else

			"#{landed_planes.join(", ")}"		

		end
	end






end