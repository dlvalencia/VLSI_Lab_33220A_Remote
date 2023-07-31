function openclose(waveformGen, inputArg)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    if inputArg == 0
        fprintf(waveformGen, 'OUTPUT:STATE 0');
    else
        fprintf(waveformGen, 'OUTPUT:STATE 1');
    end
end