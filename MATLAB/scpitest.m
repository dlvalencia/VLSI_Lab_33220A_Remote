clc, clearvars;
fclose(instrfind);
visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
waveformGen = visa('agilent', visaAddress);
%waveformGen.outputBufferSize = 100e6;
fopen(waveformGen);


%fprintf(waveformGen, ':source:FUNCTION:shape ramp');

%offset = 0;
%fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);

%amplitude = 1;
%fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);

%waveform = "square";
outputwaveform(waveformGen, 'ramp', 1, 1);

function [] = outputwaveform(waveformGen, waveform, offset, amplitude)

fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);

end
