#Airport

##Makers Academy | Week 4 | Challenge


##Table of Contents

* [General Description](#general-description)
* [Guidelines](#guidelines)
* [How to Run](#how-to-run)
* [Functional Description](#functional-description)
* [Testing](#testing)


##General Description

This repo contians the answer to __Week 4 Friday Challange__ as part 
of the course at [Makers Academy](http://www.makersacademy.com/).

The __Airport__ project simulates a system for managing the landing and taking off of planes 
in and from airports under changing weather conditions.

There system includes two main classes: __Airport__ &amp; __Plane__. 

The system also incorporates an independent module called: __WeatherConditions__ 
for generating random weather. These condition, in turn, affect the operation of 
airports in terms of their ability to land/send off planes.

The code was written in [Ruby](https://www.ruby-lang.org/en/) using 
[TDD](http://en.wikipedia.org/wiki/Test-driven_development) methodology 
(tests written with [Rspec](http://rspec.info/)).


##Guidelines

* Imagine you're writing software to control the flow of planes at an airport. 
  The planes can land and take off provided that the weather is sunny. 
  Occasionally it may be stormy, in which case no planes can land or take off.

* Your task is to create a set of classes/modules to makes the given test suite pass. 
  You will need to use random number generator to set the weather (it is normally sunny 
  but on rare occasions it may be stormy). In your tests, you'll need to use a double to 
  override random weather. Finally, every plane must have a status indicating whether it's 
  flying or landed. You may expand on the original tests.

* Read the documentation to learn how to use 
  [test doubles](https://www.relishapp.com/rspec/rspec-mocks/docs). 
  There’s an example of using a test double to test a die that’s relevant 
  to testing random weather in the test.

* Create separate files for every class, module and test suite. 

* The submission will be judged on the following criteria:
    * Tests pass
    * Tests coverage is good
    * The code is elegant: every class has a clear responsibility, methods are short etc.


##How to Run

Clone the repo to a local folder and in terminal run:

```bash
$> ch airport
$> irb
>> require './lib/airport_setup.rb'
```

And then you can use the methods described in the functional description (next section).


## Functional Description

The system contains two classes, __Plane__ and __Airport__, as well as 
a module __WeatherConditions__.


###Plane Class

Planes can have either `flying` or `landed` status (the defualt is 
`flying` when first created).

Hence, a plane that is `landed` cannot be landed again unless it fitst takes off.

Similarly, a plane that is `flying` cannot take off again unless it first lands.

This status can be determined on initialization (defualt is `flying`), as well as changed 
later by using the `.land()' or `.take_off()` methods.

Note that, as in real life, a plane can land or take off outside of an airport under any 
weather conditions (sunny or stormy). 

However, a plane cannot land by itself in an airport. Rather, the airport is the one 
responsible for landing planes inside it (and this operation is weather and airport 
status depended). 

Again as in real life, the airport is usually the one which manages the taking off of 
planes that are currently landed inside it (sending off planes is weather dependent). 

Nevertheless, note that a plane can take off indepedently from the airport but this 
operation is construed as an "unauthorized departure" and therefore is not logged in 
the airport records (which may lead into problems). Therefore, it is not recomded to 
land or take off planes directly, but rather have the airporta to manage these operations.

#### Plane Class Methods

Plane.new()  - creates a new plane instance (defualt 'flying' status).

Plane.new(:landed) - creates a new plane instance with 'landed' status.  

Plane.new(:flying) - creates a new plane instance with 'flying' status.  

####Plane Instance Methods

.status  -  returns the currnet status of the plane (landed/flying)

.flying?  - returns boolean (true if 'flying' / false if 'landed')

.landed?  - returns boolean (true if 'landed' / false if 'flying')

.land  -  changes plane's status to 'landed' if currently 'flying'

.take_off - changes plane's status to 'flying' if currently 'landed'


###Airport Class

* Airports have a number of essential properties, specifically: 
  - status (open/closed)  [depends on weather conditions]
  - capacity (defualt: 100 planes) [can be changed on initialization or afterwards]
  - landed planes logging (knows which planes are currently landed inside it).

* An airport's status (`open`/`closed`) is dependent on the weather conditions (`sunny`/`stormy`): 
  they are automatically opened on good (`sunny`) weather and closed off on bad (`stormy`) weather.

* An Airport can only land a plane that is currently flying, while the airport itself must 
  be open, not full, not holding that particular plane inside it, and has good (`sunny`) 
  local weather.

* Similarly, an airport can onlt send off a plane if that plane is currently landed 
  inside it, the airport itself is open, and the local weather is not `stormy`.

* As in real life, the airport can be opened or closed independently of the weather, 
  but if it's closed it cannot land or send off planes.

* The airport checks all the relevant conditions (including the current weather) 
  automatically on every landing/sending off attempt, as well as on every 
  local weather inquiry.


####3.2.1 Airport Class Methods

Airport.new()  - creates a new airport instance (defualt capacity: 100 planes).

Airport.new(capacity: 200) - creates a new airport instance with capacity of 200 planes.  

Airport.new([landed_plane]) - creates a new airport instance with a landed plane. 


####Airport Instance Methods

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

.(the WeatherConditions Module Instance Methods listed below)


### Weather Conditions Module

* The __WeatherConditions__ module is responsible for generating random weather conditions. 

* These conditions may be either `sunny` or `stormy`, and they are set locally and 
  independently for each airport instance.

* The random distribution of possible weather conditions is significantly biased 
  toward good (`sunny`) weather. 

  More specifically, on average the weather will be `sunny` 90% of the time, and 
  `stormy` during the rest.

* The Weather module has been included in the Airport class and therefore any given 
  airport instance can inquire into its local weather at any point in time (ie for plane 
  landing or sending off, or just for updated info). 

* An airport can also inquire into the weather conditions derectly by using the Weather 
  module methods, but note that every inquiry into the state of the weather may change 
  the current local conditions for the airport which makes the inquiry. 


####WeatherConditions Module Instance Methods

.check_weather  -  returns random weather conditions (90% 'sunny' / 10% 'stormy') [conditions may change with every call to this method]

.weather_sunny?  -  returns boolean: true if 'sunny'/false if 'stormy'.

.weather_stormy?  -  returns boolean: true if 'stormy' / false if 'sunny'. 


##Testing

Tests were written with [Rspec](http://rspec.info/) (3.0.4).

To run the tests, clone the repo to a local folder and in terminal run: 

```bash
$> cd airport
$> rspec
```
