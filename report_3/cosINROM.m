i=1;
for index = -32:1:31
        mod_vec(i)=rem(index,2*pi);
        i=i+1;
end ;
mod_vec=sfi(mod_vec,32,28);
bin(mod_vec)
thres_vec(1)=0;
fid=fopen('romdata.txt','w');
fwrite(fid,bin(mod_vec));
