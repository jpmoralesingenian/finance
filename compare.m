%% The file RESULT.csv has the following columns:
%% date in the form yyyymm
%% SnP actual value
%% Predicted value with algo 1 
%% Predicted value with algo 2

%% We want to model "following" the advices of the mode in the following way: 
%% Start at period period_start
%% Buy 100 units and hold them, call the value of thet investment hold
%% If the value of snp is of more than delta% then buy of sell reduce% (rounded to the next integer) and pay commision% for the buy/ sale (as a percentage of value). 
%% Assume the money for commisions comes from somewhere else
%% End at period period_end
clear ; close all; clc
delta = 0.10;
reduce = 0.10;
fprintf('Loading data ...\n');

%% Load Data
raw_data = csvread('RESULT.csv');

period_start = 199703;
period_end = 201508;

dates = raw_data(:,1);
syp = raw_data(:,2);
predicted  = raw_data(:,3);

%% Put only the periods we want

filter1 = (dates(:)>=period_start);
filter2 = (dates(:)<=period_end);
filter = logical(filter1.*filter2);

dates = flipud(dates(filter));
syp = flipud(syp(filter));
predicted = flipud(predicted(filter));

money = zeros(size(dates));
stock = zeros(size(dates));
actions = zeros(size(dates));
for a=1:size(dates,1)
	if(a==1)
% We are starting. Buy 100 stock
		money(a) = -100*syp(a);
		stock(a) = 100;
	else
%		fprintf("Period: %d predict %d and it is really %d ",dates(a),predicted(a),syp(a));
		if(predicted(a)>syp(a)*(1+delta)) 
			% We believe if will be higher. Buy!!
			stock_count = ceil(stock(a-1)*reduce);
			% Alway buy at least one
			if(stock_count<1) 
				stock_count=1;
			endif
			stock(a) = stock(a-1)+ stock_count;
			money(a) = money(a-1)-stock_count*syp(a);
%			fprintf(" Buying %d stocks at a value of %d. Now I have $ %d and %d stock\n",stock_count,syp(a), money(a),stock(a));
		elseif(predicted(a)<syp(a)*(1-delta)) 
			% We believe it to be lower, sell!
			stock_count = ceil(stock(a-1)*reduce);
			stock(a) = stock(a-1)- stock_count;
			money(a) = money(a-1)+stock_count*syp(a);
			actions(a) = -1;
%			fprintf(" Selling %d stocks at a value of %d. Now I have $ %d and %d stock\n",stock_count,syp(a),money(a),stock(a));
		else 
			%Keep!!!	
			stock(a) = stock(a-1);
			money(a) = money(a-1);
			actions(a) =1;
%			fprintf(" Maintaining. I'll keep $ %d and %d stock\n",money(a),stock(a));
		endif
	endif
endfor
periods = size(dates,1);
finalmoney =  money(periods)+stock(periods)*syp(periods);
buynhold = syp(periods)*100-syp(1)*100;
fprintf("Endgame: At the beginning I used up %d money, at the end (after selling my stock) I had %d buying and holding I would have %d\n",100*syp(1),finalmoney,buynhold);
final = horzcat(dates,stock,money,actions);
csvwrite('COMPARE.csv',final);
