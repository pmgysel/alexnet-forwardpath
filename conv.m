%Convolution Layer.
%bottom is a 3d matrix: Win x Hin x N.
%top is a 3d matrix: Wout x Hout x M.
%weight is a 4d matrix: K x K x N x M (or K x K x N/2 x M in case of group==2).
%bias is a 4d matrix: 1 x 1 x 1 x M.
%Kernel size K and stride S are integers.
%Padding 'pad' specifies the number of pixels to (implicitly) add to each
%side of the input.
%If group==1, the OFMs depend on all IFMs. If group==2, the IFMs and OFMs are
%split into two groups, therefore the OFMs only depend on half the IFMs.
function [ top ] = conv( bottom, weight, bias, K, S, pad, group )
    [Win,Hin,N]=size(bottom);
    [~,~,~,M]=size(weight);
    bottomPadded=zeros(Win+2*pad,Hin+2*pad,N);
    bottomPadded(pad+1:end-pad,pad+1:end-pad,:)=bottom;
    Wout=(Win+2*pad-K)/S+1;
    Hout=(Hin+2*pad-K)/S+1;
    top=zeros(Wout,Hout,M);
    %Convolve kernels with input feature maps.
    %Code is vectorized over N: For one specific output feature map,
    %convolve all input feature maps and the corresponding kernels at the
    %same time.
    switch group
        %This is the normal convolution where every output feature map
        %depends on every input feature map.
        case 1,
            for w=1:Wout
                for h=1:Hout
                    for m=1:M
                        wStart=(w-1)*S+1;
                        wEnd=wStart+K-1;
                        hStart=(h-1)*S+1;
                        hEnd=hStart+K-1;
                        top(w,h,m)=top(w,h,m)+sum(sum(sum( ...
                            bottomPadded(wStart:wEnd,hStart:hEnd,1:N) .* ...
                            weight(:,:,1:N,m))));
                    end
                end
            end
        %In this special case, the output feature maps depend on only half
        %the input feature maps.
        case 2,
            %Group 1
            for w=1:Wout
                for h=1:Hout
                    for m=1:M/2
                        wStart=(w-1)*S+1;
                        wEnd=wStart+K-1;
                        hStart=(h-1)*S+1;
                        hEnd=hStart+K-1;
                        top(w,h,m)=top(w,h,m)+sum(sum(sum( ...
                            bottomPadded(wStart:wEnd,hStart:hEnd,1:N/2) .* ...
                            weight(:,:,1:N/2,m))));
                    end
                end
            end
            %Group 2
            for w=1:Wout
                for h=1:Hout
                    for m=M/2+1:M
                        wStart=(w-1)*S+1;
                        wEnd=wStart+K-1;
                        hStart=(h-1)*S+1;
                        hEnd=hStart+K-1;
                        top(w,h,m)=top(w,h,m)+sum(sum(sum( ...
                            bottomPadded(wStart:wEnd,hStart:hEnd,N/2+1:N) .* ...
                            weight(:,:,1:N/2,m))));
                    end
                end
            end
        otherwise
            error('Convolution group must be 1 or 2');
    end
    %Add bias.
    for m=1:M
        top(:,:,m)=top(:,:,m)+bias(1,1,1,m);
    end
end
