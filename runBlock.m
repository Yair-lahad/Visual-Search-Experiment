function blockResults= runBlock(h,block_num,blockType,B_order,nBlocks,nTrials,colors,shapes)
%% randomization section
%get the block that was chosen randomly in the main section
currBlock=blockType{B_order(block_num)};
% randomly choose if Target or Not (equally size of blocks/2 times each)
targets=  mod( randperm(nTrials),2 ); 

%% setting Variables
msgSize=30;
rt=zeros(1,nTrials);    % saving reaction times for all trials per block 
acc=zeros(1,nTrials);   % saving correct or incorrect answer for trial task per block
nColors=size(colors,2); % number of colors in experiment
nShapes=size(shapes,2); % number of shapes in experiment
miror=nShapes:-1:1; % vector to help us to regocnize the opposite color or shape to use
currType=currBlock{1,1}; %getting the Block search Type- Feature or Conjunction type
currSize=currBlock{1,2}; %getting the number of elements to show

for trial=1:nTrials
    % setting figure
    set(h,'color','w','MenuBar', 'none','ToolBar', 'none');
    axis off  
    % setting trial variables
    % choose randomly between Target\non Target
    targetMode= targets(trial); % 1 for Target and 0 for non Target, according to target vec
    % choose color randomly (red or blue)
    whichCol=randi([1 nColors],1);
    color = colors{whichCol}(1);
    mirColor=colors{miror(whichCol)}(1);
    % choose shape randomly (x or o)
    whichShape=randi([1 nShapes],1);
    shape = shapes{whichShape}(1);
    mirShape=shapes{miror(whichShape)}(1);
    
    % Feature Search
    if currType=='F'
        set(h,'Name','Feature Search Experiment');
        plot_feature(currSize,shape,color,mirShape,targetMode);
    else % Conjunction Search
        set(h,'Name','Conjunction Search Experiment');
        plot_Conjunction(currSize,shape,color,mirShape,mirColor,targetMode);
    end
    % collecting Data
    tic
    pause;
    key = get(h,'CurrentCharacter');
    rt(trial)=toc;
    if targetMode==1
        acc(trial)= strcmpi(key,'A');
    else
        acc(trial)=strcmpi(key,'L');
    end
    clf(h);
end
if block_num< nBlocks % break between blocks
    g=text(0.18,0.5,'End of block, press spacebar to continue','fontsize',msgSize,'color','g');
    set(h,'color','w','MenuBar', 'none','ToolBar', 'none');
    axis off;
    pause();
    key = get(h,'CurrentCharacter');
    while ~strcmpi(key,' ') % if other key was pressed
        pause();
        key = get(h,'CurrentCharacter');
    end
    delete(g);
else % last block
    text(0.3,0.5,'Thank you for participating','fontsize',msgSize,'color','g');
    set(h,'color','w','MenuBar', 'none','ToolBar', 'none');
    axis off;
    pause(3);
    close all;
end
%updating result data for output
blockResults.Data=[rt;acc;targets];
blockResults.Type=currType;
blockResults.Size=currSize;
if currType=='F'
    blockResults.title='Feature Search';
else
    blockResults.title='Conjunction Search';
end
end