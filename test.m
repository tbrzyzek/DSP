clear all; close all; clc;

songList = dir('songs');
numberofSongs = numel(songList)-2;
songTitle = [];
for k = 1:numberofSongs
    information = songList(k+2);
    songTitle{k} = information.name;
end
songTitle = songTitle';

prompt = msgbox('Creating Hash Table');
hash_table = createHash(200,songTitle);
close(prompt);

%%
prompt = msgbox('Reading Song');
% Reads in an audio file
[filename, pathname] = uigetfile('*.wav');
[clip, fs] = audioread(filename);

% generates a random 10 second sample of music to identify
start = randi([0 floor(length(clip)/fs)-10],1,1);
stop = start+10;
z = clip(fs*start+1:1:fs*stop);
%sound(z,Fs);                        % plays audio file
%pause(10)
%clear sound;
y = z';
close(prompt);


%%
prompt = msgbox('Looking for Match');
matchID = match_segment(y,fs,hash_table,numberofSongs)
close(prompt);







