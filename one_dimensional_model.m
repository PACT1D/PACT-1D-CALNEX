 %--------------------------------------------------------------------------------------
 % Platform for Atmospheric Chemistry and Transport in 1D 
 %
 % One dimensional model to calculate atmospheric chemistry & vertical transport 
 % 
 % Developed by:
 % 
 % Jennie L. Thomas: jennie.thomas@univ-grenoble-alpes.fr
 % Katie Tuite: ktuite@ucla.edu
 % Jochen Stutz: jochen@atmos.ucla.edu
 % Shaddy Ahmed: shaddy.ahmed@univ-grenoble-alpes.fr
 %
 % Version 1.0
 % Last updated: May 26, 2020
 %
 % ----------------------------------

close all;
clear all;

% set up path, add mechanism and model toolbox to the matlab path
model_path = pwd;
addpath('./mechanism')
addpath('./model_toolbox')


% use the paramaters created by kpp
mech_Parameters;

% read input text file
read_input_text_file

% do the model initialization, read all input files, set up arrays
%script located in the model_toolbox
initialize_model;

%setup model times
Times = datestr(datenum_chem,'yyyy-mm-dd_HH:MM:SS');

% open netcdf output files
open_netcdf_output(model_path, NLEV, NTIM_CHEM, Times, BOX_WALL,...
    BOXCH, spec, spec_fixed, rates, VT, depo, timeStrLen,...
    temperature, pressure, relative_humidity, rate_constants, ...
    emissions, addemissions, surface_source_emissions, add_surface_source_HONO,...
    output_file_comment, output_file_created_by);

% main time loop for integrating chemistry & writing model output
[spec, spec_fixed, rates, VT, rate_constants] = ...
    integrate_model(model_path,NTIM_CHEM,NLEV,dt_chem,dt_kpp,Times,...
    temperature,pressure,relative_humidity,jrates,spec,spec_fixed,emissions,surface_source_emissions,rates,VT,BOX_WALL,BOXCH,Kz,...
    rate_constants, run_chem, run_vert_diff, addemissions, diffusion_constant, K_het, Eff_dep_surf, n_step_diff,...
    depo,total_loss_to_ground, timeStrLen, add_surface_source_HONO, soil_emi_NO);

disp(['Model run complete!']);

return
% end one dimensional model
