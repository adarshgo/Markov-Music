function [song,next] = AddNote(song,start,note,duration,intensity,attenuation,param)
% function song = AddNote(song,note,duration,attenuation,intensity)
%   Add a note to a song with a given duration, intensity, and attenuation.
% -------------------------------------------------------------------------
% Inputs:
%   song -  Current version of the song
%
%   start - Starting point for inserting note into song sample stream
%
%   note -  Note to append to song
%               1-88 indicate a particular piano key
%               89 indicates silence
%
%   duration -  Duration of note
%                   1 indicates whole note
%                   2 indicates half note
%                   3 indicates quarter note
%                   4 indicates eigth note
%                   5 indicates sixteenth note
%
%   intensity - Volume of the note
%                   Takes values between 0 and 100, where 100 is the loudest
%
%   attenuation - The rate at which the note attenuates using an
%                 exponential decay model. Note that attenuation is
%                 applied relative to the note duration.
%                       Takes values between 25 and 75, where 75 is the 
%                       highest attentuation.
%
%   param -     Structure of key parameters. See parameters.m for info.
%
% Outputs:
%   song -  Song updated with note
%   next -  Starting point for inserting next note into the stream
%   

% Get samples of new note
[soundSamples,timeScale] = GenerateNote(note,duration,intensity,attenuation,param);

% Append samples to song
song([start:start+length(soundSamples)-1]) = ...
    song([start:start+length(soundSamples)-1]) + soundSamples;

next = start+ceil(param.Fs*timeScale);


end

function [soundSamples,noteValue] = GenerateNote(note,duration,intensity,attenuation,param)
   
    %% Create note with attenuation and overtones
    
    % Check for valid intensity parameter
    if intensity < param.LOW_VOL || intensity > param.HIGH_VOL
        error('ERROR: Invalid intensity parameter')
    end
    
    % Set time scale based on note duration
    noteValue = 1;
    switch duration
        case param.WHOLE_NOTE,
            noteValue = 1;
        case param.HALF_NOTE,
            noteValue = 1/2;
        case param.QUARTER_NOTE,
            noteValue = 1/4;
        case param.EIGTH_NOTE,
            noteValue = 1/8;
        case param.SIXTEENTH_NOTE,
            noteValue = 1/16;
        otherwise,
            error('ERROR: Invalid duration parameter');
    end
    timeScale = noteValue * 4*60/param.bpm; % Seconds per note
    
    % Set exponential decay constant and number of sound samples 
    % based on attenuation and time scale
    if attenuation >= param.LOW_ATTEN && attenuation <= param.HIGH_ATTEN
        lambda = log(1-attenuation/100)/(param.Fs*timeScale);
        samples = ceil(log(1-90/100)/lambda);
    else
        error('ERROR: Invalid attenuation parameter');
    end
    
    atten = exp(lambda*[0:samples-1]); % atten(i) is attenuation of sample i
    soundSamples = zeros(1,samples);
    for j = 1:length(param.overtone)
        if note ~= param.SILENCE
            soundSamples = soundSamples + ...
                (intensity/100)*param.overtoneWeights(j)*atten.*sin(param.overtone(j)*param.keyFreq(note)*2*pi/param.Fs*[0:samples-1]);
        else
            % soundSamples = 0;
        end
    end
end