%This function executes a data/variable imported/loaded into matlab a
%breaks it up into pieces to send points to the function generator to
%output the recorded waveform
%An example of running this function is
%outputArb(waveformGen, 24000, data);

function errorMessage = outputArb(waveformGen, sampleRate, data)

inmax = max(data);
inmin = min(data);
dataSize = size(data,2);

%dealing with sample rate

rateFreq = floor(65535/sampleRate);
rate = rateFreq*sampleRate;
remainder = mod(dataSize,rate);
loopVariable = dataSize/rate - 1;

fprintf(waveformGen, 'OUTPUT:STATE 1');

for i = 0:loopVariable

in = i*rate;
outData = data(1, 1 + in : in + rate);
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
fprintf(waveformGen, ':apply:user %d,0.25,0.5', 1/rateFreq);
%offset = 0.5V

%condition for playing next 2s

end

%might want to find a replacement for this or else it is recommended to
%leave a blank space at the end of a recording to avoid repeats/cutoffs
%recommended pause time is 1 cycle or more

%remainder
outData = data(1, end-remainder : end);
outData = rescale(outData,-1,1,"InputMin",inmin,"InputMax",inmax); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1);
fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
fprintf(waveformGen, ':source:function:shape:user volatile');
fprintf(waveformGen, ':apply:user %d,0.25,0.5', 1/rateFreq);
%offset = 0.5V

pause(3);

fprintf(waveformGen, ':output:state 0');

%fclose(instrfind);

%tic toc
%fprintf(waveformGen, ':source:function:shape:user volatile');


%DATA:DATA
%FUNC USER

end