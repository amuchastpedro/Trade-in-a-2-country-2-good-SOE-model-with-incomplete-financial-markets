%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Steady State %%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

%% Parameters from literature
% Schmitt-Grohe and Uribe follow Mendoza: Canada, time unit: year
delt = 0.1     ;  % Schmitt-Grohe and Uribe
alph = 0.32    ;  % Schmitt-Grohe and Uribe
AA = 1         ;
thet =  0.65   ;  % Arbitrary
gamma = 2      ;  % Schmitt-Grohe and Uribe
%% Moments from data
rr = 0.022      ;  % Treasury bills 1996 - 2017
Mdebt = 0.2531  ;  % International Private Debt
bet = 1/(1+rr)  ;


%% My-Model moments
kss = (AA*alph / (1/bet -1 + delt))^(1/(1-alph))   ; 
iss = delt * kss                                   ;
yss = AA * kss^alph                                ;
dss = yss * Mdebt                                  ;
chss = (yss - kss * delt - dss * rr ) * thet       ;
cfss = chss * (1-thet) / thet                      ;


%% Steady State of Country H
SteStaH = zeros(6,1);
SteStaH(1,1) = kss;
SteStaH(2,1) = iss;
SteStaH(3,1) = yss;
SteStaH(4,1) = chss;
SteStaH(5,1) = cfss;
SteStaH(6,1) = dss;

LnSteStaH = log(SteStaH) ; 

%% 




















%% Steady State of Country F

%kssF = (AA*alph / (1/bet -1 + delt))^(1/(1-alph)) ; 
%issF = delt * kssF ;
%yssF = AA * kssF^alph ;

%chssF = (yssF - kssF * delt - dssF * rr ) * (1-thet) ;
%cfssF = chssF *  thetF / (1-thetF) ;



%SteStaF = zeros(6,1);
%SteStaF(1,1) = kssF;
%SteStaF(2,1) = issF;
%SteStaF(3,1) = yssF;
%SteStaF(4,1) = chssF;
%SteStaF(5,1) = cfssF;
%SteStaF(6,1) = dssF;

%LnSteStaF = log(SteStaF) ; 

%tbh = chssF - cfss; 
%tbf = cfss - chssF;
%CHECK = zeros(6,1);
%CHECK(:,1) = SteStaH;
%CHECK(:,2) = SteStaF;