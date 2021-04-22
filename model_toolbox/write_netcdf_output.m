function write_netcdf_output(model_path,nlev,t,spec_conc,spec_conc_fixed,temperature, press, rh, rates,rate_constants,VT,depo, addemissions, surface_source_emissions,...
            total_loss_to_ground, emissions, add_surface_source_HONO, Times, DateStrLen)

%add model parameters
mech_Parameters;

%get model species names for output writing
spec_names = get_spec_names(model_path);

%let the user know the concentrations are being written
%disp(['       writing species concentrations and rates']);

%----------------------- write concentrations to netcdf file --------------------
%write netcdf file with concentration values
ncid = netcdf.open([model_path '/output/spec.nc'], 'WRITE');

%write date
varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add add variable concentraiton specied
for j=1:NVAR
  %size(spec_conc)
  %j
  %disp(spec_names{j});
  ind = eval(['ind_' spec_names{j}]);
  varid = netcdf.inqVarID(ncid,spec_names{j});
  tmp = squeeze(squeeze(spec_conc(ind,:,t+1)));

  netcdf.putVar(ncid,varid,[0,t],[nlev,1],tmp);
end
for j=NVAR+1:NSPEC
  ind = eval(['indf_' spec_names{j}]);
  varid = netcdf.inqVarID(ncid,spec_names{j});
  tmp = squeeze(spec_conc_fixed(ind,:,t));
  netcdf.putVar(ncid,varid,[0,t],[nlev,1],tmp);
end

%add temperature, pressure, RH to file
varid = netcdf.inqVarID(ncid,'temp');
netcdf.putVar(ncid,varid,[0,t],[nlev,1],temperature(:,t));
varid = netcdf.inqVarID(ncid,'press');
netcdf.putVar(ncid,varid,[0,t],[nlev,1],press(:,t));
varid = netcdf.inqVarID(ncid,'rh');
netcdf.putVar(ncid,varid,[0,t],[nlev,1],rh(:,t));

netcdf.close(ncid)
clearvars tmp;

%----------------------- write reaction rates to netcdf file --------------------
%write netcdf file with reaction rate values
ncid = netcdf.open([model_path '/output/rxn_rates.nc'], 'WRITE');

%write date
varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add add concentrations
for j=1:NREACT
  str = get_rxn_names(j);
  varid = netcdf.inqVarID(ncid,str);
  tmp = squeeze(rates(j,:,t+1));
  netcdf.putVar(ncid,varid,[0,t],[nlev,1],tmp);
%  clearvars tmp; %JPS removed 8/11/17
end

netcdf.close(ncid)

%----------------------- write reaction rate constants to netcdf file --------------------
%write netcdf file with reaction rate values
ncid = netcdf.open([model_path '/output/rxn_rate_constants.nc'], 'WRITE');

%write date
varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add add concentrations
for j=1:NREACT
  str = get_rate_constant_names(j);
  varid = netcdf.inqVarID(ncid,str);
  tmp = squeeze(rate_constants(j,:,t+1));
  netcdf.putVar(ncid,varid,[0,t],[nlev, 1],tmp);
end

netcdf.close(ncid)

%-%---------------------- write vertical transport rates to netcdf file --------------------
ncid = netcdf.open([model_path '/output/vt_rates.nc'], 'WRITE');

%write date
varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add vertical transport rates
for j=1:NVAR
  %size(spec_conc)
  %j
  %disp(spec_names{j});
%  ind = get_ind(spec_names{j});        % replaced 8/11/17 JPS
   ind = eval(['ind_' spec_names{j}]);
  varid = netcdf.inqVarID(ncid,spec_names{j});
  tmp = squeeze(VT(ind,:,t+1));
  netcdf.putVar(ncid,varid,[0,t],[nlev,1],tmp);
end
clear tmp;
netcdf.close(ncid)

%----------------------- write deposition rates to netcdf file --------------------
ncid = netcdf.open([model_path '/output/depo_rates.nc'], 'WRITE');

%write date
varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add deposition rates
for j=1:NVAR
  %size(spec_conc)
  %j
  %disp(spec_names{j});
%  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
   ind = eval(['ind_' spec_names{j}]);
  varid = netcdf.inqVarID(ncid,spec_names{j});
  tmp = squeeze(depo(ind,t+1));
  %disp(min(depo(ind,:)));
  netcdf.putVar(ncid,varid,t,1,tmp);
end
netcdf.close(ncid)

%----------------------- write surface source emissions rates to netcdf file --------------------
ncid = netcdf.open([model_path '/output/surf_source.nc'], 'WRITE');

varid_timeStr = netcdf.inqVarID(ncid,'Times');
netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

if (add_surface_source_HONO == 1)
    %add surface source term
    j=get_ind('HONO');
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['total_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_total_surf_source(:,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);

    %add dark surface source term

    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['dark_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_dark_surf_source(:,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);

    %add photo-enhanced surface source term
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['photEnh_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_photEnh_surf_source(:,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);

    %add HNO3 photolysis surface source term
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['HNO3phot_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_HNO3phot_surf_source(:,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);

    %add soil emission surface source term
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['soil_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_soil_surf_source(:,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);

    %add acid displacement surface source term
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['acidDisp_source_' spec_names{j}]);
    tmp = squeeze(surface_source_emissions.HONO_acidDisp_surf_source(:,t+1)); 
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);
end

%add total loss to ground term
for j=1:NVAR
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
    ind = eval(['ind_' spec_names{j}]);
    varid = netcdf.inqVarID(ncid,['loss_' spec_names{j}]);
    tmp = squeeze(total_loss_to_ground(ind,t+1));
    %size(tmp)
    netcdf.putVar(ncid,varid,[t],[1],tmp);
end

netcdf.close(ncid)

%----------------------- write emissions  to netcdf file --------------------
if (addemissions==1)
    ncid = netcdf.open([model_path '/output/emissions.nc'], 'WRITE');

%write date
    varid_timeStr = netcdf.inqVarID(ncid,'Times');
    netcdf.putVar(ncid,varid_timeStr,[0,t],[DateStrLen,1],Times(t+1,:)');

%add surface source term
    for j=1:NVAR
    %size(spec_conc)
    %j
    %disp(spec_names{j});
    %  ind = get_ind(spec_names{j});        % Replaced 8/11/17 JPS
        ind = eval(['ind_' spec_names{j}]);
        varid = netcdf.inqVarID(ncid,['E_' spec_names{j}]);
        tmp = squeeze(emissions(ind,:,t+1));
        %size(tmp)
        netcdf.putVar(ncid,varid,[0,t],[nlev,1],tmp);
    end
netcdf.close(ncid)
end
