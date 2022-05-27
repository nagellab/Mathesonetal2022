% Function that takes FB columnar vector and shifts every value by 180
% degrees.
% @param vector_init: inital FB columnar vector (ith value corresponds
% with activity in ith FB column)
% @output vector_shift: phase shifted FB columnar vector
function [vector_shift] = phase_shift(vector_init)
    % Initialize vector to hold shifted values
    vector_shift = zeros(size(vector_init)); 
    
    % Loop through columns
    for col = 1:length(vector_init) 
        % Shift column by half of the number of columns
        col_shift = col + length(vector_init)/2; 
        
        % Wrap if necessary
        if col_shift > length(vector_init) 
            col_shift = col_shift - length(vector_init);
        end
        
        % Add activity value to new phase shifted column position
        vector_shift(col_shift) = vector_init(col); % Add
    end
end