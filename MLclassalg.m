%%Input should be matrix of data with outcome as first column
%% Initialize variables.
filename = 'C:\Users\frede\OneDrive\Documents\MATLAB\Git2\specttrain.csv';
delimiter = ',';
fileID = fopen(filename,'r');
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
Train = [dataArray{:, 1:23}];
filename = 'C:\Users\frede\OneDrive\Documents\MATLAB\Git2\specttest.csv';
delimiter = ',';
fileID = fopen(filename,'r');
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
Test = [dataArray{:, 1:23}];

%% Set up matrix solver

A = Train(:,2:23);
% Define decomposition of attribute matrix A
[Un,Sn,Vn] = svd(A);

% Solve Least Squares Problem using matrix parts
y = Train(:,1);
b = y;
UUn = Un';
cn = UUn * b;
[m,n] = size(Sn);
ysol(1:n) = 0;
for j=1:n;
 ysol(j) = cn(j)/Sn(j,j);
end
xsol = Vn*ysol';

%% Test beta weights to predict class
% Use a cutoff of .5 to assign predictions to a class
% i.e. this is a "rough" logistic approach

[m,n]=size(Test);
PredictClass = Test(:,2:23)*xsol;

for i=1:m
    if PredictClass(i)<.5
        PredictClass(i)=0;
    else
        PredictClass(i)=1;
    end
end

Accuracy = PredictClass==Test(:,1);

goodness = mean(Accuracy)*100

disp(['The linear regression matrix solver algorithm classified ',num2str(goodness,4),'% of the test data correctly.'])
