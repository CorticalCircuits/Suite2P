function ops = write_reg_to_tiff(fid, ops, iplane, isRED)
% 190122_SPD I changed this to write the reg files in 32 bit

disp('write_reg_to_tiff')
Ly = ops.Ly;
Lx = ops.Lx;
% bitspersamp = 16;
bitspersamp = 32;


frewind(fid);
for k = 1:length(ops.SubDirs)
    ix = 0;    
    nframesleft = ops.Nframes(k);
    
    datend = [];
    while nframesleft>0
         ix = ix + 1;
        nfrtoread = min(nframesleft, 2000);
        
        if strcmp(ops.which2p,'prairie')==1
            data = fread(fid,  Ly*Lx*nfrtoread, '*int16');
        elseif strcmp(ops.which2p,'sci')==1
%             data = fread(fid,  Ly*Lx*nfrtoread, 'single');
            data = fread(fid,  Ly*Lx*nfrtoread, '*int16');
        else
            error('Unknown microscope field: should be ''sci'' or ''prairie''')
        end
        data = single(data);
%         data = fread(fid,  Ly*Lx*nfrtoread, 'int16');                
        nframesleft = nframesleft - nfrtoread;
        data = reshape(data, Ly, Lx, []);        

         % this is now done in a separate function
%         if ix==1
%             navg = min(size(data,3), ops.nimgbegend);
%             ops.mimg_beg(:,:,k) = mean(data(:,:,1:navg), 3);
%         end
%         if nframesleft<ops.nimgbegend
%             nconc = min(ops.nimgbegend - nframesleft, nfrtoread);
%             datend = cat(3, datend, data(:,:,(nfrtoread-nconc+1):nfrtoread));
%         end
%         if nframesleft<=0
%              ops.mimg_end(:,:,k) = mean(datend, 3);
%         end
        
        foldr = fullfile(ops.RegFileTiffLocation, ops.mouse_name, ops.date, ...
            ops.SubDirs{k}, sprintf('Plane%d', iplane));
        if ~exist(foldr, 'dir')
            mkdir(foldr)
        end
        if isRED
            partname = sprintf('%s_%s_%s_2P_plane%d_%d_RED.tif', ops.date, ops.SubDirs{k}, ...
                ops.mouse_name, iplane, ix);
        
        else
            partname = sprintf('%s_%s_%s_2P_plane%d_%d.tif', ops.date, ops.SubDirs{k}, ...
            ops.mouse_name, iplane, ix);
                    
        end
        fname = fullfile(foldr, partname);
        
%         TiffWriter(int16(data),fname,bitspersamp);
        TiffWriter(int32(data),fname,bitspersamp);

    end
end
