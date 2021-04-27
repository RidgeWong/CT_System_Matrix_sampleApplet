function [] = drawPixelGrid(handles)
hold on
for x = -3.5:4.5
    plot(handles,[x,x],[-4.5,3.5],'color',[1 0 0]);
end
for y = -4.5:3.5
    plot(handles,[-3.5,4.5],[y,y],'color',[1 0 0]);
end
end

