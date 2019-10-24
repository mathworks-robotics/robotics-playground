function disableObstacles(blk)
% This function goes through the objects in and obstacle environment and disables all the obstacles
% It is implemented as a button in the environment mask
%  Copyright 2018 The MathWorks, Inc.


for idx=1:10
    set_param(blk,['obs' num2str(idx)],'off')
    set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','on');
end
    

end
