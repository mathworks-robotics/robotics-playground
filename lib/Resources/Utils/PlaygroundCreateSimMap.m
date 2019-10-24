function mapForSim = PlaygroundCreateSimMap(Arena,blk)
% This function parses through the settings in the obstacle environment
% mask and creates an occupancy grid in order to implement sensors
%  Copyright 2018 The MathWorks, Inc.

arenaDimensions=[Arena.width Arena.length];
% Normalize the arena dimensions 
normDims=arenaDimensions/max(arenaDimensions);
mapScale=200/max(arenaDimensions);
mapGridSize=round(normDims*200);


% Initialize obstacle map
locObsMap = ones(mapGridSize(1),mapGridSize(2),'single');
for idx = 1:size(Arena.obj,2)
    % add walls to occupancy map
    locObsMap(1:5,:)=0;
    locObsMap(end-5:end,:)=0;
    locObsMap(:,1:5)=0;
    locObsMap(:,end-5:end)=0;
    
    % if obstacle is enabled in mask then add to occupancy map
    if strcmp(Arena.obj(idx).status,'on')
        
        
        obsLoc(1)=((Arena.obj(idx).position(1)+Arena.length/2)*mapScale)-(Arena.obj(idx).width*mapScale/2);
        obsLoc(2)=mapGridSize(1)-((Arena.obj(idx).position(2)+Arena.width/2)*mapScale)-(Arena.obj(idx).length*mapScale/2);
        obsLoc(3)= Arena.obj(idx).width*mapScale;
        obsLoc(4)= Arena.obj(idx).length*mapScale;
        
        % Get obstacle indices
        currObsLoc = ceil(obsLoc);
        colIdx =  currObsLoc(1):(currObsLoc(1)+currObsLoc(3));
        rowIdx =  currObsLoc(2):(currObsLoc(2)+currObsLoc(4));
        
        % Set obstacle indices to 0 in map
        locObsMap(rowIdx,colIdx) = 0;

    end
    
end

mapForSim.obsMap=locObsMap;
mapForSim.scaleFactor=mapScale;
% imshow(mapForSim.obsMap*240)
% Create simulation map using binary occupancy grid
% compMap = imcomplement(locObsMap); %binary occupancy grid flips this for some reason
compMap=1-locObsMap;
        
mapForSim.simMap = robotics.BinaryOccupancyGrid(compMap,mapScale);
% image(mapForSim.obsMap*240)
% show(mapForSim.simMap)

% Only for testing
% assignin('base','occGrid',mapForSim.simMap)


end