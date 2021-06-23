function [readMatrix] = read(fileName, sheetName, block)

    readMatrix = xlsread(fileName, sheetName, block);
    
    readMatrix(all(isnan(readMatrix),2),:) = []; % remove rows with all NaN
  
end