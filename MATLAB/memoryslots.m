clc, clearvars;

fclose(instrfind);

visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
waveformGen = visa('agilent', visaAddress);
waveformGen.outputBufferSize = 100e6;
fopen(waveformGen);
%%
fprintf(waveformGen, 'OUTPUT:STATE 1');
%feature
%also we could clear all data here
fprintf(waveformGen, 'FUNCTION:USER EXP_RISE');
fprintf(waveformGen, 'DATA:delete:all');
%%
file = 'C:\Users\dlvalencia\Downloads\simulated_neural_recording\C_Easy1_noise01.mat';
fileStruct = load(file);
fileData = fileStruct.data;



for i = 0:2

in = i*48e3;
outData = fileData(1, 1 + in : in + 48e3);
outData = rescale(outData,-1,1); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1); % strip final comma

tic
fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
toc

%ver1 for volatile memory waveforms
%trying to utilize the memory slots the save time for sending data

%change to arb
%fprintf(waveformGen, ':source:function:shape:user volatile');
%fprintf(waveformGen, ':apply:user 0.5,1,0');

fprintf(waveformGen, 'DATA:COPY ARB_%d, VOLATILE',i);
%fprintf(waveformGen, 'DATA:delete:all');

%condition for playing next 2s

end

%start running wave 0
%then delete 0 while 1 starts running
fprintf(waveformGen, ':source:function:shape:user ARB_%d', 0);
fprintf(waveformGen, ':apply:user 0.5,1,0'); %0.5 frequency, depends on sample rate

for i = 3:29

in = i*48e3;
outData = fileData(1, 1 + in : in + 48e3);
outData = rescale(outData,-1,1); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1); % strip final comma

tic
fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
toc

%trying to utilize the memory slots the save time for sending data

fprintf(waveformGen, 'DATA:COPY ARB_%d, VOLATILE',i);

%change to arb
fprintf(waveformGen, ':source:function:shape:user ARB_%d', i-2);
fprintf(waveformGen, ':apply:user 0.5,1,0');
%fprintf(waveformGen, 'DATA:delete:Name ARB_%d', i-3);

%fprintf(waveformGen, 'DATA:COPY ARB_%d, VOLATILE',i);
%fprintf(waveformGen, 'DATA:delete:Name ARB_%d', i-4);

%sync


end



%fclose(instrfind);

%tic toc
%fprintf(waveformGen, ':source:function:shape:user volatile');


%DATA:DATA
%FUNC USER


