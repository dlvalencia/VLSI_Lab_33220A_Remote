%function [] = outputwaveform(waveformGen, waveform, frequency, offset, amplitude)

%fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);
outputwaveform_function1('TCPIP0::130.191.161.194::inst0::INSTR', 'SQUARE', 1234, 1, 2, 45);

function [] = outputwaveform_function1(visaAddress, waveform, frequency, offset, amplitude, varargin)

if(nargin == 6)
        temp = varargin{1,1};
end

waveformGen = visa('agilent', visaAddress);
fopen(waveformGen);

    if(strcmp(waveform, "SINUSOID"))
        outputSinusoid(waveformGen, frequency, offset, amplitude, temp);
    elseif(strcmp(waveform, "SQUARE"))
        outputSquare(waveformGen, frequency, offset, amplitude, temp);
    elseif(strcmp(waveform, "RAMP"))
        outputRAMP(waveformGen, frequency, offset, amplitude, temp);
    end

end