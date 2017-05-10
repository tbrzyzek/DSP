function bestMatchID = match_segment(clip, fs,hash_table,numSongs)
%  match_segment() takes a sound clip and the sampling frequency and
%  attempts to find the best match within the loaded song database

hash_size = size(hash_table, 1);
% Find peak pairs from the clip
peaks = fingerprints(clip, fs);

% Construct the cell of matches
matches = cell(numSongs, 1);
for k = 1:length(peaks)
    % Calculate hash 
    hash = mod(peaks(k),hash_size) + 1;
    
    % If an entry exists with this hash, find the song(s) with matching peak pairs
    if (~isempty(hash_table{hash, 1}))
        match_ID = hash_table{hash, 1}; % row vector of collisions
        match_time = hash_table{hash, 2}; % row vector of collisions
        
        % Calculate the time difference between clip pair and song pair
        time_diff = match_time - peaks(k);
        % Add matches to the lists for each individual song
        for n = 1:numSongs
            i = find(match_ID == n);
            matches{n} = [matches{n} time_diff(i)];
        end
      
    end
end

% Find the counts of the mode of the time offset array for each song
modes = zeros(numSongs, 2);
for k = 1:numSongs
   [modes(k, 1) modes(k, 2)] = mode(matches{k});
end

% Get the id of the best match (one with the most occurences of a certain
% offset).
[m, i] = max(modes(:, 2));
bestMatchID = i;
end