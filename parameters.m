% Parameter file
%
%   *USEFUL INFORMATION*
%       Piano scales
%       http://www.pianoscales.org/major.html
%
%       Piano key frequencies
%       http://en.wikipedia.org/wiki/Piano_key_frequencies

% Initialize Piano
param.numKeys = 88;                                     % Number of piano keys
param.keyFreq = 2.^(([1:param.numKeys] - 49)/12) * 440;	% Key frequencies

% Sample rate and sample duration
param.Fs = 44100/2;                                     % Sample rate
param.Ts = 1/param.Fs;                                  % Sample duration

% Beats per minute (a whole note has duration of 4 beats in 4/4 time)
param.bpm = 120; 

% Note, duration, intensity, and attenuation options
param.noteSet = [1:param.numKeys+1];
param.durationSet = [1:5];
param.intensitySet = [0:100];
param.attenuationSet = [25:75];

% Overtone parameters
% If your note has frequency f, then the actual sound it creates will be a
% weighted sum of sinusoids at frequency f, as well as its overtones, e.g.,
% 2*f, 3*f, etc. The set of overtones is defined in param.overtone.
% Overtone(i) is weighted according to overtoneWeights(i).
param.overtone = [5,2,5,2,5,2,5,2,1,2,3,4,1,2,1,2,3,1]; % Frequency multipliers
param.overtoneWeights = [ 1,1/8,1,1/8,1,1/8,1,1,1,1,1,1,2,1,2,2,1,3]; % Overtone weights

% Sets of notes in certain scales
% Note that C4 can be turned into C5 by adding 12 to the note's index
param.CMajor = CreateScale({'C4','D4','E4','F4','G4','A4','B4','C5'}); %[40,42,44,45,47,49,51,52]; % C,D,E,F,G,A,B,C (4th octave)
param.DMajor = CreateScale({'D3','E3','F#3','G3','A3','B3','C#4','D4'});
param.EbMajor = CreateScale({'D#3','F3','G3','G#3','A#3','C4','D4','D#4'});% [31,33,35,36,37,40,42,43];% D#,F,G,G#,A#,C,D,D# (3rd octave)
param.PhrygianDom = CreateScale({'C4','Db4','E4','F4','G4','Ab4','Bb4','C5'}); %[40,41,44,45,47,48,50,52]; % C,Db,E,F,G,Ab,Bb,C (4th octave)
param.CMajorSil = [param.CMajor(1:end-1) 89]; % Replace last note with silence
param.AMajor = CreateScale({'A5','B1','C#4','D2','E3','F#3','G#2','A1'});

% CONSTANTS
param.SILENCE = 89;
param.WHOLE_NOTE = 1;
param.HALF_NOTE = 2;
param.QUARTER_NOTE = 3;
param.EIGTH_NOTE = 4;
param.SIXTEENTH_NOTE = 5;
param.HIGH_ATTEN = 75;
param.LOW_ATTEN = 25;
param.HIGH_VOL = 100;
param.LOW_VOL = 0;