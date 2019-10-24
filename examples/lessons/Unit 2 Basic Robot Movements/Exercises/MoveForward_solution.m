% Create virtual robot
myRobot=mlrobot;

% Start running the virtual environment simulation
mlrobotstart(myRobot);

% Set both motors to a value that will make the robot move forward
% NOTE: The direction of one motor is inverted use a negative value if
% necessary 
% HINT: use "mlrobotsetmotorvoltage"

mlrobotsetmotorvoltage(myRobot,'left',-3);
mlrobotsetmotorvoltage(myRobot,'right',3);

% delay for 5 seconds so the robot moves forward
pause(5);

% Set motors to opposing values to make the robot turn

% Wait for a period of time until the robot is facing in the opporite
% direction

% Set both motors to zero voltage
% HINT: use "mlrobotsetmotorvoltage"

mlrobotsetmotorvoltage(myRobot,'left',0);
mlrobotsetmotorvoltage(myRobot,'right',0);

% Stop simulation
mlrobotstop(myRobot);
