%function [] = outputwaveform(waveformGen, waveform, frequency, offset, amplitude)

%fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);
outputwaveform_function1('TCPIP0::130.191.161.194::inst0::INSTR', 'RAMP', 1114, 1, 2, 2);

function [] = outputwaveform_function1(visaAddress, waveform, frequency, offset, amplitude, varargin)

if(nargin == 6)
        temp = varargin{1,1};
end

fclose(instrfind);
%visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR';
waveformGen = visa('agilent', visaAddress);
fopen(waveformGen);

    if(strcmp(waveform, "SINUSOID"))
        outputSinusoid(waveformGen, frequency, offset, amplitude, temp);
    elseif(strcmp(waveform, "SQUARE"))
        outputSquare(waveformGen, frequency, offset, amplitude, temp);
    elseif(strcmp(waveform, "RAMP"))
        outputRamp(waveformGen, frequency, offset, amplitude, temp);
    end

end