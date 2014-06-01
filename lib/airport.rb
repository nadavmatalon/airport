require_relative "plane.rb"
require_relative "weather_conditions.rb"

# overwrite include method
# remove parenthesis

class Airport

	DEFAULT_CAPACITY = 100

	include WeatherConditions

	def initialize(params={}, landed_planes=[])

		@capacity = set_capacity_to(params.fetch(:capacity, DEFAULT_CAPACITY))
		@weather = check_weather
		@status = update_status(weather?)
		@landed_planes = landed_planes
	end


	def capacity

		@capacity ||= DEFAULT_CAPACITY 
	end


	def status

		@status ||= update_status
	end


	def weather?

		@weather = check_weather
	end


	def open

		status == :closed ? @status = :open : "airport is already open"
	end


	def close

		status == :open ? @status = :closed : "airport is already closed"
	end


	def open?

		status == :open
	end


	def closed?

		status == :closed
	end

	
	def set_capacity_to(value = DEFAULT_CAPACITY)    

		positive_integer?(value) ? @capacity = value : @capacity = DEFAULT_CAPACITY
	end


	def positive_integer?(value)

		value >= 0 && value.integer?rescue false
	end


	def update_status (value = check_weather)

		value == :sunny ? @status = :open : @status = :closed
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

		if (landing_conditions_met?(plane))
			landed_planes << plane
			update_landing_history(plane)
			plane.land
			plane.status
		elsif (plane.nil?)
			"method requires an argument (plane)"
		else
			"plane could not be landed"
		end
	end


	def landing_conditions_met?(plane)

		update_status
		((open?) && (!full?) && (plane.is_a?Plane) && 
		(plane.flying?) && (!landed_planes.include?plane))
	end


	def send_off (plane = nil)

		update_status
		if (open? && landed_planes.include?(plane))
			landed_planes.delete(plane)
			update_takeoff_history(plane)
			plane.take_off
			plane.status
		elsif (plane.nil?)
			"method requires an argument (plane)"
		else
			"plane could not take off"
		end
	end


	def landed_planes_log

		!landed_planes.empty? ? "#{landed_planes.join(", ")}" : \
		"No planes are currently landed at the airport"
	end


	def landing_history

		@landing_history ||= []
	end


	def update_landing_history(plane)

		landing_history << plane unless (landing_history.include?plane)
	end


	def takeoff_history

		@takeoff_history ||= []
	end


	def update_takeoff_history(plane)

		takeoff_history << plane unless (takeoff_history.include?plane)
	end
end


