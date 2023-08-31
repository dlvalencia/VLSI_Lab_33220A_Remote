function [output1,output2,output3] = initialize
try
    clc, clearvars;

    %fclose(instrfind);

    objs = instrfind;
    if ~isempty(objs)
        fclose(instrfind);
    end

    visaAddress = 'USB0::0x0957::0x0407::MY44008026::0::INSTR'; % Replace with your device address
    waveformGen = visa('agilent', visaAddress);
    waveformGen.outputBufferSize = 100e6;

    waveformGen.inputBufferSize = 1000;

    fopen(waveformGen);

    output1 = waveformGen;
    output2 = visaAddress;
    output3 = true;
catch
    output1 = [];
    output2 = '';
    output3 = false;
end
end