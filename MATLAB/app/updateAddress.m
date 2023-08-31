function [output1,output2,output3] = updateAddress(visaAddress, bufferSize)
try
    objs = instrfind;
    if ~isempty(objs)
        fclose(instrfind);
    end

    waveformGen = visa('agilent', visaAddress);
    waveformGen.outputBufferSize = str2double(bufferSize); % Convert bufferSize to a numeric value
    fopen(waveformGen);

    output1 = waveformGen;
    output2 = true;
    output3 = "Successfully updated visa address and buffersize";
catch
    output1 = [],
    output2 = false;
    output3 = "Error with updating visa address or buffersize";
end
end
