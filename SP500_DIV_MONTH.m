clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
[dates,dividends] = textread("SP500_DIV_MONTH.csv","%s %f",'delimiter',',','headerlines',1);
dates2 = zeros(size(dates,1),1);
fprintf('Parsing dates...\n');
for a = 1:size(dates,1)
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	dates2(a)=year*100+month;
endfor
% 
% Filter the odd things out
%
value = 1977*100+2;
filtered = (dates2(:)>value);
matrix = horzcat(dates2(filtered),dividends(filtered));
fprintf('Writing file...\n');
csvwrite('SP500_READY.csv',matrix);
