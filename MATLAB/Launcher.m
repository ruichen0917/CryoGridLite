clear all
clc
%% Initial configuration
addpath(genpath('./src')); % Add the necessary module
in_path = "../input/"; % Directory of stored forcing, soil properties, and initial soil temperature
out_path = "./output/";
restart_path = "./restart/";
forcing_data = "TPMFD";
scenario = "Historical";
spinup_period = 10; % Use the first 10 years of forcing data to force the model to equilibrium
coordinate = readmatrix("../Coords_lon_lat.csv");
gridcell = coordinate(1171,:);
% Create output file path and restart file path
% if ~exist([out_path,model,scen,num2str(gridcell(1),'%.2f'),'_',num2str(gridcell(2),'%.2f')],'dir')
%     mkdir([out_path,model,scen,num2str(gridcell(1),'%.2f'),'_',num2str(gridcell(2),'%.2f')]);
% end
% if ~exist([restart_path,num2str(gridcell(1),'%.2f'),'_',num2str(gridcell(2),'%.2f')],'dir')
%     mkdir([restart_path,num2str(gridcell(1),'%.2f'),'_',num2str(gridcell(2),'%.2f')])
% end
%% Check restart conditions
% if isempty(dir([restart_path,num2str(gridcell(1),'%.2f'),'_',num2str(gridcell(2),'%.2f'),'/Restart*.mat']))
    restart_flag = 0;
    starttime = datetime(1979,1,1,00,00,00);
    endtime = datetime(2022,12,31,23,00,00);
% else
    % restart_flag = 1;
% end
%% load forcing
forcing_path = fullfile(in_path,"FORCING",forcing_data,scenario);
FORCING = GenerateForcing(forcing_path, gridcell, starttime, endtime);

