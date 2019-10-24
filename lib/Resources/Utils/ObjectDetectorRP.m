classdef ObjectDetectorRP < matlab.System & matlab.system.mixin.CustomIcon & matlab.system.mixin.Propagates
    % OBJECTDETECTOR Object detector simulator
    %
    % Returns the angles, ranges, and labels of a simulated object detector
    %
    %
    % Copyright 2018 The MathWorks, Inc.
    
    %% PROPERTIES
    % Public (user-visible) properties
    properties(Nontunable)
        mapName = ''; % Map
    end
    properties
        sensorOffset = [0,0]; % Object detector offset (x,y) [m]
        sensorAngle = 0; % Object detector angle [rad]
        fieldOfView = pi/3; % Sensor field of view [rad]
        maxRange = 5; % Maximum range [m]
        maxDetections = 3; % Maximum number of detections
    end

    % Private properties
    properties(Access = private)
        map; % Occupancy grid
    end

    %% METHODS
    methods(Access = protected)
        
        % Setup method: Initializes all necessary graphics objects
        function setupImpl(obj)
            
            % Load the occupancy grid 
            obj.map = createMapFromName(obj.mapName);
            
        end

        % Step method: Outputs simulated lidar ranges based on map,
        % robot pose, sensor field of view, max range, and object color
        function detections = stepImpl(obj,pose,objects)       
            
            % Initialize
            ranges = [];
            angles = [];
            labels = [];
            
            % Find the sensor pose
            theta = pose(3);
            offsetVec = [cos(theta) -sin(theta); ...
                         sin(theta)  cos(theta)]*obj.sensorOffset';
            sensorPose = pose' + [offsetVec', obj.sensorAngle];                                 
            
            % Return the range and angle for all objects
            % First, find the offsets
            offsets = objects(:,1:2) - sensorPose(1:2);
            
            if ~isempty(offsets)
                % Extract ranges and angles
                ranges = sqrt(sum(offsets.^2,2));
                angles = wrapToPi(atan2(offsets(:,2),offsets(:,1))-sensorPose(3));
                
                % Filter by maximum range and field of vision
                validIdx = (ranges <= obj.maxRange) & ... 
                           (abs(angles) <= obj.fieldOfView/2);
                ranges = ranges(validIdx);
                angles = angles(validIdx);
                labels = objects(validIdx,3);
                
                % Use occupancy grid, if any, to account for obstacles
                if ~isempty(obj.map)
                    % Loop backwards since we're removing values
                    for idx = numel(ranges):-1:1  
                        intPts = rayIntersection(obj.map,sensorPose, ... 
                                                 angles(idx),ranges(idx));
                        % Delete the reading if the point is occupied
                        if ~isnan(intPts)
                            ranges(idx) = [];
                            angles(idx) = [];
                            labels(idx) = [];
                        end
                    end
                end
                
            end
            
            if ~isempty(ranges)
                % Sort from nearest
                [ranges,sortedIdx] = sort(ranges);
                angles = angles(sortedIdx);
                if numel(ranges) > obj.maxDetections
                    ranges = ranges(1:obj.maxDetections);
                    angles = angles(1:obj.maxDetections);
                    labels = labels(1:obj.maxDetections);
                end
            end
            
            % Pack the final results into the output
            detections = [ranges, angles, labels];
            
        end

        % More methods needed for the Simulink block to inherit its output
        % sizes from the scan angle parameter provided.
        function sz = getOutputSizeImpl(obj)
            sz = [obj.maxDetections,3];
        end
        
        function fx = isOutputFixedSizeImpl(~)
           fx = false;
        end
        
        function dt = getOutputDataTypeImpl(obj)
            dt = propagatedInputDataType(obj,1);
        end

        function cp = isOutputComplexImpl(~)
            cp = false;
        end
        
        % Define icon for System block
        function icon = getIconImpl(~)
            icon = {'Object','Detector'};
        end
        
    end
    
    methods (Static, Access = protected)
        % Do not show "Simulate using" option
        function flag = showSimulateUsingImpl
            flag = false;
        end
        % Always run in interpreted mode
        function simMode = getSimulateUsingImpl
            simMode = 'Interpreted execution';
        end
    end
    
end
