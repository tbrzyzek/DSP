% Initializes the database of songs from the songs folder in the directory
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