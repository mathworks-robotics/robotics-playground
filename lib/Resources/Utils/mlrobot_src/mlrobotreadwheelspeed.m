function speed=mlrobotreadwheelspeed(mlrobot,wheel)
%   MLROBOTREADWHEELSPEED Reads the instantaneous wheel speed from either
%   the left or right wheel of the MLROBOT object in degrees per second
%   (deg/s).
%
%   mlrobotreadwheelspeed(mlrobot,wheel)
%
%   Wheel selection is 'left' or 'right'
%
%   EXAMPLE:
%       myRobot = mlrobot;
%       mlrobotstart(myRobot);
%       speed = mlrobotreadwheelspeed(myRobot,'left')
%
%   See also MLROBOT MLROBOTSTART MLROBOTSETMOTORVOLTAGE
%   MLROBOTREADCOMPASSANGLE
%
%  Copyright 2018 The MathWorks, Inc.

speed=mlrobot.readWheelSpeed(wheel);

end
