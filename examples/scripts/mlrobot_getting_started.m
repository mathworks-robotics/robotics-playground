%% MLRobot Getting Started
%  Copyright 2018 The MathWorks, Inc.

% Start the simulation environment by creating a robot and starting the
% simulation

myRobot = mlrobot;
mlrobotstart(myRobot);

%% Interact with Robot
%
% Set the motor voltages to have the robot move forward
mlrobotsetmotorvoltage(myRobot,'left',-3);
mlrobotsetmotorvoltage(myRobot,'right',3);

% Wait for a period of time so the robot moves some distance
pause(5)

% Set the motor voltages so the robot will turn

mlrobotsetmotorvoltage(myRobot,'left',3);
mlrobotsetmotorvoltage(myRobot,'right',3);
pause(3)

% Set back the motor voltages so the robot will go straight

mlrobotsetmotorvoltage(myRobot,'left',-3);
mlrobotsetmotorvoltage(myRobot,'right',3);
pause(5)

% Set the motor voltages so the robot will keep spinning

mlrobotsetmotorvoltage(myRobot,'left',-5);
mlrobotsetmotorvoltage(myRobot,'right',-5);
pause(8)

%% Stop the simulation

mlrobotstop(myRobot);
