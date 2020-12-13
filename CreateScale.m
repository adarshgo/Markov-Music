function [ scaleVect ] = CreateScale( noteCell )
%function [ scaleVect ] = CreateScale( noteCell )
%   Convert cell array of notes (in string format) to vector of note indices
% -----------------------------------------------
%
% Input:
%   noteCell -  Cell array of notes. Each cell contains one note specified
%               as follows:
%               C#4:  Indicates the note C sharp 4 (4th octave)
%               E5:   Indicates the note E 5 (5th octave)
%               Ab3:   Indicates the note A flat (3rd octave)
%               There are 88 supported notes as listed here: http://en.wikipedia.org/wiki/Piano_key_frequencies
%
% Output:
%   scaleVect - Vector of note indices in the range 1 - 88. Contains note
%               indices corresponding to the notes in noteCell.
    
    % Initialize scale vect
    scaleVect = zeros(1,length(noteCell));

    % Loop through notes in noteCel
    for i = 1:length(noteCell)
        str = noteCell{i}; % Extract note string from cell i
        note = str(1:end-1); % Extract note and whether it is flat or sharp
        octave = str2double(str(end)); % Extract octave
        
        if octave == 0
            
            switch note
                case {'A'}
                    scaleVect(i) = 1;
                case {'A#','Bb'}
                    scaleVect(i) = 2;
                case {'B'}
                    scaleVect(i) = 3;
                otherwise
                    fprintf('Note: %s\n',str);
                    error('ERROR: Unknown note');
            end
            
        elseif octave == 8
            
            switch note
                case {'C'}
                    scaleVect(i) = 88;
                otherwise
                    fprintf('Note: %s\n',str);
                    error('ERROR: Unknown note');
            end
            
        elseif 1 <= octave && octave <= 7
            switch note
                case {'C'}
                    scaleVect(i) = 4 + 12*(octave-1);
                case {'C#', 'Db'}
                    scaleVect(i) = 5 + 12*(octave-1);
                case {'D'}
                    scaleVect(i) = 6 + 12*(octave-1);
                case {'D#', 'Eb'}
                    scaleVect(i) = 7 + 12*(octave-1);
                case {'E'}
                    scaleVect(i) = 8 + 12*(octave-1);
                case {'F'}
                    scaleVect(i) = 9 + 12*(octave-1);
                case {'F#','Gb'}
                    scaleVect(i) = 10 + 12*(octave-1);
                case {'G'}
                    scaleVect(i) = 11 + 12*(octave-1);
                case {'G#','Ab'}
                    scaleVect(i) = 12 + 12*(octave-1);
                case {'A'}
                    scaleVect(i) = 13 + 12*(octave-1);
                case {'A#','Bb'}
                    scaleVect(i) = 14 + 12*(octave-1);
                case {'B'}
                    scaleVect(i) = 15 + 12*(octave-1);
                otherwise
                    fprintf('Note: %s\n',str);
                    error('ERROR: Unknown note');
            end
        else
            fprintf('Note %s\n',str);
        	error('ERROR: Octave is out of range or not specified');
        end  
    end
end

