addpath 'C:\dynare\4.6.3\matlab'



clc;            % Clears command window
clear;          % Clears things you may have from other projects
close all;       % Close all open figures in Matlab.

dynare IntSpillovElstcR1.mod     
                                       

%% Plot simulated series

period = zeros(100,1);
for i=1:1:100
    period(i)=i;
end

%% Consumption
figure('Color','white')
subplot(1,2,1)
plot(period(1:20), oo_.irfs.chh_e1(1:20), period(1:20), oo_.irfs.chf_e1(1:20))
legend('Domestic','Foreign' )
title('Consumption')
xlabel('Period')
ylabel('')

subplot(1,2,2)
plot(period(1:20), oo_.irfs.ph_e1(1:20))
title('Terms of Trade')
xlabel('Period')
ylabel('')

%% TFP, Output, investment, capital
figure('Color','white')
subplot(1,4,1)
plot(period(1:20), oo_.irfs.a1_e1(1:20))
title('TFP')
xlabel('Period')
ylabel('')

subplot(1,4,2)
plot(period(1:20), oo_.irfs.invh_e1(1:20))
title('Investment')
xlabel('Period')
ylabel('')

subplot(1,4,3)
plot(period(1:20), oo_.irfs.kkh_e1(1:20))
title('Capital')
xlabel('Period')
ylabel('')

subplot(1,4,4)
plot(period(1:20), oo_.irfs.yh_e1(1:20))
title('Output')
xlabel('Period')
ylabel('')


%% Trade Balance, Debt, Risk Premium
figure('Color','white')
subplot(3,1,1)
plot(period, oo_.irfs.tbh_e1)
title('Trade Balance')
xlabel('Period')
ylabel('')

subplot(3,1,2)
plot(period, oo_.irfs.dh_e1)
title('Foreign Debt')
xlabel('Period')
ylabel('')

subplot(3,1,3)
plot(period, oo_.irfs.Rh_e1)
title('Risk Premium')
xlabel('Period')
ylabel('')

