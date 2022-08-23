% Create virtual robot
myRobot=mlrobot;

% Start running the virtual environment simulation
mlrobotstart(myRobot);

% Set both motors to a value that will make the robot move forward
% NOTE: The direction of one motor is inverted use a negative value if
% necessary 
% HINT: use "mlrobotsetmotorvoltage"



% delay for 5 seconds so the robot moves forward
pause(5);

% Set both motors to zero voltage
% HINT: use "mlrobotsetmotorvoltage"



% Stop simulation
mlrobotstop(myRobot);
