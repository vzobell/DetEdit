function spParams = sp_setting_defaults(sp,spParamsUser)
% Establish basic parameter settings, then update for species
% specific defaults, and user preferences.
% Pulled into subroutine kf 10/4/2016

spParams = [];

specChar = 'Unk';  %Simone abbreviation for species
speName = 'Unknown';  % Species code used in file names 
tfSelect = 0; % freq used for transfer function, leave at 0 if no adjustment
dtHi = .5; % max yaxis value for IPI display in sec
fLow = 100; % boundary for spectrum plot
thresRL = 0; % minimum RL threshold in dB peak-to-peak
ltsaContrast = 250; % ltsa contrast
ltsaBright = 100; % ltsa brightness
ltsaLims = [0,100]; % max and min of LTSA plot
ltsaMax = 6; % ltsa maximum duration per session
rlLow = 110; % PP plot window low limit
rlHi = 170; % PP plot window high limit
dfManual = []; % LTSA step size in 10 [Hz] bins
p1Low = thresRL - 5;
p1Hi = 170; % ??


if (strcmp(sp,'Ko') || strcmp(sp,'k'))
    specChar = 'K';
    speName = 'Kogia';
    tfSelect = 80000; 
    dtHi = 0.5;  
    fLow = 70;   
    thresRL = 116;
elseif (strcmp(sp,'Zc') || strcmp(sp,'z'))
    specChar = 'Z';
    speName = 'Cuviers';  tfSelect = 40200;
    dtHi = 1.0; 
    fLow = 25;  
    thresRL = 121; 
    ltsaContrast = 200; ltsaBright = 30;
elseif (strcmp(sp,'Me') || strcmp(sp,'m'))
    specChar = 'M';
    speName = 'Gervais';
    tfSelect = 40200;
    dtHi = 1.0; 
    fLow = 25; 
    thresRL = 121;
elseif (strcmp(sp,'BWG') || strcmp(sp,'g'))
    specChar = 'G'; %Simone abbreviations for BW species
    speName = 'BWG';  tfSelect = 40200; % freq used for transfer function
    dtHi = 1.0; % scale for IPI display in sec
    fLow = 25;   % 25 kHz boundary for spec plot
    thresRL = 121; % dB threshold
elseif (strcmp(sp,'Md') || strcmp(sp,'d'))
    specChar = 'D'; 
    speName = 'BW31';  tfSelect = 40200; 
    dtHi = 1.0;
    fLow = 25; 
    thresRL = 121;
elseif strcmpi(sp,'De')
    speName = 'Delphin';  
    tfSelect = 0; % already in dB no correction
    dtHi = 0.6; 
    fLow = 10;   
    thresRL = 118;
    rlLow = thresRL - 6.9; rlHi = 190;
elseif (strcmp(sp,'Po') || strcmp(sp,'p'))
    speName = 'Porpoise';  tfSelect = 0; 
    dtHi = 0.5; 
    fLow = 25;  
    thresRL = 100;
    rlLow = thresRL - 5; rlHi = 190;
    ltsaContrast = 250; ltsaBright = 100; 
elseif strcmpi(sp,'MFA')
    speName = 'MFA';  tfSelect = 4000; 
    ltsaMax = .5; 
    thresRL = 80;
    dtHi = 2;
    fLow = 2;  
    rlLow = thresRL - 5; rlHi = 180;
    dfManual = 10;   
elseif strcmpi(sp,'whs')
    speName = 'whs';  tfSelect = 0; 
    ltsaMax = .5;
    thresRL = 0;
    dtHi = 2; 
    fLow = 5;   
    rlLow = 0; rlHi = 20;
    dfManual = 10;   
    ltsaContrast = 310; ltsaBright = 100; 
    ltsaLims = [5,30];
elseif strcmpi(sp,'Dl')
    speName = 'Beluga'; tfSelect = 45000;
    dtHi = 0.5;
    fLow = 20;  
    thresRL = 110;
    p1Low = thresRL - 5; p1High = 170;
    ltsaContrast = 200; ltsaBright = 70; 
else
    disp('CAUTION: Unknown Species Type!!!')
end

%% apply default if user has not specified a value
if ~exist('spParamsUser.specChar', 'var')
    spParams.specchar = specChar;
else
    spParams.specchar = spParamsUser.specChar;
end

if ~exist('spParamsUser.speName', 'var')
    spParams.speName = speName;
else
    spParams.speName = spParamsUser.speName;
end

if ~exist('spParamsUser.tfSelect', 'var')
    spParams.tfSelect = tfSelect;
else
    spParams.tfSelect = spParamsUser.tfSelect;
end

if ~exist('spParamsUser.dtHi', 'var')
    spParams.dtHi = dtHi;
else
    spParams.dtHi = spParamsUser.dtHi;
end

if ~exist('spParamsUser.fLow', 'var')
    spParams.fLow = fLow;
else
    spParams.fLow = spParamsUser.fLow;
end

if ~exist('spParamsUser.thresRL', 'var')
    spParams.thresRL = thresRL;
else
    spParams.thresRL = spParamsUser.thresRL;
end

if ~exist('spParamsUser.ltsaContrast', 'var')
    spParams.ltsaContrast = ltsaContrast;
else
    spParams.ltsaContrast = spParamsUser.ltsaContrast;
end

if ~exist('spParamsUser.ltsaBright', 'var')
    spParams.ltsaBright = ltsaBright;
else
    spParams.ltsaBright = spParamsUser.ltsaBright;
end

if ~exist('spParamsUser.ltsaLims', 'var')
    spParams.ltsaLims = ltsaLims;
else
    spParams.ltsaLims = spParamsUser.ltsaLims;
end

if ~exist('spParamsUser.ltsaMax', 'var')
    spParams.ltsaMax = ltsaMax;
else
    spParams.ltsaMax = spParamsUser.ltsaMax;
end

if ~exist('spParamsUser.rlLow', 'var')
    spParams.rlLow = rlLow;
else
    spParams.rlLow = spParamsUser.rlLow;
end

if ~exist('spParamsUser.rlHi', 'var')
    spParams.rlHi = rlHi;
else
    spParams.rlHi = spParamsUser.rlHi;
end

if ~exist('spParamsUser.dfManual', 'var')
    spParams.dfManual = dfManual;
else
    spParams.dfManual = spParamsUser.dfManual;
end

if ~exist('spParamsUser.dfManual', 'var')
    spParams.dfManual = dfManual;
else
    spParams.dfManual = spParamsUser.dfManual;
end

if ~exist('spParamsUser.p1Low', 'var')
    spParams.p1Low = p1Low;
else
    spParams.p1Low = spParamsUser.p1Low;
end

if ~exist('spParamsUser.p1Hi', 'var')
    spParams.p1Hi = p1Hi;
else
    spParams.p1Hi = spParamsUser.p1Hi;
end
