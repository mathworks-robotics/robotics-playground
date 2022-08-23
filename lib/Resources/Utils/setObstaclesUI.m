function setObstaclesUI(blk)
% This function is an interactive obstacle placement tool
% It is implemented within the obstacle environment mask and provides the
% user the ability to draw the desired obstacles within the map.
%  Copyright 2018 The MathWorks, Inc.
    
numObs=inputdlg('Number of obstacles to place (Max 10): ','Obstacle sekection');

for idx=1:10
    set_param(blk,['obs' num2str(idx)],'off')
    set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','on');
end
    

if ~isempty(numObs)

    % disable all obstacle sin mask
    
    
    hg=figure('Name','Set Arena Obstacles','NumberTitle','off');
    length=eval(get_param(blk,'arenaLength'));
    width=eval(get_param(blk,'arenaWidth'));
    arenaDimensions=[width length];
    
    % Normalize the arena dimensions 
    
    normDims=arenaDimensions/max(arenaDimensions);
    mapScale=2048/max(arenaDimensions);
    mapGridSize=round(normDims*2048);
    xScale=mapGridSize(2)/length;
    yScale=mapGridSize(1)/width;

    image=imread('PlaygroundImage.png');
    scaledImg=imresize(image,mapGridSize);
    
    imshow(scaledImg)
    
    for idx=1:eval(numObs{1})
        title(['Draw obstacle ' num2str(idx) ' as a rectangle by clicking and dragging on map'])
        h=imrect;
        %     wait(h(idx));
        recPose(:)=getPosition(h);        
        
        % Fill-in rectangle with obstacle color for user feedback
        rectangle('Position',recPose(:),'FaceColor',[1 0.4 0.2]);
        
        % Correct y axis inversion from image axis and scale to world
        % coordinates
        
        imgPose(:)=[-mapGridSize(2)/2+recPose(1)+recPose(3)/2 mapGridSize(1)/2-recPose(2)-recPose(4)/2 recPose(3:4)];
        
        % shift objects to correct reference frame
        obsPose(:)=[imgPose(1)/xScale imgPose(2)/yScale imgPose(3)/xScale imgPose(4)/yScale];
        
        % set parameters on block mask
        set_param(blk,['obs' num2str(idx)],'on')
        set_param(blk,['obsPose' num2str(idx)],['[' num2str(obsPose(1:2)) ']']);
        set_param(blk,['obsWidth' num2str(idx)],num2str(obsPose(3)));
        set_param(blk,['obsLength' num2str(idx)],num2str(obsPose(4)));
        set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','off');
        
    end
    pause(1)
    close(hg)
end
end
