function connected = checkConnection(waveformGen)
    try
        % Try to open the VISA connection
        disp('Trying to open VISA connection...');
        fopen(waveformGen);

        % If the connection is successful, perform further operations here
        disp('VISA connection to the waveform generator is good.');
        connected = true;

        % Close the connection when done
        fclose(waveformGen);
        delete(waveformGen);
    catch
        % Handle the case where the connection could not be established
        disp('Error: Unable to establish a VISA connection to the waveform generator.');
        connected = false;
    end
end
