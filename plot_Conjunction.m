function  plot_Conjunction(currSize,shape,color,mirShape,mirColor,target)
fontSize=13;
% randomizing the appearnce of the elements in the figure according to the current block size
locations=100;
xCoord=randperm(locations,currSize)/locations; 
yCoord=randperm(locations,currSize)/locations;  
if target==1 %if there is a target
    for i=1:currSize
        if i<=currSize/2
           text (xCoord(i), yCoord(i),shape,'color',color,'fontSize', fontSize);
        elseif i>currSize/2 && i<=currSize-1
            % half of elements in diffrent shape
           text (xCoord(i), yCoord(i),mirShape,'color',mirColor,'fontSize', fontSize);
        else
            % only one element from the half is in diffrent color
           text (xCoord(i), yCoord(i),mirShape,'color',color,'fontSize', fontSize);
        end
    end
else % no Target
    for i=1:currSize
        if i<=currSize/2
           text (xCoord(i), yCoord(i),shape,'color',color,'fontSize', fontSize);
        else
           text (xCoord(i), yCoord(i),mirShape,'color',mirColor,'fontSize', fontSize);
        end
    end
end
end