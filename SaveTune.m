function SaveTune(song,param,filename)
% function SaveTune(song,param,filename)
%   Saves song to specified file in .wav format
% --------------------------------------
% Inputs
%   song -  The song you want to play
%   param - Structure of key parameters. See parameters.m for info
%   filename - Name of the file that you want to save to (do not include
%              the file extension)

% Audiowrite is used in newer versions of matlab
audiowrite([filename '.wav'],song(:)./max(abs(song(:))),param.Fs);

% Wavwrite is used in older versions of matlab, but has been removed in later
% versions
%wavwrite(song(:)./max(abs(song(:))), param.Fs, [filename '.wav']);