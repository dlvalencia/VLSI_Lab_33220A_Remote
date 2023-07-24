function [] = outputwaveform(waveformGen, waveform, offset, amplitude)

fprintf(waveformGen, ':source:FUNCTION:shape %s', waveform);
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:OFFSET %d', offset);
fprintf(waveformGen, 'SOURce:VOLTage:LEVel:IMMediate:amplitude %d', amplitude);

end
