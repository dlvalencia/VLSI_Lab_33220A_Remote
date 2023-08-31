%Close open ports
clc;
clearvars;
if ~isempty(instrfindall)
    fclose(instrfindall);
end
software_buffer_size = 8192;
%Open the port
board_serial = serial('COM4', 'BaudRate', 115200, 'InputBufferSize', software_buffer_size*4);

fopen(board_serial);

data_cumul = [];
energy = @(x) (x(1, 2:end-1).^2 - x(1, 1:end-2).*x(1, 3:end));
while true
    while(board_serial.BytesAvailable < software_buffer_size*4)
    end

    board_data = char(fread(board_serial, board_serial.BytesAvailable, "char"));

    %Reformat it into four columns
    board_data_reshape = reshape(board_data, [4, software_buffer_size])';

    data_double = str2double(string(board_data_reshape))';

    data_cumul = [data_cumul data_double];
    figure(1)
    plot(data_cumul, '-b');
    hold on
    plot(rescale(energy(data_cumul), 0, 4095), '-r');
    hold off
    legend('XADC Readings', 'Signal Energy');
    drawnow;
end