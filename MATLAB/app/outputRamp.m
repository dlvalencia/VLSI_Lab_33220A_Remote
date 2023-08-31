%This Program outputs the ramp wave with given parameters
%Example Format to run code from command line
%outputRamp(waveformGen, 1000, 0, 1, 100);

function errorMessage = outputRamp(waveformGen, frequency, offset, amplitude, varargin)

if(nargin == 4)
    symmetry = 100; %default
else
    if(nargin == 5)
        symmetry = varargin{1,1};
    else 
        errorMessage = 1;
            return;
    end
end

fprintf(waveformGen, ':source:FUNCTION:shape ramp');
fprintf(waveformGen, ':source:frequency:CW %d', frequency);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);
fprintf(waveformGen, ':SOURce:FUNCtion:SHAPe:ramp:symmetry %d', symmetry);

errorMessage = 0;
return;
end