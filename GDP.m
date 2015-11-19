clear; clc;
fprintf('Loading data ...\n');
debug_on_error(0);
% Quarter,Gross domestic product,Personal consumption expenditures,Goods,Durable goods,Nondurable goods,Services,Gross private domestic investment,Fixed investment,Nonresidential,Structures,Equipment,Intellectual Property Products,Residential,Change in private inventories,Net exports of goods and services,Exports,Goods,Services,Imports,Goods,Services,Government consumption expenditures and gross investment,Federal,National defense,Nondefense,State and local
[dates,gdp,pce,g,dg,ndg,s,gpei,fi,br,str,eq,ipp,r,cipi,negs,exports,goods,services,imports,gcegi,federal,natdef,nodef,stateloc,ax,bx]= textread("10105QTR.csv","%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f",'delimiter',',','headerlines',1);
dates2 = zeros(0,0);
gdps2 = zeros(0,0);
fprintf('Parsing dates...\n');
number_of_periods=size(dates,1);
for a = 1:number_of_periods
	my_date = strsplit(dates{a},'-');
	year = str2num(my_date{1});
	month = str2num(my_date{2});
	count_months = size(dates2,1);
	date_to_add=year*100+month;
	dates2 = [dates2;date_to_add];
	% We have to add the month and the two months before
	dates2 = [dates2;date_to_add-1];
	dates2 = [dates2;date_to_add-2];
	gdps2= [gdps2;gdp(a);gdp(a);gdp(a)];
endfor
% Now find the average of the annual percentage change oover 48 months
number_of_periods=size(dates2,1);
gdps3 = zeros(number_of_periods,1);

for a = 1:number_of_periods
	if(a<number_of_periods-48) 
		gdps3(a) = mean(gdps2(a:a+48));
	else
		gdps3(a) = mean(gdps2(a:number_of_periods));
	endif
endfor
% 
% Filter the odd things out
%
value = 1977*100+2;
filtered = (dates2(:)>value);
matrix = horzcat(dates2(filtered),gdps3(filtered));
fprintf('Writing file...\n');
csvwrite('GDP_READY.csv',matrix); 
