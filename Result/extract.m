function [ dt ] = extract( Q1 )
%EXTRACT Summary of this function goes here
%   Detailed explanation goes here

    m = 1;
    for k = 1: size(Q1,1)
        data = Q1{k};

        if isempty(Q1{k}) == 1
             dt(m,:) = {num2str(k),'-','-','-','-','-','-','-'};
            m = m+1;
        else 
            for o = 1: size(data,1)
                dt(m,:) = {num2str(k) ,num2str(data{o,1}),num2str(data{o,2}),num2str(data{o,3}), num2str(data{o,4}) ,['"' num2str(data{o,5}) '"'], ['"' num2str(data{o,6}) '"'],num2str(data{o,7})};
                m = m+1;
            end
        end
    end
    
    dt = cell2table(dt, 'VariableName',{'FRAME','BlokX','BlokY','Koordinat_X','Koordinat_Y','TETHA','MAGNITUDE','LABEL'});
end

