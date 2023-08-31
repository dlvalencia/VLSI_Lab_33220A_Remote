%function [] = outputwaveform(waveformGen, waveform, frequency, offset, amplitude)

%fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);

%outputwaveform_function('TCPIP0::130.191.161.194::inst0::INSTR', 'SINUSOID', 222, 1, 2, 70);

function errorMessage = outputwaveform_function(waveformGen, waveform, frequency, offset, amplitude, varargin)

%fclose(instrfind);

%visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR';
%waveformGen = visa('agilent', visaAddress);
%fopen(waveformGen);

if(nargin ~= 5)
        property = varargin{1,1};

        if(strcmp(waveform, "SINUSOID"))
            errorMessage = outputSinusoid(waveformGen, frequency, offset, amplitude);
        elseif(strcmp(waveform, "SQUARE"))
            errorMessage = outputSquare(waveformGen, frequency, offset, amplitude, property);
        elseif(strcmp(waveform, "RAMP"))
            errorMessage = outputRamp(waveformGen, frequency, offset, amplitude, property);
        end
        return;
end

    if(strcmp(waveform, "SINUSOID"))
        errorMessage = outputSinusoid(waveformGen, frequency, offset, amplitude);
    elseif(strcmp(waveform, "SQUARE"))
        errorMessage = outputSquare(waveformGen, frequency, offset, amplitude);
    elseif(strcmp(waveform, "RAMP"))
        errorMessage = outputRamp(waveformGen, frequency, offset, amplitude);
    end

end