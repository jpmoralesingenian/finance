%  Taken from:
%  Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
%% S&P 500 Dividend yield for the month prior. 
sp500 = loadData('SP500_READY.csv');
%% Compounded percent return for the S&P 500 for the 48 months prior
spret = loadData('SPCOMP_READY.csv');
%% The manufacturing capacity utilization for the 12 months prior to the S&P 500 performance month.
manu  = loadData('MCUMFN_READY.csv');
%% The 90-day average Treasury bill rate for the 16 months prior to the S&P 500 performance month.
tbill = loadData('TBILL90_READY.csv');
%% The average monthly NYSE turnover ratio for the 53 months prior to the S&P 500 performance month.
nyseto = loadData('NYSETO_READY.csv');
%% The rate of return of the long government bond for the 12 months prior to the S&P 500 performance month..
tyx = loadData('TYX_READY.csv');
X = horzcat(sp500,spret,manu,tbill,nyseto,tyx);
y = loadData('Y_READY.csv');
m = length(y);
final_dates = loadDates('Y_READY.csv');
final_y = y;
% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.2f %.2f %.2f %.2f %.2f %.2f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X,2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('Cost:  %f \n',computeCostMulti(X,y,theta));
h =(theta'*X')';
final_gradient = h;
fprintf('H:  %f \n',h(1:10,:));
fprintf('\n');

% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
price = 0; % You should change this


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
X = horzcat(sp500,spret,manu,tbill,nyseto,tyx);
y = loadData('Y_READY.csv');
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('Cost:  %f \n',computeCostMulti(X,y,theta));
h =(theta'*X')';
final_normal=h;
fprintf('H:  %f \n',h(1:10,:));
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================

%% price = [1 1494 3] * theta;


% ============================================================

% fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%         '(using normal equations):\n $%f\n'], price);
final_titles = ["date","SnP","Predicted GD","Predicted NE"];
final = horzcat(final_dates,final_y,final_gradient,final_normal);
csvwrite("RESULT.csv",final_titles);
csvwrite("RESULT.csv",final,'append','on');

