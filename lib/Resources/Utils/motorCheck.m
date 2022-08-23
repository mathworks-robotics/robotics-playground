function motorCheck(model,blk)
% This functions check that any motors have a corresponding 
% Environment block with a valid robot ID
%  Copyright 2018 The MathWorks, Inc.

envBlk=find_system(model,'MaskType','RP Obstacle Environment');
blk_ID=get_param(blk,'robotId');

if size(envBlk)==1
    
    ID=get_param(envBlk,'robotId');
    
    if ~strcmp(ID{1},blk_ID)
        error(['No matching robot ID for ' blk ' Please check robot motor ID matches environment settings'])
    end
end

envBlk=find_system(model,'MaskType','RP Object Environment');

if size(envBlk)==1
    
    ID=get_param(envBlk,'robotId');
    
    if ~strcmp(ID{1},blk_ID)
        error(['No matching robot ID for ' blk ' Please check robot motor ID matches environment settings'])
    end
end
    
envBlk=find_system(model,'MaskType','RP Sumo Game');

if size(envBlk)==1
    
    ID1=get_param(envBlk,'robot1Id');
    ID2=get_param(envBlk,'robot2Id');
    
    if ~strcmp(ID1{1},blk_ID)
        if ~strcmp(ID2{1},blk_ID) 
            error(['No matching robot ID for ' blk ' Please check robot motor ID matches environment settings'])
        end
    end

end

end