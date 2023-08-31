%This function executes a channel of the data imported/loaded into matlab
%and breaks it up into pieces to send points to the function generator to
%output the recorded waveform
%An example of running this function is
%outputArb(waveformGen, 24000, data, 1);

function errorMessage = outputArb(waveformGen, sampleRate, data, channel)

inmax = max(data(channel,1:end));
inmin = min(data(channel,1:end));
dataSize = size(data(channel,1:end),2);

%dealing with sample rate

rateFreq = floor(65535/sampleRate);
rate = rateFreq*sampleRate;
remainder = mod(dataSize,rate);
loopVariable = dataSize/rate - 1;

fprintf(waveformGen, 'OUTPUT:STATE 1');

for i = 0:loopVariable

in = i*rate;
outData = data(channel, 1 + in : in + rate);
outData = rescale(outData,-1,1,"InputMin",inmin,"InputMax",inmax); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1); % strip final comma

fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);

%change to arb
fprintf(waveformGen, ':source:function:shape:user volatile');
fprintf(waveformGen, ':apply:user %d,0.4,0.25', 1/rateFreq);
%offset = 0.5V

%condition for playing next 2s

end

%might want to find a replacement for this or else it is recommended to
%leave a blank space at the end of a recording to avoid repeats/cutoffs
%recommended pause time is 1 cycle or more

%remainder
if remainder ~= 0
outData = data(channel, end-remainder : end);
outData = rescale(outData,-1,1,"InputMin",inmin,"InputMax",inmax); 
allOneString = sprintf('%1.6f,', outData');
allOneString = allOneString(1:end-1);
fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
fprintf(waveformGen, ':source:function:shape:user volatile');
fprintf(waveformGen, ':apply:user %d,0.4,0.25', 1/rateFreq);
%offset = 0.5V
end

pause(3);

fprintf(waveformGen, ':output:state 0');

%fclose(instrfind);

%tic toc
%fprintf(waveformGen, ':source:function:shape:user volatile');


%DATA:DATA
%FUNC USER

end