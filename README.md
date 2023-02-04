# First Assignment - Research Track 1
A Python script for controlling a robot in a maze filled with golden and silver boxes. 
The robot moves counter-clockwise, avoids the golden boxes and grabs the silver boxes. 
The goal is to successfully navigate the maze. Check out the project for a demonstration of the robot's abilities.


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#Introduction">Introduction</a></li>
    <li><a href="#Installing and running">Installing and running</a></li>
    <li><a href="#Robot API">Robot API</a></li>
    <li><a href="#Flowchart">Flowchart</a></li>
    <li><a href="#Main Functions">Main Functions</a></li>
    <li><a href="#Robot Movement Improvement Proposal">Robot Movement Improvement Proposal</a></li>
  </ol>
</details>



<!-- Introduction -->
## Introduction

The purpose of this program is to control a robot and gather information about it using the sr library. The robot's primary objective is to follow a specific path while avoiding obstacles represented by golden tokens. Additionally, the robot is designed to grab silver tokens when they are within reach and move them behind itself. The program works by analyzing the robot's position relative to the golden and silver tokens. If the robot is too close to a golden token, it turns away to avoid collision. If the robot is close enough to a silver token, it grabs the token and moves it behind itself.

The project was part of a challenge to make the robot move within a maze made of golden boxes, and the goal was to make the robot grab silver boxes along the way. The behavior of the robot was also specified, and the robot was required to move only counterclockwise, meaning that the robot should always turn to the right when it encounters a wall.

The program was written using a combination of libraries and programming logic. The code was developed step by step, starting with the installation of libraries, the development of functions, and finally, the main code. 



<!-- Installing and running -->
<!-- Installing and running -->
## Installing and running

