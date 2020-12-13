function PlayTune(song,param)
% function PlayTune(song,param)
%   Plays song given parameter structure
% --------------------------------------
% Inputs
%   song -  The song you want to play
%   param - Structure of key parameters. See parameters.m for info.

sound(song./max(abs(song)),param.Fs);