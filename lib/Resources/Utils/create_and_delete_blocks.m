function create_and_delete_blocks(obstacles,block)
% obstacles matrix[nx4] with rectangles with the form [x,y,length,width] 
Arena.length=eval(get_param(block,'arenaLength'));  
Arena.width=eval(get_param(block,'arenaWidth'));
    
% Delete
  enviroment=[block '/Obstacles'];

  blk_list=find_system(enviroment,'Type','Block');

  ref_obj=[enviroment, '/Obstacle1'];     % reference block to be copied
  bus_blk=[enviroment '/RP-Bus'];      % bus block where get new blocks get connected

  blk_safe={enviroment,ref_obj,bus_blk};  % list of blocks that are not deleted
  is_safe=ismember(blk_list,blk_safe);
  blk_remove=blk_list(~is_safe); 

 
   for idx=2:size(blk_remove,1)+1
        deleted_obj=[enviroment, '/Obstacle' num2str( idx)];
        LH_deleted_obj=get_param(deleted_obj,'LineHandles'); % Line handle 
        delete_line(LH_deleted_obj.LConn);
        delete_block(deleted_obj);
        
   end
   
  % create
  n=size(obstacles,1);

  PH_bus=get_param(bus_blk,'PortHandles'); %Port Handle bus

  for idx=2:n
    % positionate the blocks in a  grid path 
    block_pos=[ 415+100*fix(idx/10), 180+90*mod(idx,10),  480+100*fix(idx/10),  240+90*mod(idx,10)];


    new_obj=[enviroment, '/Obstacle' num2str( idx)];
    add_block(ref_obj,ref_obj,'MakeNameUnique','on', 'Position',block_pos); 
    PH_new=get_param(new_obj,'PortHandles');

    % connect each new block to the common bus
    add_line(enviroment,PH_bus.RConn, PH_new.LConn,  'autorouting', 'on');

  end

% set obstacle properties
  for idx=1:n
      
    pos=obstacles(idx,[1,2]);
    length=obstacles(idx,3);
    width=obstacles(idx,4);
    
    % reference frame transformation
    pos=pos + [length-Arena.length,width-Arena.width]/2;
    obj=[enviroment, '/Obstacle' num2str( idx)];
    set_param(obj,'Pose',mat2str( pos ))
    set_param(obj,'length',num2str(length),'width',num2str(width)) 
  end
  
end

