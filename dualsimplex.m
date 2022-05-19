clc 
clear all
close all
format rat
%% input parameters
a = [-5,-1;-6,-5 ;-1 -4];
b = [-10;-30 ; -8];
c = [-12,-10];
numberOfVariables = 2;
s = eye(size(a,1)); % makes an identity matrix of size = number of rows in a
A = [a s b];
% calculating cost
cost = zeros(1,size(A,2));
cost(1:numberOfVariables) = c;
% calculating basic variables
bv = numberOfVariables+1 : 1 : size(A,2)-1
% calculating zj-cj
zjcj = cost(bv)*A - cost
zcj = [zjcj ; A];
% displaying the array as a table
simptable = array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2)) = {'x1','x2','s1','s2','s3','sol'}
%% main loop
RUN = true;
while RUN
    sol = A(:,end);
    if any(sol<0)
        disp('solution is not optimal')
        % finding leaving variable
        [leav_var,pvt_row] = min(sol);
        % finding entering variable
        zc = zjcj(1:end-1)
        row = A(pvt_row,:)
        if all(row>=0)
            disp('Infeasible solution')
            break;
        end
        ratio = [];
        for i = 1:size(A,2)-1
            if row(i)>=0
                ratio(i) = -inf;
            else
                ratio(i) = zc(i)/row(i);
            end
        end
        ratio
        [entr_var,pvt_col] = max(ratio);
        % updating the basic variable
        bv(pvt_row) = pvt_col;
        % applying row operations
        for i = 1:size(A,1)
            if i~=pvt_row
                A(i,:) = A(i,:) - (A(i,pvt_col).*A(pvt_row,:))/A(pvt_row,pvt_col);
            end
        end
        k = zjcj(pvt_col);
        for i = 1 : size(A,2)
            zjcj(i) = zjcj(i) - (A(pvt_row,i)*k)/A(pvt_row,pvt_col);
        end
        A(pvt_row,:) = A(pvt_row,:)/A(pvt_row,pvt_col);
        A
        zjcj
    else
        RUN = false;
    end
end
fprintf('Optimal value = %.4f\n',zjcj(end)*-1) % -1 because objective function was in minimization form
fprintf('Optimal solution = %.4f\n',A(:,end))
bv