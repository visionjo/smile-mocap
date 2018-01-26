function fbase = basename(fpath)
%FILEBASE Summary of this function goes here
%   Detailed explanation goes here
fbase = fpath((find(fpath == '/', 1, 'last')+1):end);
end

