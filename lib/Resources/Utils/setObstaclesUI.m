function setObstaclesUI(blk)
  % This function is an interactive obstacle placement tool
  % It is implemented within the obstacle environment mask and provides the
  % user the ability to draw the desired obstacles within the map.
  %  Copyright 2018 The MathWorks, Inc.

  numObs=inputdlg('Number of obstacles to place (Max 10): ','Obstacle sekection');
  % 
  % for idx=1:10
  %     set_param(blk,['obs' num2str(idx)],'off')
  %     set_param([blk '/Obstacles/Obstacle' num2str(idx)],'Commented','on');
  % end

  if ~isempty(numObs)

      n=eval(numObs{1})       % number of obstacles

      S.f=figure('Name','Set Arena Obstacles','NumberTitle','off');
      length=eval(get_param(blk,'arenaLength'));
      width=eval(get_param(blk,'arenaWidth'));
      arenaDimensions=[length width];




      plot(length/2,width/2,'+')
      arena=[0 0 length width];    
      rectangle('Position',arena ,'FaceColor',[0.8 .8 .8 0.1])
      ax = gca;
      axis equal 
      set(ax,'XTick', [0:length],'XTickLabel', [])
      set(ax,'YTick', [0:width],'YTickLabel', [])
      set(ax,'xlim',[0 length],'ylim',[0 width]);
      grid on

      % Walls 
      xline(0,'k','LineWidth',3)
      yline(0,'g','LineWidth',3)
      xline(length,'b','LineWidth',3)
      yline(width,'r','LineWidth',3)
      

      S.obstacles=[0 0 1 1];  % default obstacle   
      S.blk=blk;              % add block reference to structure  


      for idx= 1:n

          inputRect{n}=imrect;
          recPose=getPosition(inputRect{n}); 
          rectangle('Position',recPose,'FaceColor',[1 0.4 0.2])
          S.obstacles(idx,:)=recPose;
      end
      min=0.1;    % minimum block thickenss 
      is_slim=logical([zeros(n,2),S.obstacles(:,3:4)<min]);
      S.obstacles(is_slim)=min;
      S.obstacles=round(S.obstacles,2)
     %callback function for the pushbutton  
      S.pb = uicontrol('style','push',...
                   'units','pix',...
                   'position',[10 5 180 35],...
                   'fontsize',12,...
                   'string','Export obstacle position',...
                   'callback',{@pb_export,S});

      S.pb2 = uicontrol('style','push',...
                   'units','pix',...
                   'position',[300 5 180 35],...
                   'fontsize',12,...
                   'string','Done',...
                   'callback',{@pb_done,S});

  end
 

end

 function pb_export(varargin)
    [file,path] = uiputfile('maze.csv')  
    S = varargin{3};  % Get the structure.
    csvwrite([path file],S.obstacles)
      
end

 function pb_done(varargin)
    S = varargin{3};  % Get the structure.
    blk=S.blk;
    
    set_param(blk,'obstacles',mat2str(S.obstacles));
        
    closereq(); 
end
