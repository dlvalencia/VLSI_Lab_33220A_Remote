function openclose(waveformGen, inputArg, connected)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if connected

    if inputArg == 0
        fprintf(waveformGen, 'OUTPUT:STATE 0');
    else
        fprintf(waveformGen, 'OUTPUT:STATE 1');
    end
end
end