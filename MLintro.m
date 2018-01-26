X = randn(100,5);
r = [0;2;0;-3;0]; % only two nonzero coefficients
Y = X*r + randn(100,1)*.1; % small added noise
corrplot(Z,'varNames',{'Y','x1','x2','x3','x4','x5'})
B = lasso(X,Y);