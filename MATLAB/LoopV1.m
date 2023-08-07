clc, clearvars;

%fclose(instrfind);

visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
waveformGen = visa('agilent', visaAddress);
waveformGen.outputBufferSize = 100e6;
fopen(waveformGen);
%%
%fprintf(waveformGen, 'OUTPUT:STATE 1');
%fprintf(waveformGen, 'FUNCTION:USER EXP_RISE');
%%
fileStruct = load('C:\Users\dlvalencia\Downloads\simulated_neural_recording\C_Easy1_noise01.mat');
fileData = fileStruct.data;

%fileData -> data 
%change in new function file
%since data will be imported
inmax = max(fileData);
inmin = min(fileData);
size(fileData,2)

fprintf(waveformGen, 'OUTPUT:STATE 1');
for i = 0:29

in = i*48e3;
outData = fileData(1, 1 + in : in + 48e3);
outData = rescale(outData,-1,1,"InputMin",inmin,"InputMax",inmax); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1); % strip final comma

tic
fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
toc

%ver1 for volatile memory waveforms
%trying to utilize the memory slots the save time for sending data

%change to arb
fprintf(waveformGen, ':source:function:shape:user volatile');
fprintf(waveformGen, ':apply:user 0.5,1,0');

%condition for playing next 2s

end

%might want to find a replacement for this or else it is recommended to
%leave a blank space at the end of a recording to avoid repeats/cutoffs
%recommended pause time is 1 cycle or more
pause(3);

fprintf(waveformGen, ':output:state 0');
fclose(instrfind);

%fclose(instrfind);

%tic toc
%fprintf(waveformGen, ':source:function:shape:user volatile');


%DATA:DATA
%FUNC USER


