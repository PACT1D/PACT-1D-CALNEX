function [Eff_Dep_vel_t] = online_depo_vel(Eff_Dep_vel_t)

global GStruct TIME

HONO_ind = get_ind('HONO');
NO2_ind  = get_ind('NO2');
J_NO2    = jrates_name('J_NO2',TIME,GStruct);

% temp = Eff_Dep_vel_t(NO2_ind) + Eff_Dep_vel_t(NO2_ind)*6e-5*J_NO2^3/((7.e-3)^3);

temp = Eff_Dep_vel_t(NO2_ind)*(2e-5 + 6e-5*(J_NO2^3/((7.e-3)^3)))/2e-5;

Eff_Dep_vel_t(NO2_ind) = temp;
 

end

