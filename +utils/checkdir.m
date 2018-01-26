function checkdir( dirpath )
%CHECKDIR checks if a directory exists; if not, it creates it.

if ~exist(dirpath,'dir'),  mkdir(dirpath);  end 

end

