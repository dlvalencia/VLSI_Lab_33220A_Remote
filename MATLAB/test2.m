clc, clearvars;

fclose(instrfind);

visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
waveformGen = visa('agilent', visaAddress);
waveformGen.outputBufferSize = 100e6;
fopen(waveformGen);
%%
fprintf(waveformGen, 'OUTPUT:STATE 1');
fprintf(waveformGen, 'FUNCTION:USER EXP_RISE');
%%
fileStruct = load('C:\Users\dlvalencia\Downloads\simulated_neural_recording\C_Easy1_noise01.mat');
fileData = fileStruct.data;



for i = 0:29

in = i*48e3;
outData = fileData(1, 1 + in : in + 48e3);
outData = rescale(outData,-1,1); 
allOneString = sprintf('%1.4f,', outData');
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



%fclose(instrfind);

%tic toc
%fprintf(waveformGen, ':source:function:shape:user volatile');


%DATA:DATA
%FUNC USER


