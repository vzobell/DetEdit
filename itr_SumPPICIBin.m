% itr_SumPPICIBin
% Iterates over a directory of TPWS files and calls modDet for each
% one.

clearvars
filePrefix = 'GofMX_MC'; % File name to match. 
% File prefix should include deployment, site, (disk is optional). 
% Example: 
% File name 'GofMX_DT01_disk01-08_TPWS2.mat' 
%                    -> filePrefix = 'GofMX_DT01'
% or                 -> filePrefix ='GOM_DT_09' (for files names with GOM)
sp = 'Pm'; % your species code
itnum = '3'; % which iteration you are looking for
countType = 'C'; % Tpype of counting
% Example:
%                   -> 'C' - Click counting
%                   -> 'G' - Group counting
%                   -> 'B' - Both counting
srate = 200; % sample rate
tpwsPath = 'E:\TPWS'; %directory of TPWS files
%tfName = 'E:\transfer_functions'; % Directory ...
% with .tf files (directory containing folders with different series ...
effortXls = 'E:\Pm_Effort.xls'; % specify excel file with effort times
refStartTime = '2010-May-01'; % specify start reference date for all plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% define subfolder that fit specified iteration
if itnum > 1
   for id = 2: str2num(itnum) % iternate id times according to itnum
       subfolder = ['TPWS',num2str(id)];
       tpwsPath = (fullfile(tpwsPath,subfolder));
   end
end

% Find all TPWS files that fit your specifications (does not look in subdirectories)
% Concatenate parts of file name
if isempty(sp)
    detfn = [filePrefix,'.*','TPWS',itnum,'.mat'];
else
    detfn = [filePrefix,'.*',sp,'.*TPWS',itnum,'.mat'];
end
% Get a list of all the files in the start directory
fileList = cellstr(ls(tpwsPath));
% Find the file name that matches the filePrefix
fileMatchIdx = find(~cellfun(@isempty,regexp(fileList,detfn))>0);
if isempty(fileMatchIdx)
    % if no matches, throw error
    error('No files matching filePrefix found!')
end

% Get effort times matching prefix file
allEfforts = readtable(effortXls);
site = strsplit(filePrefix,'_');
effTable = allEfforts(ismember(allEfforts.Sites,site(2)),:);

% make Variable Names consistent
startVar = find(~cellfun(@isempty,regexp(effTable.Properties.VariableNames,'Start.*Effort'))>0,1,'first');
endVar = find(~cellfun(@isempty,regexp(effTable.Properties.VariableNames,'End.*Effort'))>0,1,'first');
effTable.Properties.VariableNames{startVar} = 'Start';
effTable.Properties.VariableNames{endVar} = 'End';

effort = effTable(:,[startVar,endVar]);
% startEffort = datetime(effTable.StartEffort,'ConvertFrom','datenum');
% endEffort = datetime(effTable.EndEffort,'ConvertFrom','datenum');
% 
% effort = timetable(startEffort,endEffort);

% concatenate all true detections from the same site and create the plots
concatFiles = fileList(fileMatchIdx);

SumPPICIBin('filePrefix',filePrefix,'concatFiles', concatFiles,'sp', sp,...
    'sdir', tpwsPath,'countType',countType,'effort',effort,...
    'refTime',refStartTime);


disp('Done processing')