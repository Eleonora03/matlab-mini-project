function [T, wavenumber, R] = CLEAN_TABLE(T, R)
% CLEAN_TABLE Cleans and processes input tables T and R.
%   Removes first column and row from T, extracts wavenumber,
%   applies moving average, and cleans R.

% Remove the first column from T
T(:, 1) = [];

% Extract wavenumber from the first row of T and convert to array
wavenumber = table2array(T(1, :));

% Remove the first row from T
T(1, :) = [];

% Convert T from table to numeric array
T = T{: , :};

% Apply moving average to each row of T
windowSize = 5; % Size of the moving average window
for i = 1:size(T, 1)
    T(i, :) = movmean(T(i, :), windowSize);
end

% Remove the first column from R and convert to array
R(:, 1) = [];
R = table2array(R);
end





