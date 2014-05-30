require_relative "plane.rb"
require_relative "weather_conditions.rb"

class Airport

	DEFAULT_CAPACITY = 100

	include WeatherConditions

	def initialize (options = {}, sunny = true, landed_planes = [])

		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)

		@sunny = sunny

		@landed_planes = landed_planes
	end


	def capacity    

		@capacity ||= DEFAULT_CAPACITY
	
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