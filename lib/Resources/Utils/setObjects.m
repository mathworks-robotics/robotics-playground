function setObjects(blk)
% This function is a callback implemented in the obstacle environment map
% to update settings on the objects within the environment
%  Copyright 2018 The MathWorks, Inc.

for idx=1:5
    if strcmp(get_param(blk,['obj' num2str(idx)]),'off')
        set_param([blk '/Objects/Object' num2str(idx)],'Commented','on');
    else
        set_param([blk '/Objects/Object' num2str(idx)],'Commented','off');
    end
    % set parameters on block mask
    pose=get_param(blk,['obj' 'Pose' num2str(idx)]);
    set_param([blk '/Objects/Object' num2str(idx)],'Pose',pose);
    % set the color and object label
    color=get_param(blk,['obj' 'Color' num2str(idx)]);
    if strcmp(color,'Red')
        set_param([blk '/Objects/Object' num2str(idx)],'color','[0.8 0 0]');
    elseif strcmp(color,'Green')
        set_param([blk '/Objects/Object' num2str(idx)],'color','[0 0.8 0]');
    else
        set_param([blk '/Objects/Object' num2str(idx)],'color','[0 0 0.8]');
    end
end

end
