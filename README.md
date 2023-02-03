# First Assignment Research Track 1
A Python script for controlling a robot in a maze filled with golden and silver boxes. 
The robot moves counter-clockwise, avoids the golden boxes and grabs the silver boxes. 
The goal is to successfully navigate the maze. Check out the project for a demonstration of the robot's abilities.


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    </li>
    <li><a href="#Introduction">Introduction</a></li>
    <li><a href="#Installing and running">Installing and running</a></li>
    <li><a href="#Robot API">Robot API</a></li>
    <li><a href="#Main Functions">Main Functions</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#Robot Movement Improvement Proposal">Robot Movement Improvement Proposal</a></li>
  </ol>
</details>



<!-- Introduction -->
## Introduction

The purpose of this program is to control a robot and gather information about it using the sr library. The robot's primary objective is to follow a specific path while avoiding obstacles represented by golden tokens. Additionally, the robot is designed to grab silver tokens when they are within reach and move them behind itself. The program works by analyzing the robot's position relative to the golden and silver tokens. If the robot is too close to a golden token, it turns away to avoid collision. If the robot is close enough to a silver token, it grabs the token and moves it behind itself.

The project was part of a challenge to make the robot move within a maze made of golden boxes, and the goal was to make the robot grab silver boxes along the way. The behavior of the robot was also specified, and the robot was required to move only counterclockwise, meaning that the robot should always turn to the right when it encounters a wall.

The program was written using a combination of libraries and programming logic. The code was developed step by step, starting with the installation of libraries, the development of functions, and finally, the main code. 



<!-- Installing and running -->
## Installing and running

The simulator requires a Python 2.7 installation, the [pygame](http://pygame.org/) library, [PyPyBox2D](https://pypi.python.org/pypi/pypybox2d/2.1-r331), and [PyYAML](https://pypi.python.org/pypi/PyYAML/).
To install the libraries up here, here's some commands for the linux shell:

```bash
$ sudo apt-get install python-dev python-pip python-pygame python-yaml`
```

``` bash
$ sudo pip install pypybox2d`
```

Once the dependencies are installed, get inside the directory on the shell. To run the game, run the command:

```bash
$ python2 run.py assignment.py`
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




<!-- Main Functions -->
## Main Functions

* Drive motors:
```python
def drive(speed, seconds):
    R.motors[0].m0.power = speed
    R.motors[0].m1.power = speed
    time.sleep(seconds)
    R.motors[0].m0.power = 0
    R.motors[0].m1.power = 0
```

 

1. With the *speed* setting, the robot's linear velocity can be defined.
2. *Seconds* indicates how long the speed will last.


* Rotation:

```python
$ turn(speed, seconds)
```
By setting the "speed", it is possible to define the angular velocity of the robot. "seconds" indicates the duration of the generated speed.


* finding Silver tokens:

```python
$ find_silver_token()
```
Generate the rotation and distance form the Silver Token respect to the robot.
Retuens:
1)distance respect to the robot
2)rotation respect to the robot


* Obstacle avoidance:

```python
$ find_golden_token()
```
find golden tokens and allocate the rotations to different zones to detect the distance of golden tokens respect to the robot.
Returns:
angle and distance of 
   1)right side obstacles
   2)left side obstacles
   3)front side obstacles


* Token availability:

```python
$ Token_check(dist, rot_y,front_obs_dis,left_obs_dis right_obs_dis)
```
Detect and check whether the golden token is between the robot and silver token or not. 


* Main loop:
A while()-loop to control and navigate the robot in the right path to satisfy all desiered purposes.



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



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
