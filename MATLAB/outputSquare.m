%This Program outputs the square wave with given parameters
%Example Format to run code from command line
%outputSquare(waveformGen, 1000, 0, 1, 40);

function errorMessage = outputSquare(waveformGen, frequency, offset, amplitude, varargin)

if(nargin == 4)
    dutyCycle = 50;
else 
    if(nargin == 5)
        dutyCycle = varargin{1,1};
    else 
        errorMessage = 1;
            return;
    end
end

fprintf(waveformGen, ':source:FUNCTION:shape square');
fprintf(waveformGen, ':source:frequency:CW %d', frequency);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);
fprintf(waveformGen, ':SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);
fprintf(waveformGen, ':SOURce:FUNCtion:SHAPe:SQUare:Dcycle %d', dutyCycle);

errorMessage = 0;
return;
end