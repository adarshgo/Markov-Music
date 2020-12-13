% Demo 2: Markov Chain Music Test 
parameters % Load parameters from parameters.m

% Initialize 240 seconds of song samples 
song = zeros(1,240*param.Fs);

% Set the state set to the notes of the A Major scale 
stateSet = param.AMajor;

% Initialize the transition probability matrix 
% (8x8 matrix since there are 8 notes in the A Major scale) 
% NOTE: The ellipsis (...) allow you to continue your code on the next line. 
stateTPF = [0.25 0.5 0 0 0 0 0 0.25;... 
            0.25 0.5 0.25 0 0 0 0 0;... 
            0 0.25 0.5 0.25 0 0 0 0;... 
            0 0 0.25 0.5 0.25 0 0 0;... 
            0 0 0 0.25 0.5 0.25 0 0;... 
            0 0 0 0 0.25 0.5 0.25 0;... 
            0 0 0 0 0 0.25 0.5 0.25;... 
            0.25 0 0 0 0 0 0.5 0.25];
stateIdx = 1; % Start in 1st state 
start = 1; % Index of first audio sample 
for k = 1:4 % Generate 4 unique bars 
for i = 1:60 % Generate 60 notes %first easy modification 
    note = stateSet(stateIdx); % Get note corresponding to current state index 
    duration = param.durationSet(3); % All 1/4 notes 
    intensity = param.intensitySet(40); % All maximum intensity 
    attenuation = param.attenuationSet(45); % All high attenuation 
    [song ,next] = AddNote(song ,start ,note ,duration ,intensity , attenuation ,param); 
    start = next; % Index of next audio sample

    % Markov state transition 
    stateIdx = rando(stateTPF(stateIdx ,:)); % Get random next state
end
end

for i = 1:50 % Generate 50 notes % followed by a 4th bar
    note = param.DMajor(stateIdx); % use DMajor
    duration = param.durationSet(3); % All 1/4 notes 
    intensity = param.intensitySet(30); % All maximum intensity 
    attenuation = param.attenuationSet(35); % All high attenuation 
    [song ,next] = AddNote(song ,start ,note ,duration ,intensity , attenuation ,param); 
    start = next; % Index of next audio sample

    % Markov state transition 
    stateIdx = rando(stateTPF(stateIdx ,:)); % Get random next state
end

for i = 1:40 % Generate 40 notes
    note = param.CMajor(stateIdx); % use CMajor
    duration = param.durationSet(2); % All 1/4 notes 
    intensity = param.intensitySet(20); % All maximum intensity 
    attenuation = param.attenuationSet(25); % All high attenuation 
    [song ,next] = AddNote(song ,start ,note ,duration ,intensity , attenuation ,param); 
    start = next; % Index of next audio sample

    % Markov state transition 
    stateIdx = rando(stateTPF(stateIdx ,:)); % Get random next state
end

mySong = song(1:next); % Remove empty samples from song
PlayTune(mySong ,param); % Play your tune!

% Save your tune to Govindarajan_Adarsh.wav

SaveTune(mySong ,param , 'Govindarajan_Adarsh');
