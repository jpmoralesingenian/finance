clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
[dates,open,high,low,close,volume,close2]= textread("NYSETO.csv","%s %f %f %f %f %f %f",'delimiter',',','headerlines',1);
dates2 = zeros(size(dates,1),1);
turnover2 = zeros(size(dates,1),1);
turnover = volume./close;
fprintf('Parsing dates...\n');
number_of_periods=size(dates,1);
for a = 1:number_of_periods
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	dates2(a)=year*100+month;
	
% Yearly rolling average
	if(a<number_of_periods-54)
		turnover2(a) = mean(turnover(a:a+53));
	endif
endfor
% 
% Filter the odd things out
%
value = 1977*100+2;
filtered = (dates2(:)>value);
matrix = horzcat(dates2(filtered),turnover2(filtered));
fprintf('Writing file...\n');
csvwrite('NYSETO_READY.csv',matrix);
