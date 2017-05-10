% Prompts user to select a song from the songs folder
prompt = msgbox('Reading Song');
% Reads in an audio file
[filename, pathname] = uigetfile('songs/*.wav');
filename = sprintf('songs/%s',filename);
[clip, fs] = audioread(filename);

% generates a random 10 second sample of the selected song to identify
start = randi([0 floor(length(clip)/fs)-10],1,1);
stop = start+10;
z = clip(fs*start+1:1:fs*stop);

% plays audio file
sound(z,fs);                       
pause(10)
clear sound;
y = z';
close(prompt);

% Searches hash_table for a match
prompt = msgbox('Looking for Match');
matchID = match_segment(y,fs,hash_table,numberofSongs)
close(prompt);

songname = songTitle{matchID};
prompt = msgbox(songname);

