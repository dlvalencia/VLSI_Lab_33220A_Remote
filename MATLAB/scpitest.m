%clc, clearvars;
fclose(instrfind);

visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
waveformGen = visa('agilent', visaAddress);
%waveformGen.outputBufferSize = 100e6;
fopen(waveformGen);

%outputwaveform(waveformGen, 'ramp', 0, 1);

function [] = outputwaveform(waveformGen, waveform, offset, amplitude)

fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);
%frequency
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);

end
