function  [spec,total_loss_to_ground,surface_source_HONO] = surface_source_hono(spec,...
    dt, BOX_WALL_cm,depo_rate, total_loss_to_ground, soil_emi_NO, NVAR)

% calculate a surface emissions source, to be customized based on your case, here an example for I2 emissions from the ocean based on ozone concentrations 

%global variable
global GStruct TIME

%set the new concentrations equal to the old concentrations
spec_before_surfSource = spec;

% set up array to save surface source for this time step

total_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed
dark_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed
photEnh_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed
HNO3phot_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed
soil_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed
acidDisp_surf_source_t=zeros(NVAR,1); %temp array for surface source, this is summed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%HONO surface sources - night and day
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%source setup, emit into level 1

HONO_ind = get_ind('HONO');
NO2_ind  = get_ind('NO2');
HNO3_ind  = get_ind('HNO3');
HNO4_ind  = get_ind('HNO4');

J_NO2    = jrates_name('J_NO2',TIME,GStruct);
J_HNO3   = jrates_name('J_HNO3',TIME,GStruct);

level1 = 1;      %Model level to put a portion of the emissions

%define dT/dZ scaling factor (s/cm) - used to distribute emissions within
%specified level for this timestep

facLev1=double(dt)/BOX_WALL_cm(level1);

%define day/night ratio

%day_night_ratio=(6e-5*J_NO2^3/((7.e-3)^3))/(6e-5*J_NO2^3/((7.e-3)^3)+2e-5);

%----------Daytime formation------------------------------

%%% Photoenhanced NO2 conversion to HONO %%%
% Based on parameterization by Wong et al, 2013
% Avg noontime J_NO2 for 4 day period (May 26-30) is 7e-3
% NO2 max uptake coefficient at noon is 6e-5 (Wong et al, 2013 value was 6e-5)
% NO2 uptake coefficient in model input is 2e-5

avg_noon_JNO2 = 7.e-3;
max_NO2_upt = 6.e-5;
NO2_upt = 1.e-5;

%define day/night ratio
day_night_ratio=(max_NO2_upt*J_NO2^3/((avg_noon_JNO2)^3))/(max_NO2_upt*J_NO2^3/((avg_noon_JNO2)^3)+NO2_upt);

total_surf_source_t(HONO_ind,level1) = 1*day_night_ratio*depo_rate(NO2_ind)*facLev1+total_surf_source_t(HONO_ind,level1);
photEnh_surf_source_t(HONO_ind,level1) = 1*day_night_ratio*depo_rate(NO2_ind)*facLev1;

%%% Surface HNO3 photolysis %%%
% HNO3(ads) = 0.5 HONO(ads) + 0.5 NO2(ads)      (from Sarwar et al, 2008)
% All HONO(ads) and NO2(ads) formed is emitted to lowest box
% Surface HNO3 phot rate is 45x J_HNO3 (Zhou, 2003; Karamchandani, 2015)

J_HNO3_surf = 45*J_HNO3;

total_surf_source_t(HONO_ind,level1) = total_surf_source_t(HONO_ind,level1) + 0.5*J_HNO3_surf*total_loss_to_ground(HNO3_ind)*facLev1;
total_surf_source_t(NO2_ind,level1) = total_surf_source_t(NO2_ind,level1) + 0.5*J_HNO3_surf*total_loss_to_ground(HNO3_ind)*facLev1;

HNO3phot_surf_source_t(HONO_ind,level1) = 0.5*J_HNO3_surf*total_loss_to_ground(HNO3_ind)*facLev1;

% total_loss_to_ground(HNO3_ind) = total_loss_to_ground(HNO3_ind) - J_HNO3_surf*total_loss_to_ground(HNO3_ind)*double(dt);


%%% HONO emissions from soil %%%
% Set HONO soil emissions equal to NO soil emissions
% E_NO_soil = 6.04e9;     %molec cm-2 s-1, based on POET monthly avg for Pasadena in May
% E_NO_soil = 4.01e10;     %molec cm-2 s-1, based on May 2015 data
E_NO_soil = soil_emi_NO*BOX_WALL_cm(1);       %diurnal May 2012 data from ECCAD, molec cm-2 s-1
E_HONO_soil = E_NO_soil;

total_surf_source_t(HONO_ind,level1) = total_surf_source_t(HONO_ind,level1) + E_HONO_soil*facLev1;
soil_surf_source_t(HONO_ind,level1) = E_HONO_soil*facLev1;


%%% Acid displacement %%%
%Assume nitrite on surface comes from deposited HONO and HNO4. If there is
%at least a monolayer of nitrite (1e13 molec cm-2), then every deposited
%HNO3 will displace nitrite as HONO to the atmosphere. 

