function [] = drawProjLine(handles, proj_angle, detector_index)
diagonal_length = ceil(sqrt(2*9^2))/2;
x_source = detector_index*cosd(proj_angle) + diagonal_length*sind(proj_angle);
y_source = detector_index*sind(proj_angle) - diagonal_length*cosd(proj_angle);
x_detector = detector_index*cosd(proj_angle) - diagonal_length*sind(proj_angle);
y_detector = detector_index*sind(proj_angle) + diagonal_length*cosd(proj_angle);
if sind(proj_angle)==0  
    quiver(handles,detector_index,y_source,0,y_detector-y_source,'Color',[0.4,0.4,0.8],'LineWidth',2);
else
    quiver(handles,x_source,y_source,x_detector-x_source,y_detector-y_source,'Color',[0.4,0.4,0.8],'LineWidth',2);
end
end

