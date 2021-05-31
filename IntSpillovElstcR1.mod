% My model 

% 1. Declare endogenous variables:
var 
         % Country H                                      Country F
chh $C_{H}$ (long_name='Consumption H') chf kkh dh yh invh Rh a1 tbh ca cay            cfh cff kkf df yf invf Rf a2          ph ;
                                                   

% $C_{H}$    (long_name='Consumption H')

% 2. Declare exogenous variables (i.e. shocks):
varexo e1 e2;


% 3. Declare parameters:
parameters bet gamm thet mu AA alph delt psi dbar rr  omeg11 omeg22;


% 4. Specify parameter values:
alph = 0.32       ;
delt = 0.1        ;
gamm  = 2         ;
AA = 1            ;
thet = 0.65       ;
mu = 0.65         ;

rr = 0.022        ;
bet  = 1/(1+rr)   ;


omeg11 = 0.806    ;
%omeg12 = 0.008   ;
omeg22 = 0.806    ;
%omeg21 = 0.008   ;

psi = 0.001542     ;
dbar = 0.3984     ;




% 5. Specify the model equations:
model;

					%%%%%%%% In levels %%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%%%%% Country H %%%%%
%%%%%%%%%%%%%%%%%%%%%

% (vi) Law of motion of TFP
a1 = omeg11 * a1(-1) + e1;

% (ix) Interest rate
Rh = 1 + rr + psi * ( exp(dh-dbar) -1 );

% (iv) Resource constraint
ph * chh + chf + ph * kkh + dh(-1) * Rh(-1) * ph = ph * yh + ph * kkh(-1) * (1- delt) + dh * ph;

% (iii) Not-Euler C H-F
chh * ph = thet / (1-thet) * chf;

% (i) Euler C-H -> K
(chh^(thet) * chf^(1-thet))^(-gamm) * thet * (chf/chh)^(1-thet) = bet * (chh(+1)^(thet) * chf(+1)^(1-thet))^(-gamm) * thet * (chf(+1)/chh(+1))^(1-thet) * (AA*exp(a1)*alph*kkh^(alph-1)+1-delt);

% (ii) Euker C-H -> R
(chh^(thet) * chf^(1-thet))^(-gamm) * thet * (chf/chh)^(1-thet) = bet * Rh * (chh(+1)^(thet) * chf(+1)^(1-thet))^(-gamm) * thet * (chf(+1)/chh(+1))^(1-thet);

% (v) Prod Function
yh = AA * exp(a1) * kkh(-1)^alph;

% (viii) Investment
invh = kkh - kkh(-1) * (1-delt);

% 
tbh = cfh * ph - chf ;
% (x) Current Account to GDP

ca = tbh - dh * Rh ; 
cay = ca / yh ;


%%%%%%%%%%%%%%%%%%%%%
%%%%% Country F %%%%%
%%%%%%%%%%%%%%%%%%%%%

% (vi) Law of motion of TFP
a2 = omeg22 * a2(-1) + e2;

% (ix) Interest rate
Rf = 1 + rr + psi * ( exp(df-dbar) -1 );

% (iv) Resource constraint
ph * cfh +  cff + kkf + df(-1) * Rf(-1) = yf + kkf(-1) * (1- delt) + df;

% (iii) Not-Euler C H-F
mu / (1-mu) * cff = cfh * ph;

% (i) Euler C-F -> K
(cff^(mu) * cfh^(1-mu))^(-gamm) * mu * (cfh/cff)^(1-mu) = bet * (cff(+1)^(mu) * cfh(+1)^(1-mu))^(-gamm) * mu * (cfh(+1)/cff(+1))^(1-mu) * (AA*exp(a2)*alph*kkf^(alph-1)+1-delt);

% (ii) Euker C-F -> R
(cff^(mu) * cfh^(1-mu))^(-gamm) * mu * (cfh/cff)^(1-mu) = bet * Rf * (cff(+1)^(mu) * cfh(+1)^(1-mu))^(-gamm) * mu * (cfh(+1)/cff(+1))^(1-mu);

% (v) Prod Function
yf = AA * exp(a2) * kkf(-1)^alph;

% (viii) Investment
invf = kkf - kkf(-1) * (1-delt);

%%%%% Market clearing Good H %%%%%
chh + cfh + invh  = yh;
    
end;                            



% 6. Initial values:
initval;

% Country H
kkh = 4.1292   ;
invh = 0.4129  ;
yh = 1.5743    ;
chh = 0.7492   ;
chf = 0.4034   ;
dh = 0.3984    ;
a1 = 0         ;
e1=0           ;
tbh= 0         ;
cay = 0        ;


% Country F

kkf = 4.1292   ;
invf = 0.4129  ;
yf = 1.5743    ;
cfh = 0.4034   ;
cff = 0.7492   ;
df = 0.3984    ;
a2 = 0         ;
e2=0           ;
% Prices
ph = 1;
Rh = 1.022 ;
Rf = 1.022 ;
end;


resid(1);
steady; 
check;

% 7. Specify variance of shocks:
shocks;
var e1; stderr 0.0082;
var e2; stderr 0.0082;
end;


% 8. Finally, solve model:
stoch_simul(order=2,irf=100,periods=1000);		