surf_nitrite_conc = total_loss_to_ground(HONO_ind) + total_loss_to_ground(HNO4_ind);
scaleFac = total_loss_to_ground(HONO_ind)/surf_nitrite_conc;
DispEff = 0.09;   %displacement efficiency 

if surf_nitrite_conc >= 1e13
    total_surf_source_t(HONO_ind,level1) = total_surf_source_t(HONO_ind,level1) + depo_rate(HNO3_ind)*facLev1*DispEff;
    acidDisp_surf_source_t(HONO_ind,level1) = depo_rate(HNO3_ind)*facLev1*DispEff;
%     total_loss_to_ground(HONO_ind) = total_loss_to_ground(HONO_ind) - depo_rate(HNO3_ind)*double(dt);
else
    total_surf_source_t(HONO_ind,level1) = total_surf_source_t(HONO_ind,level1) + depo_rate(HNO3_ind)*(surf_nitrite_conc/1e13)*facLev1*DispEff;
    acidDisp_surf_source_t(HONO_ind,level1) = depo_rate(HNO3_ind)*(surf_nitrite_conc/1e13)*facLev1*DispEff;
%     total_loss_to_ground(HONO_ind) = total_loss_to_ground(HONO_ind) - depo_rate(HNO3_ind)*(surf_nitrite_conc/1e13)*double(dt);
end

%----------Dark formation------------------------------
% Based on parameterization by Wong et al, 2013
% Avg noontime J_NO2 for 4 day period (May 26-30) is 7e-3
% NO2 max uptake coefficient at noon is 6e-5 (Wong et al, 2013 value was 6e-5)
% NO2 uptake coefficient in model input is 2e-5

%HONO formation at night:
total_surf_source_t(HONO_ind,level1) = 1*0.5*(1-day_night_ratio)*depo_rate(NO2_ind)*facLev1 + total_surf_source_t(HONO_ind,level1);
dark_surf_source_t(HONO_ind,level1) = 1*0.5*(1-day_night_ratio)*depo_rate(NO2_ind)*facLev1;

% spec_surface_source(HONO_ind,level1) = 1*0.5*depo_rate(NO2_ind)*facLev1 + spec_surface_source(HONO_ind,level1);
% spec_surface_source_dark(HONO_ind,level1) = 1*0.5*depo_rate(NO2_ind)*facLev1;

% total_loss_to_ground(HNO3_ind) = total_loss_to_ground(HNO3_ind) + 1*0.5*(1-day_night_ratio)*depo_rate(NO2_ind)*double(dt);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %END HONO surface sources
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update spec_new %

spec(HONO_ind,level1) = spec_before_surfSource(HONO_ind,level1)+total_surf_source_t(HONO_ind,level1);
spec(NO2_ind,level1) = spec_before_surfSource(NO2_ind,level1)+total_surf_source_t(NO2_ind,level1);

% Update total_loss_to_ground for HONO and NO2

total_loss_to_ground(HONO_ind)=total_loss_to_ground(HONO_ind)-acidDisp_surf_source_t(HONO_ind,level1)*scaleFac*BOX_WALL_cm(level1);
total_loss_to_ground(NO2_ind)=total_loss_to_ground(NO2_ind)-photEnh_surf_source_t(HONO_ind,level1)*BOX_WALL_cm(level1)...
    -2*dark_surf_source_t(HONO_ind,level1)*BOX_WALL_cm(level1);
total_loss_to_ground(HNO3_ind) = total_loss_to_ground(HNO3_ind)-2*HNO3phot_surf_source_t(HONO_ind,level1)*BOX_WALL_cm(level1)...
    +dark_surf_source_t(HONO_ind,level1)*BOX_WALL_cm(level1);
total_loss_to_ground(HNO4_ind) = total_loss_to_ground(HNO4_ind)-acidDisp_surf_source_t(HONO_ind,level1)*(1-scaleFac)*BOX_WALL_cm(level1);

% calculate the surface source rate - in molec cm-3 s-1

surface_source_HONO.total_surf_source_t = total_surf_source_t(HONO_ind)/double(dt);
surface_source_HONO.dark_surf_source_t = dark_surf_source_t(HONO_ind)/double(dt);
surface_source_HONO.photEnh_surf_source_t = photEnh_surf_source_t(HONO_ind)/double(dt);
surface_source_HONO.HNO3phot_surf_source_t = HNO3phot_surf_source_t(HONO_ind)/double(dt);
surface_source_HONO.soil_surf_source_t = soil_surf_source_t(HONO_ind)/double(dt);
surface_source_HONO.acidDisp_surf_source_t = acidDisp_surf_source_t(HONO_ind)/double(dt);

end
