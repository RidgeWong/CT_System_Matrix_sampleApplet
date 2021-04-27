function [system_matrix] = intersection(proj_angle, detector_index)
image_size = 8;
detector_num = image_size;
diagonal_length = ceil(sqrt(2*(detector_num+1)^2))/2;
system_matrix = [];

rotation_center = image_size / 2;
grid_x_left = -rotation_center+0.5;
grid_x_right = rotation_center+0.5;
grid_y_bottom = -rotation_center-0.5;
grid_y_top =  rotation_center-0.5;

x_source = detector_index*cosd(proj_angle) + diagonal_length*sind(proj_angle);
y_source = detector_index*sind(proj_angle) - diagonal_length*cosd(proj_angle);
x_detector = detector_index*cosd(proj_angle) - diagonal_length*sind(proj_angle);
y_detector = detector_index*sind(proj_angle) + diagonal_length*cosd(proj_angle);

x_distance = x_detector-x_source;
y_distance = y_detector-y_source;
Xplane = grid_x_left:grid_x_right;
Yplane = grid_y_bottom:grid_y_top;

a_x_1 = (grid_x_left-x_source)/x_distance;
a_x_n = (grid_x_right-x_source)/x_distance;
a_y_1 = (grid_y_bottom-y_source)/y_distance;
a_y_n = (grid_y_top-y_source)/y_distance;

amin = max([0 min(a_x_1,a_x_n) min(a_y_1,a_y_n)]);
amax = min([1 max(a_x_1,a_x_n) max(a_y_1,a_y_n)]);

if amax <= amin%the ray does not intersect the CT array
    return;
end

if x_distance > 0
    imin = ceil(roundn(image_size+1-(grid_x_right-amin*x_distance-x_source),-6));
    imax = floor(roundn(1+(x_source+amax*x_distance-grid_x_left),-6));
    j = 1:imax-imin+1;
    i = imin:imax;
    a_x = zeros(1,size(j,2));
    a_x(j) = (Xplane(i)-x_source)/x_distance;
elseif x_distance < 0
    imin = ceil(roundn(image_size+1-(grid_x_right-amax*x_distance-x_source),-6));%%%
    imax = floor(roundn(1+(x_source+amin*x_distance-grid_x_left),-6));
    j = 1:imax-imin+1;
    i = imin:imax;
    a_x = zeros(1,size(j,2));
    a_x(j) = (Xplane(i)-x_source)/x_distance;
else
    a_x = [];
end

if y_distance > 0
    jmin = ceil(roundn(image_size+1-(grid_y_top-amin*y_distance-y_source),-6));
    jmax = floor(roundn(1+(y_source+amax*y_distance-grid_y_bottom),-6));
    j = 1:jmax-jmin+1;
    i = jmin:jmax;
    a_y = zeros(1,size(j,2));
    a_y(j) = (Yplane(i)-y_source)/y_distance;
elseif y_distance < 0
    jmin = ceil(roundn(image_size+1-(grid_y_top-amax*y_distance-y_source),-6));%%%
    jmax = floor(roundn(1+(y_source+amin*y_distance-grid_y_bottom),-6));
    j = 1:jmax-jmin+1;
    i = jmin:jmax;
    a_y = zeros(1,size(j,2));
    a_y(j) = (Yplane(i)-y_source)/y_distance;
else
    a_y = [];
end
a = [a_x a_y];
a = unique(sort(a));
ray_length = sqrt(x_distance^2+y_distance^2);

system_matrix(:,1) = x_source+a*x_distance;
system_matrix(:,2) = y_source+a*y_distance;

i = 1:size(a,2)-1;
a_mid = (a(i+1)+a(i))/2;
im = floor(1+(x_source+a_mid*x_distance-grid_x_left));
jm = floor(1+(y_source+a_mid*y_distance-grid_y_bottom));
system_matrix(i,3) = ray_length*(a(i+1)-a(i));
system_matrix(i,4) = sub2ind([8 8],im,jm);
end
