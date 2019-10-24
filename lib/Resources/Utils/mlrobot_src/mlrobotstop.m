function mlrobotstop(mlrobot)
%MLROBOTSTOP   This function stops running the virtual environment for a
%	MLROBOT robot.
%
%   Example:
%
%       myRobot = mlrobot;
%       mlrobotstart(myRobot);
%       mlrobotstop(myRobot);
%
%   See also MLROBOT MLROBOTSTART
%
%  Copyright 2018 The MathWorks, Inc.

    mlrobot.disconnect;

end
