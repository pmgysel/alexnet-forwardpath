%Maxpool over a window of K*K.
%bottom is a 3d matrix: Win x Hin x N.
%top is a 3d matrix: Wout x Hout x N.
%The kernel size K and stride S are integers.
%Pool the input (bottom) with windows of size K and with the specified stride.
%No padding needed.
function [ top ] = maxpool( bottom, K, S )
    [Win,Hin,N]=size(bottom);
    Wout = (Win-K)/S+1;
    Hout = (Hin-K)/S+1;
    top=zeros(Wout,Hout,N);
    for n=1:N
        for h=1:Hout
            for w=1:Wout
                hstart = (h-1)*S+1;
                wstart = (w-1)*S+1;
                hend=hstart+K-1;
                wend=wstart+K-1;
                top(w,h,n)=max(max(bottom(wstart:wend,hstart:hend,n)));
            end
        end
    end
end
