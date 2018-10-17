function mask=connect(deltaE,mask,y,x,low)       %定位后的连通分析
    neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %八连通搜寻
    [m,n]=size(mask);
    for k=1:8
        yy=y+neighbour(k,1);
        xx=x+neighbour(k,2);
        if yy>=1 &&yy<=m &&xx>=1 && xx<=n  
            if deltaE(yy,xx)>=low && mask(yy,xx)~=1   %判断下阈值
                mask(yy,xx)=1;
                mask=connect(deltaE,mask,yy,xx,low);
            end
        end        
    end 

    