function data = loadData(file) 
% Load everything on the file named file and make sure to return a single column 264 size matrix
	[dates,data] = textread(file,"%d %f",'delimiter',',');
	rows = size(data,1);
	desired_rows = 462;
	if(rows>desired_rows) 
		data = data(rows-desired_rows+1:rows,1);
	endif
end
