function commentObstacles(blk)
% This function comments or uncomments obstacle blocks when a mask
% parameter is changed
%
%  Copyright 2018 The MathWorks, Inc.
    

for idx=1:10
        status=get_param(blk,strcat('obs',num2str(idx)));
        
        if strcmp(status,'off')
            set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','on');
        else
            set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','off');
        end
end

        
end
