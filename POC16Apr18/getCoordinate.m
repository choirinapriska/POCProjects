function  [Q1,Q2,Q3,Q4] = getCoordinate(list,n,frame)   

   f = int16(n/2)-1;
   rep_x = -f:1:f;
   cur_x = 1:n;

   cur_y = 1:n;
   rep_y = f:-1:-f;
 
   data = list;

   dataA = rep_x(cur_x(data(:,:,5)));
   dataB = rep_y(cur_y(data(:,:,6)));
   
   a = 1;
   b = 1;
   c = 1;
   d = 1;
   
   header = {'BlokX' 'BlokY' 'X' 'Y' 'Tetha' 'Label'};
   
   Q1 = {};
   Q2 = {};
   Q3 = {};
   Q4 = {};
   
   for i = 1 : size(dataA,1)
       for j = 1 : size(dataA,2)
           X = single(dataA(i,j));
           Y = single(dataB(i,j));
           
           tetha = atan2d(Y,X) + 360*(Y<0);
           
           magnitude = (X * X) + (Y * Y) ;
           magnitude = sqrt(magnitude);
           
           if (X == 0 && Y ==0 )
           else
                if (tetha >= 0 && tetha < 90)
                   Q1(a,:) = {i j X Y tetha magnitude 'Q1'};   
                   a = a +1;
                elseif (tetha >= 90 && tetha < 180)
                   Q2(b,:) = {i j X Y tetha magnitude 'Q2'};  
                   b = b +1;
                elseif (tetha >= 180 && tetha < 270)
                   Q3(c,:) = {i j X Y tetha magnitude 'Q3'};  
                   c =c +1;
                elseif (tetha >= 270 && tetha <= 360)
                   Q4(d,:) = {i j X Y tetha magnitude 'Q4'};  
                   d = d +1; 
                end 
%                 if X >= 0 || Y >= 0 || tetha > 0 && tetha < 90
%                    Q1(a,:) = {i j X Y tetha magnitude 'Q1'};  
%                    a = a +1;
%                 elseif X <= 0 && Y >= 0 || tetha >= 90 && tetha < 180
%                    Q2(b,:) = {i j X Y tetha magnitude 'Q2'}; 
%                    
%                    b = b +1;
%                 elseif X <= 0 && Y <= 0 || tetha >= 180 && tetha < 270
%                    Q3(c,:) = {i j X Y tetha magnitude 'Q3'}; 
%                    
%                    c =c +1;
%                 elseif X >= 0 && Y <= 0 || tetha >= 270 && tetha <= 360
%                    Q4(d,:) = {i j X Y tetha magnitude 'Q4'};  
%                    d = d +1;
%                 end 
                
           end 
       end
   end
   
%    Q1 = cell2table(Q1,'VariableNames',{'Blok' 'X' 'Y' 'Tetha' 'Label'});
%    Q2 = cell2table(Q2,'VariableNames',{'Blok' 'X' 'Y' 'Tetha' 'Label'});
%    Q3 = cell2table(Q3,'VariableNames',{'Blok' 'X' 'Y' 'Tetha' 'Label'});
%    Q4 = cell2table(Q4,'VariableNames',{'Blok' 'X' 'Y' 'Tetha' 'Label'});
end

