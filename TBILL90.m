clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
[dates,indexvalue]= textread("FRB_H15_T90.csv","%s %f",'delimiter',',','headerlines',6);
dates2 = zeros(size(dates,1),1);
indexvalue2 = zeros(size(indexvalue,1),1);
fprintf('Parsing dates...\n');
number_of_periods=size(dates,1);
for a = 1:number_of_periods
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	dates2(a)=year*100+month;
% Yearly rolling average
	if(a>16)
		indexvalue2(a) = mean(indexvalue(a-15:a));
	else 
		indexvalue2(a) = mean(indexvalue(1:a));
	endif
endfor
% 
% Filter the odd things out
%
value = 1977*100+2;
filtered = (dates2(:)>value);
matrix = horzcat(dates2(filtered),indexvalue2(filtered));
matrix = flipud(matrix);
fprintf('Writing file...\n');
csvwrite('TBILL90_READY.csv',matrix);
