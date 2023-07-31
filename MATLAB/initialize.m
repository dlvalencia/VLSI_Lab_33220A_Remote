function [output1] = initialize
    clc, clearvars;
    
    objs = instrfind;
    if ~isempty(objs)
     fclose(instrfind);   
    end
   
    visaAddress = 'TCPIP0::130.191.161.194::inst0::INSTR'; % Replace with your device address
    waveformGen = visa('agilent', visaAddress);
    waveformGen.outputBufferSize = 100e6;
    fopen(waveformGen);

    output1 = waveformGen;
    
end