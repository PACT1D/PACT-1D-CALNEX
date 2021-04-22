function [NO_SoilEm,error_msg] = read_soil_emi(soil_emi_file,Times,BOX_WALL);
% read Kz values from netcdf file

 error_msg = [];
 
 %read open the Kz file
 ncid = netcdf.open(soil_emi_file,'NOWRITE');
 
 %get the times of the kz file
 varid      = netcdf.inqVarID(ncid,'Times');
 Times_SoilEm = netcdf.getVar(ncid,varid);
 Times_SoilEm = Times_SoilEm';
 
 %there is one more time in the master time file than in the kz input file
 [ntimes ~] = size(Times);
 
 %if the initial concentraiton time is not equal to the master time file
 %initial time, exit with an error message
 if Times(1:ntimes,:) ~= Times_SoilEm
   error_msg = ['Times Soil_emi_rates.nc are not the same as in the master times file master_time_lev.nc.'];
   return
 end
 
%  %get the Box hights from the initial concentration file
%  varid      = netcdf.inqVarID(ncid,'BOX_WALL');
%  BOX_WALL_Kz = netcdf.getVar(ncid,varid);
%  
%  %if the model levels are different - then  send an error message
%  if BOX_WALL_Kz ~= BOX_WALL 
%    error_msg = ['The model levels in the master initialization file master_time_lev.nc are different from the Kz.nc file.'];
%    return
%  end
 
 %-------------------------  Read Soil Emission file -------------------------------------
 
 varid = netcdf.inqVarID(ncid,'NO');
 NO_SoilEm(:,:) = netcdf.getVar(ncid,varid);

% Convert soil emissions from mol m-2 s-1 to molec cm-2 s-1
% Divide by the lowest box level and convert from meters to centimeters
 Avogadro = 6.02*10^(23);
 Convert_cm = 10^(6);
 
 NO_SoilEm(:,:) = (NO_SoilEm(:,:)*Avogadro)/(Convert_cm*BOX_WALL(1));
 
 netcdf.close(ncid)

end
