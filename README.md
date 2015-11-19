iHere we have a bunch of code for an Octave model of behavior
CSV files are data files
CSV files that end in _READY have been processed to standarize the data series into a common format. 
data_gathering.txt Contains information on HOW the data was extracted, from which URLs and with which constraints
dynamic_portfolio.pdf	The book that contains the model that is implemented here. 

------------------------------
- Raw Data CSV
------------------------------
FRB_H15_T90.csv		Contains the treasury data for tbill rates
INDEX_GSPC.csv		Contains the S&P info
INDEX_TYX.csv
MCUMFN.csv		Contains manufacturing output data
NYSETO.csv		Base data for NYSE turnover
SP500_DIV_MONTH.csv	Dividends for the S&P
RESULT.csv		The final result of the model
TYX.mq
W7.csv			NYSE turnover, not used
W9.csv			90 day treasury, not used (only good until 2000)
TYX_READY.csv
YALE-SPCOMP.csv		Composite s&p
-------------------------------
- Final result CSV
-------------------------------
TBILL90_READY.csv	Treasury bill 
MCUMFN_READY.csv	Manufacturing final result
NYSETO_READY.csv	NYSE turnover final resulta
SP500_READY.csv
SPCOMP_READY.csv	S&P composites
Y_READY.csv		S&P standard. This is out objective function

-------------------------------
- CSV processing Octave Scripts
-------------------------------
Y.m			How to create the SP raw result
YALE-SPCOMP.m		How to create the SP composite
MCUMFN.m		How to create the manufacturing data
NYSETO.m		How to create the NYSE turnover data	
SP500_DIV_MONTH.m	How to create the monthly dividend
TBILL90.m		How to calculate the treasury yield
-------------------------------
- Model building Octave scripts
-------------------------------
finances.m		The main file, organizes everything and calls everything
computeCostMulti.m	Coursera. Calculate the cost function
featureNormalize.m	Coursera. Normalize features
gradientDescentMulti.m  Coursera. Use gradient descent to minimize cost
loadData.m		Load the data from a CSV (one of the _READY files) 
loadDates.m		Load the dates from the same CSV
normalEqn.m		Cousera. Use normal equations to resolve the problem
plotData.m		Cousera. Use GNU plot to draw
