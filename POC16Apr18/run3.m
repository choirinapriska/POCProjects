%  
% X =0;
% Y =1;
% 
% % tetha = (atan2(Y,X))*(180/pi);
% tetha = atan2d(Y,X) + 360*(Y<0);
% disp(tetha);
% 
% % rad = atan2(y,x);
% % rad[rad < 0] = rad[rad < 0] + 2*pi;
% % tetha = rad*(180/pi);
% % disp(tetha);
% 
% magnitude = (X * X) + (Y * Y) ;
% magnitude = sqrt(magnitude);
% disp(magnitude);
%  if (X == 0 && Y ==0 )
%    else
%         if X >= 0 && Y >= 0 || tetha >= 0 && tetha < 90
%           disp('Q1');
%         elseif X <= 0 && Y >= 0 || tetha >= 90 && tetha < 180
%             disp('Q2');
%         elseif X <= 0 && Y <= 0 || tetha >= 180 && tetha < 270
%           disp('Q3');
%         elseif X >= 0 && Y <= 0 || tetha >= 270 && tetha <= 360
%            disp('Q4');
%         end 
%  end
% 
% 


list = output{1};
n = 9;

f = int16(n/2)-1;
   rep_x = -f:1:f;
   cur_x = 1:n;

   cur_y = 1:n;
   rep_y = f:-1:-f;
 
   data = list;

   dataA = rep_x(cur_x(data(:,:,5)));
   dataB = rep_y(cur_y(data(:,:,6)));
   disp(dataA)  
   disp(dataB) 
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
           
%            if i == 1 && j == 6
              
%            end
           tetha = atan2d(Y,X) + 360*(Y<0);
            disp([num2str(X) ]);
               disp([ 'teta ' num2str(tetha) ]);
           
           magnitude = (X * X) + (Y * Y) ;
           magnitude = sqrt(magnitude);
                      
           if (X == 0 && Y ==0 )
           else
               
                if (tetha >= 0 && tetha < 90)
                   Q1(a,:) = {i j X Y tetha magnitude 'Q1'};  
                   disp('Q1')
                   a = a +1;
                elseif (tetha >= 90 && tetha < 180)
                   Q2(b,:) = {i j X Y tetha magnitude 'Q2'}; 
                   disp('Q2')
                   b = b +1;
                elseif (tetha >= 180 && tetha < 270)
                   Q3(c,:) = {i j X Y tetha magnitude 'Q3'}; 
                   disp('Q3')
                   c =c +1;
                elseif (tetha >= 270 && tetha <= 360)
                   Q4(d,:) = {i j X Y tetha magnitude 'Q4'};  
                   d = d +1;
                   disp('Q4')
                end 
                
           end 
           
           
       end
   end