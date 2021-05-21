clear;
clc;
%% Exercise 3- Measuring and analyzing reaction times in a visual search experiment

% Gali Winterberger      - id 315679571
% Yair Lahad             - id 205493018


%% setting variables
nBlocks=8;                 % number of blocks in the experiment
nTrials=30;                % number of trials per block
sizes=4:4:16;              % sizes of elements per block
colors={'r','b'};          % color used in type of search
shapes={'x','o'};          % shape used in type of search
allResult=cell(1,nBlocks); % experiment raw data
%creating all combinations of blocks
blockType=cell(1,nBlocks);
for i=1:nBlocks
    if i<=nBlocks/2
        blockType{i}={'F',sizes(i)}; % all options for feature search blocks
    else
        blockType{i}={'C',sizes(i-nBlocks/2)}; % all options for Conjunction search blocks
    end
end
%randominzation section
B_order=randperm(nBlocks); % creating random block choosing by indexes

%% setting figure
fontSize=13;
msgSize=30;
h = figure('units','normalized','position', [0 0 1 1]);
set(h,'color','w','MenuBar', 'none','ToolBar', 'none');
axis off      % remove axes

%% running the experiment
instructions(h); % calling a function which explains the whole experiment
for block=1:nBlocks
    %calling a function that run a specific randomly chosen block
    allResult{block}=runBlock(h,block,blockType,B_order,nBlocks,nTrials,colors,shapes);
end
%save("results.mat",'allResult');
%% Analysis
%setting variables
minimumT=20;         % minimum number of trials to pass per block
minimumTotT=160;     % minimum trials to pass in whole expirement
threshold= 3.5;      % value to filter reaction times
totalTrials=zeros(1,nBlocks); % saving number of filtered trials per block
%table variables
BlockNumber=(1:nBlocks)';
S=cell(1,nBlocks);
SeSize=zeros(1,nBlocks);
% creating arrays for saving mean and std for reaction times
... row 1 is for feature and row 2 is for conjunction
meanTarget=zeros(2,nBlocks/2);
meanNon=zeros(2,nBlocks/2);
stdTarget=zeros(2,nBlocks/2);
stdNon=zeros(2,nBlocks/2);

%% filtering Raw data
for block=1:nBlocks
    % saving current block variables from allResult
    currBlock=allResult{block}.Data;
    blockType=allResult{block}.Type;
    blockSize=allResult{block}.Size;
    validTrials=size(currBlock,2); % saving number of coloums (number of trials per block)
    
    %first filter each trial
    for trial=1 : size(currBlock,2)
        % filtering only correct answers and fast enough answers
        if currBlock(2,trial)==0 || currBlock(1,trial)>threshold
            currBlock(1,trial)=nan;
            validTrials=validTrials-1; %updating the number of filtered trials
        end
    end
    totalTrials(1,block)=validTrials; % saving number of  filtered trials per block
    if validTrials<minimumT
        % if not enough trials answered correctly in the specific block
        ...the data cannot be anaylized properly.
        error("not enough trials succeded in  block number "+num2str(block)+ " please try again");
    end
    
    %setting table's information
    S{block}=allResult{block}.title;
    SeSize(block)=blockSize;
    N=[totalTrials]';
    % calculating the mean and std for each kind of task.
    row=2;  % put mean/std in Conjunction row
    if blockType=='F'
        row=1; % put mean/std in Feature row
    end
    col=blockSize/4; % in which size to insert the mean rt
    % calculate mean and std for both types of search
    ...seperating target presented and target absent, only for filterd data:
    meanTarget(row,col)=mean(currBlock(1,currBlock(3,:)==1),'omitnan');
    stdTarget(row,col)=std(currBlock(1,currBlock(3,:)==1),'omitnan');
    meanNon(row,col)=mean(currBlock(1,currBlock(3,:)==0),'omitnan');
    stdNon(row,col)=std(currBlock(1,currBlock(3,:)==0),'omitnan');
end
if sum(totalTrials)>minimumTotT % only proceed with anaylize if enough data was collected from whole experiment
    %updating table's information
    Condition=S';
    setSize=SeSize';
    DataAnalyzed=table(BlockNumber, Condition, setSize, N)
    % calling a function to plot and anaylize search experiment filtered data
    searchPlot(sizes,meanTarget,meanNon,stdTarget,stdNon);
else
    % if not enough data collected then we need to try experiment again
    error("not Enough trials succeded in all expirement, try again!");
end

