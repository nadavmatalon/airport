#AIRPORT

##1. General Overview
The "Airport" project simulates a basic, yet fully functional, system for managing the landing and taking off of planes in and from airports under changing weather conditions.

There system includes two main objects: airports & planes. 

The system also incorporates an independent module for generating random weather conditions. These condition, in turn, affect the operation of airports in terms of their ability to land/send off planes.

The code was written in Ruby using the TDD method.

##2. General Description of Classes & Module

###2.1 Plane Class

Plane can have either 'flying' or 'landed' status (the defualt is 'flying' when first created).

Hence, a plane that is 'landed' cannot be landed again unless it fitst takes off.

Similarly, a plane that is 'flying' cannot take off again unless it first lands.

This status can be determined on initialization (defualt is 'flying'), as well as changed later by using the '.land' or '.take_off' methods.

Note that, as in real life, a plane can land or take off outside of an airport under any weather conditions (sunny or stormy). 

However, a plane cannot land by itself in an airport. Rather, the airport is the one responsible for landing planes inside it (and this operation is weather and airport status depended). 

Again as in real life, the airport is usually the one which manages the taking off of planes that are currently landed inside it (sending off planes is weather dependent). 

Nevertheless, note that a plane can take off indepedently from the airport but this operation is construed as an "unauthorized departure" and therefore is not logged in the airport records (which may lead into problems). Therefore, it is not recomded to land or take off planes directly, but rather have the airporta to manage these operations.


###2.2 Airport Class

Airports have a number of essential properties, specifically: 
- status (open/closed)  [depends on weather conditions]

- capacity (defualt: 100 planes) [can be changed on initialization or afterwards]

- landed planes logging (knows which planes are currently landed inside it).

 An airport's status (open/closed) is dependent on the weather conditions (sunny/stormy): they are automatically opened on good (sunny) weather and closed off on bad (stormy) weather.

An Airport can only land a plane that is currently flying, while the airport itself must be open, not full, not holding that particular plane inside it, and has good (sunny) local weather.

Similarly, an airport can onlt send off a plane if that plane is currently landed inside it, the airport itself is open, and the local weather is not stormy.

As in real life, the airport can be opened or closed independently of the weather, but if it's closed it cannot land or send off planes.

The airport checks all the relevant conditions (including the current weather) automatically on every landing/sending off attempt, as well as on every local weather inquiry.


###2.3 Weather Module

The Weather module is responsible for generating random weather conditions. 

These conditions may be either 'sunny' or 'stormy', and they are set locally and independently for each airport instance.

The random distribution of possible weather conditions is significantly biased toward good ('sunny') weather. 

More specifically, on average the weather will be 'sunny' 90% of the time, and 'stormy' during the rest.

The Weather module has been included in the Airport class and therefore any given airport instance can inquire into its local weather at any point in time (ie for plane landing or sending off, or just for updated info). 

An airport can also inquire into the weather conditions derectly by using the Weather module methods, but note that every inquiry into the state of the weather may change the current local conditions for the airport which makes the inquiry. 


##3. List of Methods of Classes & Module

###3.1 Plane

####3.1.1 Plane Class Methods

Plane.new()  - creates a new plane instance (defualt 'flying' status).

Plane.new(:landed) - creates a new plane instance with 'landed' status.  

Plane.new(:flying) - creates a new plane instance with 'flying' status.  

####3.1.2 Plane Instance Methods

.status  -  returns the currnet status of the plane (landed/flying)

.flying?  - returns boolean (true if 'flying' / false if 'landed')

.landed?  - returns boolean (true if 'landed' / false if 'flying')

.land  -  changes plane's status to 'landed' if currently 'flying'

.take_off - changes plane's status to 'flying' if currently 'landed'


####3.2.1 Airport Class Methods

Airport.new()  - creates a new airport instance (defualt capacity: 100 planes).

Airport.new(capacity: 200) - creates a new airport instance with capacity of 200 planes.  

Airport.new([landed_plane]) - creates a new airport instance with a landed plane. 

####3.2.2 Airport Instance Methods

.capacity   - returns the capacity of the airport.

.status  - returns the status of the airport (open/closed) [status updates on every call to this method according to weather conditions]

.weather?  - returns the current local weather conditions of the airport (conditions may change on every call to this method)

.update_status - checks the weather (sunny/stormy) and updates the airport's status (open/closed) accrodingly.

.landed_planes  - returns an array conataining details of all the planes which are currently landed in that airport.

.landed_planes_count - returns the overall number of planes which are currently landed in the airport.

.full?  - returns true if airport is filled to capacity and false if not.

.land(plane)  -  lands a given plane if all landing conditions are met.

.send_off(plane) - sends off a plane if all relevant conditions are met.

.landed_planes_log - returns a printable list of alll the planes which are currently landed in the airport.

.landing_history - returns an array with all the planes which have landed in the airport at least once.

.take_off_history  - returns an array with all the planes which have taken off from the airport in the past.

.(All the Weather Module Instance Methods listed below)


####3.3 Weather Module Instance Methods

.check_weather  -  returns random weather conditions (90% 'sunny' / 10% 'stormy') [conditions may change with every call to this method]

.weather_sunny?  -  returns boolean: true if 'sunny'/false if 'stormy'.

.weather_stormy?  -  returns boolean: true if 'stormy' / false if 'sunny'. 

 