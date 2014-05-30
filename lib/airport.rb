require_relative "plane.rb"
require_relative "weather_conditions.rb"

class Airport

	DEFAULT_CAPACITY = 100

	DEFAULT_STATUS = :open

	include WeatherConditions

	def initialize(params={}, landed_planes=[])

		@capacity = params.fetch(:capacity, DEFAULT_CAPACITY)

		@status = params.fetch(:status, DEFAULT_STATUS)

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

		@status = :open if status == :closed

	end


	def open?

		status == :open

	end 

	
	def set_capacity_to(value = DEFAULT_CAPACITY)    

		@capacity = value

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

		if 	((plane.is_a?Plane) && 
			(plane.flying?) &&
			(!full?) &&
			(!landed_planes.include?(plane))) 

				landed_planes << plane
				plane.land

			end

	end


	def send_off (plane = nil)

		if landed_planes.include?(plane)

			landed_planes.delete(plane)
			plane.take_off

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