function [] = drawScaledColorImage(handles, system_matrix)
image=zeros(8);
if ~isempty(system_matrix)
    i = 1:size(system_matrix,1)-1;
    image(system_matrix(i,4)) = system_matrix(i,3);
    image = rot90(image);
end
imagesc(handles, image);
end

