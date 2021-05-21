function  plot_feature(currSize,shape,color,mirShape,target)
fontSize=13;
% randomizing the appearnce of the elements in the figure according to the current block size
locations=100;
xCoord=randperm(locations,currSize)/locations; 
yCoord=randperm(locations,currSize)/locations;
if target==1 %if there is a target
    for i=1 : currSize %getting the number of elements to show
        if i<=currSize-1
            text (xCoord(i),yCoord(i),shape,'color',color,'fontSize', fontSize);
        else
            % target means only one element is diffrent in shape but not color
            text (xCoord(i), yCoord(i),mirShape,'color',color,'fontSize', fontSize);
        end
    end
else % no Target
    for i=1: currSize
        text (xCoord(i), yCoord(i),shape,'color',color,'fontSize', fontSize);
    end
end
end
