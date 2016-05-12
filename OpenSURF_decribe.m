function descriptors = OpenSURF_decribe(x,y,scale, I)

% This function SurfDescriptor_DecribeInterestPoints will ..
%
% [ipts] = SurfDescriptor_DecribeInterestPoints( ipts,upright,extended,img )
%
%  inputs,
%    ipts : Interest Points (x,y,scale)
%    bUpright : If true not rotation invariant descriptor
%    bExtended :  If true make a 128 values descriptor
%    img : Integral image
%    verbose : If true show useful information
%
%  outputs,
%    ipts :  Interest Points (x,y,orientation,descriptor)
%
% Function is written by D.Kroon University of Twente (July 2010)
assert(size(I,3)==1);
upright=true;% no rotation invariant
iimg = IntegralImage_IntegralImage_mine(I);
descriptorLength = 64;
descriptors=zeros(length(x),descriptorLength);
for i=1:length(x)
    
    % Get the orientation
    %ip.orientation=SurfDescriptor_GetOrientation(ip,img,verbose);
    
    % Extract SURF descriptor
    descriptors(i,:)=OpenSURF_getDescriptor(x(i),y(i),scale(i), upright, iimg);
    
end
