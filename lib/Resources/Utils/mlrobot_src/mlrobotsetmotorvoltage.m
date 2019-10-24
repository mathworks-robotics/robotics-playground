function mlrobotsetmotorvoltage(mlrobot,motor,input)
%   MLROBOTSETMOTORVOLTAGE Sets the motor voltage for either the left or
%   right motors connected to the wheels of a MLROBOT robot object.
%
%   mlrobotsetmotorvoltage(mlrobot,motor,voltage)
%
%   Motor selection is 'left' or 'right'
%   Voltage range is between -5 to 5 
%
%   EXAMPLE:
%       myRobot = mlrobot;
%       mlrobotsetmotorvoltage(myRobot,'left',4.5)
%
%   See also MLROBOT MLROBOTSTART MLROBOTREADWHEELSPEED
% 
%  Copyright 2018 The MathWorks, Inc.

mlrobot.writeMotorVoltage(motor,input)

end

