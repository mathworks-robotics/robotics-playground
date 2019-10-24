function angle=mlrobotreadcompassangle(mlrobot)
%   MLROBOTREADCOMPASSANGLE Reads the angle an MLROBOT robot with respect
%   to the world in degrees (deg).
%
%   mlrobotreadcompassangle(mlrobot)
%
%
%   EXAMPLE:
%       myRobot = mlrobot;
%       mlrobotstart(myRobot);
%       angle = mlrobotreadcompassangle(myRobot)
%
%   See also MLROBOT MLROBOTSTART MLROBOTSETMOTORVOLTAGE
%   MLROBOTREADWHEELSPEED
%
%  Copyright 2018 The MathWorks, Inc.

angle=mlrobot.readCompassAngle;

end