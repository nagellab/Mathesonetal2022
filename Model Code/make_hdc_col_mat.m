% Function that makes a matrix to uniformally transform activity from N=20 
% population (e.g. hDeltaC) to N=8 population (e.g. mutual inhibition).
% @param: N1 = size of population 1
% @param: N2 = size of population 2
% @output: uniform_mat = matrix mediating transformation
function hdc_col_mat = make_hdc_col_mat()
    motif1 = [0.12, 0.58, 0.98, 0.38, 0.22]/sum([0.12, 0.58, 0.98, 0.38, 0.22]); % Normalized
    motif2 = [0.62, 0.78, 0.88, 0.42, 0.02]/sum([0.62, 0.78, 0.88, 0.42, 0.02]); % Normalized
%     motif1 = [0.26, 0.66, 0.94, 0.54, 0.14]/sum([0.26, 0.66, 0.94, 0.54, 0.14]); % Normalized
%     motif2 = [0.06, 0.46, 0.86, 0.74, 0.34]/sum([0.06, 0.46, 0.86, 0.74, 0.34]); % Normalized

    hdc_col_mat = zeros(8, 20);
    hdc_col_mat(1, 1:3) = motif1(3:end);
    hdc_col_mat(1, 19:end) = motif1(1:2);
    hdc_col_mat(2, 2:6) = motif2;
    hdc_col_mat(3, 4:8) = motif1;
    hdc_col_mat(4, 7:11) = motif2;
    hdc_col_mat(5, 9:13) = motif1;
    hdc_col_mat(6, 12:16) = motif2;
    hdc_col_mat(7, 14:18) = motif1;
    hdc_col_mat(8, 17:20) = motif2(1:4);
    hdc_col_mat(8, 1) = motif2(end);
end