function ia_save(save_name,level_difference,time_difference,direction_matrix,...
                 n_directions,sampling_rate,frq_axis,comment)

% function ia_save(save_name,level_difference,time_difference,direction_matrix,...
%                  n_directions,sampling_rate,frq_axis,comment)
%
% IA_SAVE saves the evaluated interaural level and time differences in the
%         MTLSIG - format. For each direction is stored only one channel,
%         that includes the interaural differences. The frequencies for which
%         the interaural differences are evaluated are stored, too. This is
%         done like a storage for nonlinear signals.
%
%         Description of the input arguments:
%         - save_name: filename for the storage
%         - level_difference: matrix including the interaural level
%                             differences. Each row represents one direction,
%                             each column represents the level differences
%                             for a certain frequency.
%         - time_difference: matrix including the interaural time differences.
%                            Each row represents one direction, each column
%                            represents the level differences for a certain
%                            frequency.
%         - direction_matrix: matrix including the elevation and azimuth
%                             angle of the different directions. The first
%                             row includes the elevation, the second row
%                             the azimuth. Each column represents a
%                             direction.
%         - n_directions: number of directions
%         - sampling_rate
%         - frq_axis: vector including the frequencies in [Hz], for which
%                     the interaural differences are evaluated.
%         - comment: commentary included in MTLSIG and SIGMAP files.
%
%         For further information see: MTLSIG manuals
%
% (c) Lehrstuhl fuer allg. Elektrotechnik und Akustik
% Ruhr-Universitaet Bochum
% (p) 09.09.1994 Joerg Schmatter


[fid,message] = fopen(save_name,'w','ieee-le');
if fid==-1          % file can't be opened
  disp(message);
  return;
end;

zero = '0';
file_type = 11;
channels = 1;
n_iaural = length(frq_axis);
info_blocks = gauss((n_directions * 8 + n_iaural * 4) / 256 +2);
file_channels = n_directions * channels;
eof = 26;

number_of_zeros = 79 - 0;
for i=0:number_of_zeros
  fwrite(fid,zero,'char');
end;

fseek(fid,79,'bof');
fwrite(fid,eof,'int8');
fwrite(fid,file_type,'short');
fwrite(fid,info_blocks,'short');
fwrite(fid,file_channels,'short');
fseek(fid,86,'bof');

number_of_zeros = 128 - 86;
for i=0:number_of_zeros
  fwrite(fid,zero,'char');
end;

fseek(fid,128,'bof');
fwrite(fid,n_iaural,'long');
fwrite(fid,sampling_rate,'float32');
fwrite(fid,frq_axis(1),'float32');
fwrite(fid,frq_axis(n_iaural),'float32');
fseek(fid,144,'bof');

number_of_zeros = 220 - 144;
for i=0:number_of_zeros
  fwrite(fid,zero,'char');
end;

fseek(fid,220,'bof');
fwrite(fid,n_directions,'short');
fwrite(fid,comment,'uchar');
fseek(fid,422,'bof');

number_of_zeros = 512 - 422;
for i=0:number_of_zeros
  fwrite(fid,zero,'char');
end;

fseek(fid,512,'bof');
for i=1:n_directions
  fwrite(fid,direction_matrix(1,i),'float32');
  fwrite(fid,direction_matrix(2,i),'float32');
end;

for i=1:n_iaural
  fwrite(fid,frq_axis(i),'float32');
end;

number_of_zeros = info_blocks * 256 - n_directions * 8 - n_iaural * 4;
for i=0:number_of_zeros
  fwrite(fid,zero,'char');
end;

% output of data

fseek(fid,info_blocks*256,'bof');
for i=1:n_directions
  for j=1:n_iaural
   fwrite(fid,level_difference(i,j),'float32');
   fwrite(fid,time_difference(i,j),'float32');
  end;
end;

fclose(fid);