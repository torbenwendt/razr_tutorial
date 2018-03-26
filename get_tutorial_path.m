function pth = get_tutorial_path
% GET_TUTORIAL_PATH - Get absolute path to the directory where this file is stored.
%
% Usage:
%   pth = GET_TUTORIAL_PATH

pth = fileparts(mfilename('fullpath'));
