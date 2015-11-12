clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
[dates,indexvalue,dividend,earnings,cpi,interest,price,dividend2,earnings2,pe] = textread("YALE-SPCOMP.csv","%s %f %f %f %f %f %f %f %f %f",'delimiter',',','headerlines',1);
dates2 = zeros(size(dates,1),1);
indexvalue2 = zeros(size(indexvalue,1),1);
fprintf('Parsing dates...\n');
number_of_periods=size(dates,1);
for a = 1:number_of_periods
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	dates2(a)=year*100+month;
	if(a<number_of_periods-48)
		indexvalue2(a) = (indexvalue(a)-indexvalue(a+48))/indexvalue(a+48);
	endif
endfor
% 
% Filter the odd things out
%
value = 1977*100+2;
filtered = (dates2(:)>value);
matrix = horzcat(dates2(filtered),indexvalue2(filtered));
fprintf('Writing file...\n');
csvwrite('SPCOMP_READY.csv',matrix);
