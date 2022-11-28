function [] = printtable(T, options)

% Function to print tables containing the following types of variables:
% numeric and NaN
% string ("" not '') and missing


% Options
if isfield(options,'filename')
    filename = options.filename;
else
    filename = 'default.tex';
end

if isfield(options,'printcol')
    printcol = options.printcol;
else
    printcol = 0;
end

if isfield(options,'format')
    format = options.format;
else
    format = '%8.3f';
end

% Convert to cell of string
C = table2cell(T);
nrows = size(T,1);
ncols = size(T,2);
for i=1:nrows
    for j=1:ncols
        if ismissing(C{i,j})
            C{i,j} = "";
        end
        if isnumeric(C{i,j})
            C{i,j} = string(num2str(C{i,j}, format));
        end
        
    end
end
        
% Open
FID = fopen(filename, 'w');

% Write column names
if printcol==1
for j=1:ncols
    
    fprintf(FID, '%s',T.Properties.VariableNames{j}); 
    
    if j==ncols
        fprintf(FID, '%s','\\');  
        fprintf(FID,'\n');    
    else  
        fprintf(FID, '%s','&');    
    end 
end
end

% Write data
for i=1:nrows
    for j=1:ncols
        
        fprintf(FID, '%s', C{i,j});
        
        if j==ncols
        fprintf(FID, '%s','\\');  
        fprintf(FID, '\n');
        else
        fprintf(FID, '%s','&');    
        end

    end
end






end

