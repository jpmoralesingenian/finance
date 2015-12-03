%  Taken from:
%  Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
%% S&P 500 Dividend yield for the month prior. 
y = loadData('Y_READY.csv');
m = length(y);
old_x = rand(size(y,1),3);
X = old_x;
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

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X,2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
%figure;
%plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
%xlabel('Number of iterations');
%ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('Cost:  %f \n',computeCostMulti(X,y,theta));
h =(theta'*X')';
final_gradient = h;
fprintf('H:  %f \n',h(1:10,:));
fprintf('\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

%% Load Data
X = old_x;
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


% ============================================================
% Draw the damn thing
% ============================================================
figure;
plot(final_dates, final_y,"r",final_dates,final_gradient,"g",final_dates,final_normal,"b");
%xlabel('Number of iterations');
%ylabel('Cost J');
% fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%         '(using normal equations):\n $%f\n'], price);
final_titles = ["date","SnP","Predicted GD","Predicted NE"];
final = horzcat(final_dates,final_y,final_gradient,final_normal);
csvwrite("RANDOM.csv",final_titles);
csvwrite("RANDOM.csv",final,'append','on');

