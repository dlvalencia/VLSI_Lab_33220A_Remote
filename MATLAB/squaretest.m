filedata2 = ones(1,48000);
filedata2(1,24001:end) = -1;

allOneString = sprintf('%1.4f,', filedata2');
allOneString = allOneString(1:end-1);

fprintf(waveformGen, 'DATA VOLATILE, %s', allOneString);
%change to arb
fprintf(waveformGen, ':source:function:shape:user volatile');
fprintf(waveformGen, ':apply:user 1,1,0');