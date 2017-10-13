function y=invZigzag(x)
% inverse transform from the zigzag format to the matrix form

row=round(sqrt(length(x)));

if row*row~=length(x)
   disp('invZigzag() fails!! Must be a square matrix!!');
   return;
end;

y=zeros(row,row);
count=1;
for s=1:row
   if mod(s,2)==0
      for m=s:-1:1
         y(m,s+1-m)=x(count); 
         count=count+1;
      end;
   else 
      for m=1:s
         y(m,s+1-m)=x(count); 
         count=count+1;
      end;
   end;
end;

if mod(row,2)==0
   flip=1;
else
   flip=0;
end;

for s=row+1:2*row-1
   if mod(flip,2)==0
      for m=row:-1:s+1-row
         y(m,s+1-m)=x(count); 
         count=count+1;
      end;
   else 
      for m=row:-1:s+1-row
         y(s+1-m,m)=x(count);
         count=count+1;
      end;
   end;
   flip=flip+1;
end;
