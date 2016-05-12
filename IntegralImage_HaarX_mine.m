function an=IntegralImage_HaarX_mine(row, column, size, img)
% This function IntegralImage_HaarX will ..
%
% [an] = IntegralImage_HaarX( row,column,size,img )
%  
%  inputs,
%    row : 
%    column : 
%    size : 
%    img : 
%  
%  outputs,
%    an : 
%  
% Function is written by D.Kroon University of Twente (July 2010)
an= IntegralImage_BoxIntegral_mine(row - size / 2, column, size, size / 2, img) - IntegralImage_BoxIntegral_mine(row - size / 2, column - size / 2, size, size / 2, img);
