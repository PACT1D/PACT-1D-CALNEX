% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                                                                  
% Initialize - function to initialize concentrations               
%   Arguments :                                                    
%                                                                  
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                                                                  
% Generated by KPP - symbolic chemistry Kinetics PreProcessor      
%     KPP is developed at CGRER labs University of Iowa by         
%     Valeriu Damian & Adrian Sandu                                
%                                                                  
% File                 : mech_Initialize.m                         
% Time                 : Sun Jan 21 23:02:40 4461725               
% Working directory    : /home/sahmed/mechanism                    
% Equation file        : mech.kpp                                  
% Output root filename : mech                                      
%                                                                  
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function   mech_Initialize ( )

global CFACTOR VAR FIX NVAR NFIX
  
  

   CFACTOR = 1.000000e+00 ;

   x = (0.)*CFACTOR ;
   for i = 1:NVAR
     VAR(i) = x ;
   end

   x = (0.)*CFACTOR ;
   for i = 1:NFIX
     FIX(i) = x ;
   end

% constant rate coefficients                                       
% END constant rate coefficients                                   

% INLINED initializations                                          

% End INLINED initializations                                      

   VAR = VAR(:);
   FIX = FIX(:);

      
return

% End of Initialize function                                       
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


