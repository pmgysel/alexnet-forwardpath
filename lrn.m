%Local Response Normalization accross nearby channels.
%bottom is a 3d matrix: W x H x N.
%top is a 3d matrix: W x H x N.
%localSize, alpha, beta and k are integers.
%The output pixels depend only on pixels of nearby feature maps at the same position
%(same w/h coordinates).
%Formula:
%top_xy_i=bottom_xy_i/(k+alpha/localSize*sum_i(bottom_xy_i^2))^beta.
%The padding pixels consist of zeros.
function [ top ] = lrn( bottom, localSize, alpha, beta, k )
    [W,H,N]=size(bottom);
    top=zeros(W,H,N);
    for w=1:W
        for h=1:H
            for n=1:N
                nStart=max(n-floor(localSize/2),1);
                nEnd=min(n+floor(localSize/2),N);
                top(w,h,n)=bottom(w,h,n)/ ...
                    ((k+alpha/localSize*sum(bottom(w,h,nStart:nEnd).^2))^beta);
            end
        end
    end
end
