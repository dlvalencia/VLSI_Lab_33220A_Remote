function [output1,output2,output3] = initialize
try
    clc, clearvars;

    fclose(instrfind);

    objs = instrfind;
    if ~isempty(objs)
        fclose(instrfind);
    end

    visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
    waveformGen = visa('agilent', visaAddress);
    waveformGen.outputBufferSize = 100e6;
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