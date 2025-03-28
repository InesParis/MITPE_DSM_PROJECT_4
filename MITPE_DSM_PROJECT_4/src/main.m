function varargout = main(varargin)
% MAIN MATLAB code for main.m
% This function serves as the entry point for the MITPE DSM project.
% It initializes parameters for the Dependency Structure Matrix (DSM),
% simulates the DSM, and opens the GUI for user interaction.

% Clear workspace and command window
clear all;
clc;

% Initialize DSM parameters
n      = 10;   % Number of components
d      = 2;    % Number of dependencies per component
method = 'odeg'; % Method for initializing DSM
DSM    = init_DSM(n, d, method);  

% Simulate DSM (optional)
% Uncomment the following lines to run the simulation
% kmax   = 1000; % Number of successes to simulate
% tmax   = 1e8;  % Maximum number of time steps to simulate
% [time, cost] = simulateRecipeModel(DSM, kmax, tmax);

% Open the GUI
f = openfig('RecipeGUI.fig');
data = guihandles(f); % Initialize data struct to contain handles for GUI.
data.n      = n;
data.d      = d;
data.method = method;
data.DSM    = DSM;
guidata(f, data);
end