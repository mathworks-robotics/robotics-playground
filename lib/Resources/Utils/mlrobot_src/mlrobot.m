classdef mlrobot
% MLROBOT Creates a MATLAB Disc Robot in a virtual environment.
%   This class is intended for learning to program in 
%   MATLAB using the Robotics Playground. This robot provides a virtual
%   environment visualization and access to sensors and actuators using
%   MATLAB functions.
%   
%   EXAMPLE:
%      myRobot = mlrobot;
%      mlrobotstart(myRobot);
%      mlrobotsetmotorvoltage(myRobot,'left',3);
%      wheelSpeed = mlrobotreadwheelspeed(myRobot,'left');
%      mlrobotstop(myRobot);
%
%   Open getting started example with the following command:
%
%       >> edit mlrobot_getting_started
%
%
%   When using with a custom model that reuses the 'MATLAB Disc Robot' from
%   the Simulink Robotics Playground library, call this class by passing
%   the custom model name as an input
%
%       myRobot = mlrobot('customModelName')
%
%   See also MLROBOTSTART MLROBOTSTOP MLROBOTSETMOTORVOLTAGE
%   MLROBOTREADWHEELSPEED MLROBOTREADCOMPASSANGLE
%
%  Copyright 2018 The MathWorks, Inc.
      
    properties
        modelName='RP_MATLAB_Disc_robot';
    end
    
    methods
        function obj = mlrobot(varargin)
            % The constructor should initialize the class and change the
            % modelName if a custom model is used
            if nargin==1
                obj.modelName=varargin{:};
            end

        end
        function obj = close(obj)
            bdclose(obj.modelName);
        end
        
        function obj=connect(obj)
            if ~bdIsLoaded(obj.modelName)
                disp('Loading robot environment...')
                load_system(obj.modelName)
                disp('Robot environment loaded')
            end
            disp('Starting simulation...')
            set_param(obj.modelName,'SimulationCommand','start');
            set_param([obj.modelName '/MATLAB Disc Robot/Robot/leftVoltage'],'Gain','0');
            set_param([obj.modelName '/MATLAB Disc Robot/Robot/rightVoltage'],'Gain','0');
            disp('Simulation started')
        end
        
        function disconnect(obj)
            set_param(obj.modelName,'SimulationCommand','stop')
            disp('Simulation stopped')
        end
        
        function writeMotorVoltage(obj,motor,input)
            % This function writes the input as the right motor voltage to the
            % simulation
           if strcmp(motor,'left')
               set_param([obj.modelName '/MATLAB Disc Robot/Robot/leftVoltage'],'Gain',num2str(input));
           elseif strcmp(motor,'right')
               set_param([obj.modelName '/MATLAB Disc Robot/Robot/rightVoltage'],'Gain',num2str(input));
           else
               error('Incorrect motor selection. Choose between ''left'' and ''right''')
           end
           if input>5 || input<-5
               error('Input is out of bounds and will be saturated. Correct range is -5 to 5')
           end
            
        end
        
        function wheelSpeed=readWheelSpeed(obj,wheel)
            robject=get_param([obj.modelName '/MATLAB Disc Robot/Robot/Sensors'],'RuntimeObject');
            if strcmp(wheel,'left')
                wheelSpeed=robject.InputPort(1).Data(3);
            elseif strcmp(wheel,'right')
                wheelSpeed=robject.InputPort(1).Data(5);
            else
                error('Incorrect wheel selection. Choose between ''left'' and ''right''')
            end
        end
        
        function compassAngle=readCompassAngle(obj)
            robject=get_param([obj.modelName '/MATLAB Disc Robot/Robot/Sensors'],'RuntimeObject');
            compassAngle=robject.InputPort(1).Data(1);
        end
    end
        
end

