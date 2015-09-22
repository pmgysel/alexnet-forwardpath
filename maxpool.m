%Maxpool over a window with width and height equal kernelSize.
%bottom is a 3d matrix: Win x Hin x N.
%top is a 3d matrix: Wout x Hout x N.
%kernelSize and stride are integers.
%Pool the input (bottom) with windows of size kernelSize and with the specified stride.
%No padding needed.
function [ top ] = maxpool( bottom, kernelSize, stride )
    [Win,Hin,N]=size(bottom);
    Wout = (Win-kernelSize)/stride+1;
    Hout = (Hin-kernelSize)/stride+1;
    top=zeros(Wout,Hout,N);
    for n=1:N
        for h=1:Hout
            for w=1:Wout
                hstart = (h-1)*stride+1;
                wstart = (w-1)*stride+1;
                hend=hstart+kernelSize-1;
                wend=wstart+kernelSize-1;
                top(w,h,n)=max(max(bottom(wstart:wend,hstart:hend,n)));
            end
        end
    end
end
