function matrixRead=MatrixInHarwellBoeingFile(matFile)
% 功能: 从Harwell-Boeing格式的文件中读取矩阵
% 
% @param string matFile          要处理的文件路径  
% @return double[,] matrixRead   文件中的矩阵 
% 
% PS: 目前只能读文本格式的对称矩阵
% 
% luoyin
% date: Mar 3, 2016

fid=fopen(matFile,'r');
fgetl(fid);
strLine=fgetl(fid);
dataRead=strread(strLine,'%d');
RHS=dataRead(end);

strLine=fgetl(fid);
dataRead=strread(strLine(4:end),'%d');
matrixRead=zeros(dataRead(1),dataRead(2));

fgetl(fid);
if(RHS~=0)
    fgetl(fid);
end

for ii=1:dataRead(2)+1
    ColPointer(ii)=str2num(fgetl(fid));
end

for ii=1:dataRead(3)
    RowIndex(ii)=str2num(fgetl(fid));
end

rindex=1;

for iCol=1:dataRead(2)
    for ii=1:(ColPointer(iCol+1)-ColPointer(iCol))
        iRow=RowIndex(rindex);
        matrixRead(iRow,iCol)=str2double(fgetl(fid));
        matrixRead(iCol,iRow)=matrixRead(iRow,iCol);
        rindex=rindex+1;
    end
end

fclose(fid);
end 
