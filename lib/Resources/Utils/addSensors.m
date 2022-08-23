function addSensors(blk,robotID)

% This funciton is meant to add a sensor visualization from the components
% library to a robot 
%  Copyright 2018 The MathWorks, Inc.

% Disable the library link so all configurations can be saved with the
% model, otherwise it pulls from the library when model opens
set_param(blk,'LinkStatus','inactive');

% remove any existing visual blocks

subsystem = [blk '/Sensor Visuals'];
blocks = find_system(subsystem,'LookUnderMasks','all');

% Delete all previous blocks except the inport
for idx = 2:length(blocks)-1
    delete_block(blocks{idx})
end

% Delete all signals
while ~isempty(find_system(subsystem,'LookUnderMasks','all','FindAll','on','type','line'))
    lines = find_system(subsystem,'LookUnderMasks','all','FindAll','on','type','line');
    delete_line(lines(1))
end
% Set a position for the Physical connection port
pos1 = [140 100 180 140];
pos2 = [140 170 180 210];

set_param(strcat(subsystem,'/Robot'),'position',[140 60 180 80])
%%  Check for Distance sensors

sensors=find_system(bdroot,'MaskType','RP Distance Sensor');

if ~isempty(sensors)
    % Check for block with a matching Robot ID
    
    for idx=1:size(sensors,1)
        if (eval(get_param(sensors{idx},'robotID')) == robotID)
            pos1 = pos1 + [60 0 60 0];
            pos2 = pos2 + [60 0 60 0];  

            % Get X Y sensor offsets
            xyOffset=get_param(sensors{idx},'sensOff');
            degOffset=get_param(sensors{idx},'sensOffDeg');
            
            % Add sensor visual and set parameters
            add_block('RP_Simulator_Components/US Visual',strcat(subsystem,'/US Visual ',num2str(idx)));
            set_param(strcat(subsystem,'/US Visual ',num2str(idx)),'position',pos1,'Orientation','down');
            set_param(strcat(subsystem,'/US Visual ',num2str(idx)),'pose',xyOffset,'angle',degOffset);
            add_line(subsystem,strcat('Robot','/Rconn1'),strcat('US Visual ',num2str(idx),'/LConn1'));                      
        end
    end
end
%%  Check for contact switch sensors

sensors=find_system(bdroot(gcs),'MaskType','RP Contact Switch');

if ~isempty(sensors)
    % Check for block with a matching Robot ID
    
    for idx=1:size(sensors,1)
        if (eval(get_param(sensors{idx},'robotID')) == robotID)
            pos1 = pos1 + [60 0 60 0];
            pos2 = pos2 + [60 0 60 0];  

            % Get X Y sensor offsets
            xyOffset=get_param(sensors{idx},'sensOff');
            degOffset=get_param(sensors{idx},'sensOffDeg');
            
            % Add sensor visual and set parameters
            add_block('RP_Simulator_Components/Switch Visual',strcat(subsystem,'/Switch Visual ',num2str(idx)));
            set_param(strcat(subsystem,'/Switch Visual ',num2str(idx)),'position',pos1,'Orientation','down');
            set_param(strcat(subsystem,'/Switch Visual ',num2str(idx)),'pose',xyOffset,'angle',degOffset);
            add_line(subsystem,strcat('Robot','/Rconn1'),strcat('Switch Visual ',num2str(idx),'/LConn1'));                      
        end
    end
end

%% Check for Compass

sensors=find_system(bdroot(gcs),'MaskType','RP Compass Sensor');

if ~isempty(sensors)
    % Check for block with a matching Robot ID
    
    for idx=1:size(sensors,1)
        if (eval(get_param(sensors{idx},'robotID')) == robotID)
            pos1 = pos1 + [60 0 60 0];
            pos2 = pos2 + [60 0 60 0];  
            
            % Add sensor visual and set parameters
            add_block('RP_Simulator_Components/Compass Visual',strcat(subsystem,'/Compass Visual ',num2str(idx)));
            set_param(strcat(subsystem,'/Compass Visual ',num2str(idx)),'position',pos1,'Orientation','down');
            add_line(subsystem,strcat('Robot','/Rconn1'),strcat('Compass Visual ',num2str(idx),'/LConn1'));                      
        end
    end
end
%% Check for Object Sensor


sensors=find_system(bdroot(gcs),'MaskType','RP Object Sensor');

if ~isempty(sensors)
    % Check for block with a matching Robot ID
    
    for idx=1:size(sensors,1)
        if (eval(get_param(sensors{idx},'robotID')) == robotID)
            pos1 = pos1 + [60 0 60 0];
            pos2 = pos2 + [60 0 60 0];  

            % Get X Y sensor offsets
            xyOffset=get_param(sensors{idx},'sensOff');
            degOffset=get_param(sensors{idx},'sensOffDeg');
            
            % Add sensor visual and set parameters
            add_block('RP_Simulator_Components/Object Sensor Visual',strcat(subsystem,'/Object Sensor Visual ',num2str(idx)));
            set_param(strcat(subsystem,'/Object Sensor Visual ',num2str(idx)),'position',pos1,'Orientation','down');
            set_param(strcat(subsystem,'/Object Sensor Visual ',num2str(idx)),'pose',xyOffset,'angle',degOffset);
            add_line(subsystem,strcat('Robot','/Rconn1'),strcat('Object Sensor Visual ',num2str(idx),'/LConn1'));                      
        end
    end
end
end