The simulator requires a Python 2.7 installation, the [pygame](http://pygame.org/) library, [PyPyBox2D](https://pypi.python.org/pypi/pypybox2d/2.1-r331), and [PyYAML](https://pypi.python.org/pypi/PyYAML/).
To install the libraries up here, here's some commands for the linux shell:

```bash
$ sudo apt-get install python-dev python-pip python-pygame python-yaml
```

``` bash
$ sudo pip install pypybox2d
```

Once the dependencies are installed, get inside the directory on the shell. To run the game, run the command:

```bash
$ python2 run.py assignment.py
```



<!-- Robot API -->
## Robot API

The API for controlling a simulated robot is designed to be as similar as possible to the [SR API](https://www.studentrobotics.org/docs/programming/sr/cheat_sheet).

### Motors ###

The simulated robot has two motors configured for skid steering, connected to a two-output [Motor Board](https://studentrobotics.org/docs/kit/motor_board). The left motor is connected to output `0` and the right motor to output `1`.

The Motor Board API is identical to [that of the SR API](https://studentrobotics.org/docs/programming/sr/motors/), except that motor boards cannot be addressed by serial number. So, to turn on the spot at one quarter of full power, one might write the following:

```python
R.motors[0].m0.power = 25
R.motors[0].m1.power = -25
```

### The Grabber ###

The robot is equipped with a grabber, capable of picking up a token which is in front of the robot and within 0.4 metres of the robot's centre. To pick up a token, call the `R.grab` method:

```python
success = R.grab()
```

The `R.grab` function returns `True` if a token was successfully picked up, or `False` otherwise. If the robot is already holding a token, it will throw an `AlreadyHoldingSomethingException`.

To drop the token, call the `R.release` method.

Cable-tie flails are not implemented.

### Vision ###

To help the robot find tokens and navigate, each token has markers stuck to it, as does each wall. The `R.see` method returns a list of all the markers the robot can see, as `Marker` objects. The robot can only see markers which it is facing towards.

Each `Marker` object has the following attributes:

* `info`: a `MarkerInfo` object describing the marker itself. Has the following attributes:
  * `code`: the numeric code of the marker.
  * `marker_type`: the type of object the marker is attached to (either `MARKER_TOKEN_GOLD`, `MARKER_TOKEN_SILVER` or `MARKER_ARENA`).
  * `offset`: offset of the numeric code of the marker from the lowest numbered marker of its type. For example, token number 3 has the code 43, but offset 3.
  * `size`: the size that the marker would be in the real game, for compatibility with the SR API.
* `centre`: the location of the marker in polar coordinates, as a `PolarCoord` object. Has the following attributes:
  * `length`: the distance from the centre of the robot to the object (in metres).
  * `rot_y`: rotation about the Y axis in degrees.
* `dist`: an alias for `centre.length`
* `res`: the value of the `res` parameter of `R.see`, for compatibility with the SR API.
* `rot_y`: an alias for `centre.rot_y`
* `timestamp`: the time at which the marker was seen (when `R.see` was called).


<!-- Flowchart  -->
## Flowchart 

<!-- Main Functions -->
## Main Functions

* <h3>Drive motors :<h3>
```python
def drive(speed , seconds):
	R.motors[0].m0.power = speed
	R.motors[0].m1.power = speed 
	time.sleep(seconds) 
	R.motors[0].m0.power = 0
	R.motors[0].m1.power = 0
```

 
1. With the *speed* setting, the robot's linear velocity can be defined.
2. *Seconds* indicates how long the speed will last.


* <h3>Turn :<h3>
```python
def turn(speed , seconds):
	R.motors[0].m0.power = speed 
	R.motors[0].m1.power = -speed 
	time.sleep(seconds)
	R.motors[0].m0.power =0
	R.motors[0].m1.power =0
```

The "Turn on Axis" Function provides the capability for the robot to rotate around its central point. It takes two arguments, "speed" and "seconds", that control the behavior of the robot during the rotation.

The "speed" argument defines the velocity of the motors, with one motor moving in a positive direction and the other in a negative direction to create the rotation. The "seconds" argument specifies the duration of the rotation, indicating the time interval for which the rotation should take place.

This function does not produce any returns and is used to give the robot the ability to turn on its axis.


* <h3>find golden tokens:<h3>

```python

def find_golden_token(distance=0.9, angle=45):
	dist = distance

	for token in R.see():
		
		if token.dist < dist and token.info.marker_type is MARKER_TOKEN_GOLD and -angle < token.rot_y < angle:
			
			dist = token.dist
		
		rot_y = token.rot_y
		
	if dist == distance:
		
		return False
	
	else:
		
		return True 
```
Function detects closest golden box in a cone-shaped area. The cone has a default angle of 90 degrees (-45 to 45) and a maximum distance of 0.9. 

It stops the robot and helps avoid walls. 

Arguments "distance" and "angle" can be set. Returns True if no golden boxes detected, False if detected.


* <h3>find Silver tokens:<h3>

```python
dist = 1.2
	
	for token in R.see():
	
		if -70 < token.rot_y < 70:
		
			if token.info.marker_type is MARKER_TOKEN_SILVER and token.dist < dist:
			
				if gold_in_between(token.dist, token.rot_y):
				
					print("Looking for a new Silver!!")
					
				else:
					
					dist = token.dist 
					
					rot_y = token.rot_y
	if dist == 1.2:
	
		return -1, -1
		
	else:
		
		return dist, rot_y
```

The function ``` def find_silver_token() ``` has the capability to identify the nearest silver token within a 140-degree cone, with a maximum range of 1.2 meters. 

The function utilizes the ``` def gold_in_between(dist, rot_y) ``` method to overlook any tokens that may be blocked by obstacles such as walls. 

The primary objective of this function is to locate and approach silver tokens. 

The output of this function includes the distance to the closest silver token and the angle in degrees between the robot and the token. If no silver tokens are detected or if they are obstructed by golden boxes, the function returns -1.
											       
The ``` def find_silver_token() ``` function has two sub-functions: ``` def gold_in_between(dist, rot_y) ```, and ``` def Routine()```.								       
  - ``` def gold_in_between(dist, rot_y) ``` checks for the presence of golden boxes between the robot and the silver tokens it is searching for. It takes the distance and angle of the detected silver token as input and returns False if there are no golden boxes in between, or True if there are. 
  
  - ``` def Routine()```is called if ``` def gold_in_between(dist, rot_y) ``` returns False, and it carries out the sequence of actions to approach, grab, turn, release, and turn away from the silver token. This function only activates if the robot is close enough to the silver token, with a distance threshold of 0.4. If the robot is too far from the silver token, it continues to drive.
  

* <h3>Rotation :<h3>

```python
def Rotation():

	dist_right = 7
	dist_left = 7
	
	for token in R.see():
	
		if 75 < token.rot_y < 105:
		
			if token.info.marker_type is MARKER_TOKEN_GOLD and token.dist < dist_right:
				
				dist_right = token.dist
				
		if -105 < token.rot_y < -75:
		
			if token.info.marker_type is MARKER_TOKEN_GOLD and token.dist < dist_left:
			
				dist_left = token.dist 
				
	if dist_right > dist_left:
	
		while find_golden_token(1,45.5):
		
			turn(10,0.1)	
	else:
	
		while find_golden_token(1,45.5):
			
			turn(-10,0.1)
```
The described function serves to calculate the distance between the robot and the nearest golden box to its right and left, each at an angle of 30 degrees. The range for the right golden box falls between 75 and 105 degrees, while for the left it falls between -105 and -75 degrees.

In order to locate the golden box, the robot will rotate towards the furthest golden box until it no longer detects any golden box in a cone with a 91-degree field of view and a distance of 1 unit in front of it. The angle and distance of the cone can be adjusted by passing the arguments to the function ``` find_golden_token(..,..) ```.

Thanks to this feature, the robot will always turn counter-clockwise when searching for the golden box.
	
	

* <h3>main() :<h3>
	
The main goal of this function is to allow the robot to continuously perform its tasks. It follows these steps:

1. Look for golden boxes. The robot's behavior changes based on its proximity to a golden box or a silver token.

2. Check if a silver token is within the robot's field of vision.

3. Take action based on the result of step 2:
	- If the robot detects a silver token, it moves towards it to grab it. This is done through checking "if rot_y != -1", as find_silver_token() returns -1 if no silver tokens are found.
	- If the robot doesn't detect a silver token, it continues driving straight ahead.

		
	
4. If the robot is close to a golden box, it will call the ``` def Rotation(): ``` function to turn counter-clockwise with respect to its path.
	


<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Robot Movement Improvement Proposal -->
## Robot Movement Improvement Proposal

The following report will outline two potential improvements to the current code. These modifications aim to enhance the robot's movement and make it smoother and more efficient.

Online control: The first improvement involves implementing online control to the robot's movement. The goal of this modification is to keep the robot centered and to prevent it from hitting walls while seeking the silver tokens. To achieve this, the robot will be designed to always see where the silver tokens are and maintain the center of the line.

Additional controls: The second improvement involves adding more controls to the code to handle different shapes of mazes. As the current code is straightforward and meets the requirements set by the professor, additional controls may be necessary to address any potential issues with the robot's movement in mazes with different shapes such as zig-zag or wave-shaped walls. These additional controls will help the robot navigate the maze more efficiently and effectively.

In conclusion, these two improvements have the potential to significantly enhance the robot's movement and make it smoother and more efficient. The implementation of online control and additional controls will allow the robot to better navigate the maze and perform its tasks more effectively.
