function [] = traversalAll()
for proj_angle = 0:179
    for detector_index = -4:3
        axes(handles.projAxes) ;
        cla reset;
        projAxesInitialize(handles.projAxes);
        drawProjLine(handles.projAxes, proj_angle, detector_index);
        system_matrix =  intersection(proj_angle, detector_index);
        set(handles.lengthDataTable,'Data',system_matrix);
        drawScaledColorImage(handles.imagescAxes, system_matrix);
        pause(1);
    end
end
end

