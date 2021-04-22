function  [init_total_loss_to_ground,error_msg] = init_surfStor(initial_surf_stor_file , total_loss_to_ground_t0, Times)
%created by KBT 9/23919 
%read the list of species from the mech.spc file, look for these in the
% netcdf file with the initial surface storage values
% If the species is not in initial_surf_storage.nc, this routine will
% initialize it to 0

%add model parameters
mech_Parameters;

error_msg = [];

%spec_names = get_spec_names( );

%-------------------------  Read the inital surface storage file ------------------------------------
%read inital surface storage netcdf file
ncid = netcdf.open(initial_surf_stor_file,'NOWRITE');
%varid = netcdf.inqVarID(ncid,'BOX_WALL');
%BOX_WALL_spec = netcdf.getVar(ncid,varid);

% %all initial concentrations 
% %pick a minimum concentration value, set all initial concentations to this
% minConcVal = 1e-20;                       %minimum concentration values
% spec_t0    = ones(NVAR,NLEV)*minConcVal;  %non zero initial concentraitons

%get the times of the initial concentration file
varid      = netcdf.inqVarID(ncid,'Times');
Time_initC = netcdf.getVar(ncid,varid);
Time_initC = Time_initC.';

%if the initial surface storage time is not equal to the master time file
%initial time, exit with an error message
if Times(1,:) ~= Time_initC 
  error_msg = ['Initial surface storage time in init_surf_storage.nc not the same as the run start time.'];
  return
end

% %get the Box hights from the initial concentration file
% varid          = netcdf.inqVarID(ncid,'BOX_WALL');
% BOX_WALL_initC = netcdf.getVar(ncid,varid);
% 
% %if the model levels are different - then  send an error message
% if BOX_WALL_initC ~= BOX_WALL 
%   error_msg = ['The model levels in the master initialization file master_time_lev.nc are different from the init_spec.nc file.'];
%   return
% end

%get list of varIDs in the files
varIDs = netcdf.inqVarIDs(ncid);
[~, nvarIDs] = size(varIDs);

% for i=2:nvarIDs-1  %skip the first value, it's the model grid
for i=0:nvarIDs-1   
  var = netcdf.inqVar(ncid,i);                              %species name from the netcdf file
  if ismember(var,'BOX_WALL')
        disp('reading model levels');
    elseif ismember(var,'Times')
        disp('reading time values');
    else
        disp(['reading surface storage & setting initial value for - ' var]);
        ind = get_ind(var);                                       %finding this species name in the mechanism
        total_loss_to_ground_t0(ind,:) = netcdf.getVar(ncid,i);                   %use ind for the spec array always!!!!, i is for the loop over the netcdf file
  end
end
init_total_loss_to_ground = total_loss_to_ground_t0;

netcdf.close(ncid);
