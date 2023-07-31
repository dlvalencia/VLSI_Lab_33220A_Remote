function [output1] = updateAddress(visaAddress,bufferSize)
    clc, clearvars;
       objs = instrfind;
    if ~isempty(objs)
     fclose(instrfind);   
    end
   
    waveformGen = visa('agilent', visaAddress);
    waveformGen.outputBufferSize = bufferSize;
    fopen(waveformGen);

    output1 = waveformGen;
    
end