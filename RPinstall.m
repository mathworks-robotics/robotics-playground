clear
clc

%% Install toolbox

matlab.addons.install(which('Robotics Playground.mltbx'))

%% Only add files to MATLAB path
% Note that by only adding the files to the MATLAB path the Application and
% Documentation will not be installed

% addpath(genpath(pwd));