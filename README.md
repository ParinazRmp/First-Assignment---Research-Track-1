# First Assignment - Research Track 1
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
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
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



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



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
