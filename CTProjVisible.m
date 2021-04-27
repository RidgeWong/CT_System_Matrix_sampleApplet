
%%%%%%%%%%%%%%%%%%%% CT System Matrix %%%%%%%%%%%%%%%%%%%%%%
function CTProjVisible
    warning off; % disable warning
    [pathstr,~,~]=fileparts(mfilename('fullpath'));
    addpath(genpath(pathstr));
    % Open main panel
    mainGUI(pathstr);
    clear pathstr name ext
end