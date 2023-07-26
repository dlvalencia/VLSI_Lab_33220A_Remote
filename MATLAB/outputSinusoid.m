%This Program outputs the ramp wave with given parameters
%Example Format to run code from command line
%outputSinusoid(waveformGen, 1000, 0, 1);

function errorMessage = outputSinusoid(waveformGen, frequency, offset, amplitude, varargin)

if(nargin ~= 4) 
    errorMessage = 1;
    return;
end

fprintf(waveformGen, ':source:FUNCTION:shape Sinusoid');
fprintf(waveformGen, ':source:frequency:CW %d', frequency);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);

errorMessage = 0;
return;
end