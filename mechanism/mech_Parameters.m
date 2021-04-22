% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                                                                  
% Parameter Definition File                                        
%                                                                  
% Generated by KPP-2.2.3 symbolic chemistry Kinetics PreProcessor  
%       (http://www.cs.vt.edu/~asandu/Software/KPP)                
% KPP is distributed under GPL, the general public licence         
%       (http://www.gnu.org/copyleft/gpl.html)                     
% (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa           
% (C) 1997-2005, A. Sandu, Michigan Tech, Virginia Tech            
%     With important contributions from:                           
%        M. Damian, Villanova University, USA                      
%        R. Sander, Max-Planck Institute for Chemistry, Mainz, Germany
%                                                                  
% File                 : mech_Parameters.m                         
% Time                 : Thu Mar 11 21:32:12 2021                  
% Working directory    : /home/sahmed/mechanism                    
% Equation file        : mech.kpp                                  
% Output root filename : mech                                      
%                                                                  
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




% NSPEC - Number of chemical species                               
 global NSPEC; NSPEC = 149; 
% NVAR - Number of Variable species                                
 global NVAR; NVAR = 143; 
% NVARACT - Number of Active species                               
 global NVARACT; NVARACT = 130; 
% NFIX - Number of Fixed species                                   
 global NFIX; NFIX = 6; 
% NREACT - Number of reactions                                     
 global NREACT; NREACT = 461; 
% NVARST - Starting of variables in conc. vect.                    
 global NVARST; NVARST = 1; 
% NFIXST - Starting of fixed in conc. vect.                        
 global NFIXST; NFIXST = 144; 
% NONZERO - Number of nonzero entries in Jacobian                  
 global NONZERO; NONZERO = 1815; 
% LU_NONZERO - Number of nonzero entries in LU factoriz. of Jacobian
 global LU_NONZERO; LU_NONZERO = 2215; 
% CNVAR - (NVAR+1) Number of elements in compressed row format     
 global CNVAR; CNVAR = 144; 
% NLOOKAT - Number of species to look at                           
 global NLOOKAT; NLOOKAT = 149; 
% NMONITOR - Number of species to monitor                          
 global NMONITOR; NMONITOR = 0; 
% NMASS - Number of atoms to check mass balance                    
 global NMASS; NMASS = 1; 

% Index declaration for variable species in C and VAR              
%   VAR(ind_spc) = C(ind_spc)                                      

 global ind_DUMMY; ind_DUMMY = 1; 
 global ind_NOCl; ind_NOCl = 2; 
 global ind_CH3Cl; ind_CH3Cl = 3; 
 global ind_CO2; ind_CO2 = 4; 
 global ind_SULF; ind_SULF = 5; 
 global ind_ClONO; ind_ClONO = 6; 
 global ind_CH3; ind_CH3 = 7; 
 global ind_HCO; ind_HCO = 8; 
 global ind_ClOO; ind_ClOO = 9; 
 global ind_CCl3; ind_CCl3 = 10; 
 global ind_C2H5O; ind_C2H5O = 11; 
 global ind_C2H4O2; ind_C2H4O2 = 12; 
 global ind_CH2CCl3; ind_CH2CCl3 = 13; 
 global ind_CH3SCH2; ind_CH3SCH2 = 14; 
 global ind_H; ind_H = 15; 
 global ind_CH3CCl2; ind_CH3CCl2 = 16; 
 global ind_CHCl3; ind_CHCl3 = 17; 
 global ind_SO2; ind_SO2 = 18; 
 global ind_CH3CCl3; ind_CH3CCl3 = 19; 
 global ind_CH3SCH3; ind_CH3SCH3 = 20; 
 global ind_ISHP; ind_ISHP = 21; 
 global ind_C2H5O2; ind_C2H5O2 = 22; 
 global ind_CCl4; ind_CCl4 = 23; 
 global ind_NO3Aer; ind_NO3Aer = 24; 
 global ind_HC8; ind_HC8 = 25; 
 global ind_ACE; ind_ACE = 26; 
 global ind_HC5; ind_HC5 = 27; 
 global ind_MAHP; ind_MAHP = 28; 
 global ind_NALD; ind_NALD = 29; 
 global ind_O1D; ind_O1D = 30; 
 global ind_ETEG; ind_ETEG = 31; 
 global ind_HNO4; ind_HNO4 = 32; 
 global ind_HONO; ind_HONO = 33; 
 global ind_BAL2; ind_BAL2 = 34; 
 global ind_TR2; ind_TR2 = 35; 
 global ind_XYO; ind_XYO = 36; 
 global ind_XYM; ind_XYM = 37; 
 global ind_XYP; ind_XYP = 38; 
 global ind_MCT; ind_MCT = 39; 
 global ind_XY2; ind_XY2 = 40; 
 global ind_XYO2; ind_XYO2 = 41; 
 global ind_PPN; ind_PPN = 42; 
 global ind_Cl2; ind_Cl2 = 43; 
 global ind_MPAN; ind_MPAN = 44; 
 global ind_ETH; ind_ETH = 45; 
 global ind_EOH; ind_EOH = 46; 
 global ind_ClNO2; ind_ClNO2 = 47; 
 global ind_HC3; ind_HC3 = 48; 
 global ind_TOL; ind_TOL = 49; 
 global ind_N2O5; ind_N2O5 = 50; 
 global ind_OP1; ind_OP1 = 51; 
 global ind_PHEN; ind_PHEN = 52; 
 global ind_ISON; ind_ISON = 53; 
 global ind_ORA1; ind_ORA1 = 54; 
 global ind_CHO; ind_CHO = 55; 
 global ind_PAA; ind_PAA = 56; 
 global ind_OClO; ind_OClO = 57; 
 global ind_ClETEP; ind_ClETEP = 58; 
 global ind_API; ind_API = 59; 
 global ind_PAN; ind_PAN = 60; 
 global ind_H2O2; ind_H2O2 = 61; 
 global ind_ClONO2; ind_ClONO2 = 62; 
 global ind_MCTO; ind_MCTO = 63; 
 global ind_BAL1; ind_BAL1 = 64; 
 global ind_HOCl; ind_HOCl = 65; 
 global ind_LIM; ind_LIM = 66; 
 global ind_BALP; ind_BALP = 67; 
 global ind_DIEN; ind_DIEN = 68; 
 global ind_CO; ind_CO = 69; 
 global ind_EPX; ind_EPX = 70; 
 global ind_ISO; ind_ISO = 71; 
 global ind_ETE; ind_ETE = 72; 
 global ind_TLP1; ind_TLP1 = 73; 
 global ind_XYL1; ind_XYL1 = 74; 
 global ind_HNO3; ind_HNO3 = 75; 
 global ind_OLT; ind_OLT = 76; 
 global ind_MEK; ind_MEK = 77; 
 global ind_ACT; ind_ACT = 78; 
 global ind_HKET; ind_HKET = 79; 
 global ind_O3P; ind_O3P = 80; 
 global ind_ClO; ind_ClO = 81; 
 global ind_ORAP; ind_ORAP = 82; 
 global ind_ROH; ind_ROH = 83; 
 global ind_BEN; ind_BEN = 84; 
 global ind_KET; ind_KET = 85; 
 global ind_XYOP; ind_XYOP = 86; 
 global ind_ADCN; ind_ADCN = 87; 
 global ind_BALD; ind_BALD = 88; 
 global ind_MVK; ind_MVK = 89; 
 global ind_PER2; ind_PER2 = 90; 
 global ind_BENP; ind_BENP = 91; 
 global ind_ETEP; ind_ETEP = 92; 
 global ind_TOLP; ind_TOLP = 93; 
 global ind_PER1; ind_PER1 = 94; 
 global ind_MCP; ind_MCP = 95; 
 global ind_ADDC; ind_ADDC = 96; 
 global ind_MCTP; ind_MCTP = 97; 
 global ind_GLY; ind_GLY = 98; 
 global ind_HC8P; ind_HC8P = 99; 
 global ind_XYLP; ind_XYLP = 100; 
 global ind_CSL; ind_CSL = 101; 
 global ind_UALP; ind_UALP = 102; 
 global ind_LIMP; ind_LIMP = 103; 
 global ind_MOH; ind_MOH = 104; 
 global ind_DCB3; ind_DCB3 = 105; 
 global ind_MGLY; ind_MGLY = 106; 
 global ind_MVKP; ind_MVKP = 107; 
 global ind_APIP; ind_APIP = 108; 
 global ind_MACR; ind_MACR = 109; 
 global ind_ISOP; ind_ISOP = 110; 
 global ind_MACP; ind_MACP = 111; 
 global ind_OLNN; ind_OLNN = 112; 
 global ind_UALD; ind_UALD = 113; 
 global ind_ONIT; ind_ONIT = 114; 
 global ind_OLTP; ind_OLTP = 115; 
 global ind_DCB2; ind_DCB2 = 116; 
 global ind_RCO3; ind_RCO3 = 117; 
 global ind_OLI; ind_OLI = 118; 
 global ind_OLIP; ind_OLIP = 119; 
 global ind_OLND; ind_OLND = 120; 
 global ind_HCl; ind_HCl = 121; 
 global ind_HCHO; ind_HCHO = 122; 
 global ind_ACTP; ind_ACTP = 123; 
 global ind_ACD; ind_ACD = 124; 
 global ind_HC5P; ind_HC5P = 125; 
 global ind_MEKP; ind_MEKP = 126; 
 global ind_OP2; ind_OP2 = 127; 
 global ind_DCB1; ind_DCB1 = 128; 
 global ind_ALD; ind_ALD = 129; 
 global ind_HO; ind_HO = 130; 
 global ind_ACO3; ind_ACO3 = 131; 
 global ind_NO3; ind_NO3 = 132; 
 global ind_XO2; ind_XO2 = 133; 
 global ind_ORA2; ind_ORA2 = 134; 
 global ind_ETHP; ind_ETHP = 135; 
 global ind_KETP; ind_KETP = 136; 
 global ind_HO2; ind_HO2 = 137; 
 global ind_NO2; ind_NO2 = 138; 
 global ind_MO2; ind_MO2 = 139; 
 global ind_NO; ind_NO = 140; 
 global ind_Cl; ind_Cl = 141; 
 global ind_HC3P; ind_HC3P = 142; 
 global ind_O3; ind_O3 = 143; 

% Index declaration for fixed species in C                         
%   C(ind_spc)                                                     

 global ind_O2; ind_O2 = 144; 
 global ind_AIR; ind_AIR = 145; 
 global ind_H2; ind_H2 = 146; 
 global ind_CH4; ind_CH4 = 147; 
 global ind_N2; ind_N2 = 148; 
 global ind_H2O; ind_H2O = 149; 

% Index declaration for fixed species in FIX                       
%    FIX(indf_spc) = C(ind_spc) = C(NVAR+indf_spc)                 

 global indf_O2; indf_O2 = 1; 
 global indf_AIR; indf_AIR = 2; 
 global indf_H2; indf_H2 = 3; 
 global indf_CH4; indf_CH4 = 4; 
 global indf_N2; indf_N2 = 5; 
 global indf_H2O; indf_H2O = 6; 