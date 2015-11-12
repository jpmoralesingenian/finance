clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
[dates,open,high,low,close,volume,close2]= textread("INDEX_GSPC.csv","%s %f %f %f %f %f %f",'delimiter',',','headerlines',1);
dates2 = zeros(0,0);
sums = zeros(0,0);
counts = zeros(0,0);
fprintf('Parsing dates...\n');
number_of_periods=size(dates,1);
for a = 1:number_of_periods
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	count_months = size(dates2,1);
	date_to_add=year*100+month;
	must_add=0;
	if(count_months>0) 
		if(dates2(count_months)!=date_to_add) 
			must_add=1;
		endif
	else
		must_add=1;
	endif
	if(must_add==1) 
		dates2 = [dates2;date_to_add];
		sums= [sums;close(a)];
		counts = [counts;1];	
	else
		sums(count_months)+=close(a);
		counts(count_months)++;
	endif
endfor
averages = sums./counts;
number_of_periods=size(dates2,1);
% 
% Filter the odd things out
%
start_moment = 1977*100+2;
filtered = (dates2(:)>start_moment);
matrix = horzcat(dates2(filtered),averages(filtered));
fprintf('Writing file...\n');
csvwrite('Y_READY.csv',matrix);
