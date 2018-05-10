clc,clear;

% label = {'DISGUST','HAPPINESS','SADNESS','SURPRISE'};
label = {'HAPPINESS'};

for u = 1: size(label,1)
    fold  = dir([label{u} '/']);

    for i = 3 : size(fold,1) 
        fold2 = dir([label{u} '/' fold(i).name '/' ]);

        for j = 3 : size(fold2,1)
            fl = ['../EXCEL/' label{u} '/' fold(i).name '/'];
            mkdir(fl);

            fold3 = dir(fullfile([label{u} '/' fold(i).name '/' fold2(j).name '/' ],'*.mat')); 

            disp([label{u} '/' fold(i).name '/' fold2(j).name]);

            load([label{u} '/' fold(i).name '/' fold2(j).name '/Q1.mat']);
            load([label{u} '/' fold(i).name '/' fold2(j).name '/Q2.mat']);
            load([label{u} '/' fold(i).name '/' fold2(j).name '/Q3.mat']);
            load([label{u} '/' fold(i).name '/' fold2(j).name '/Q4.mat']);

            dt1 = extract(Q1);
            dt2 = extract(Q2);
            dt3 = extract(Q3);
            dt4 = extract(Q4);

            writetable(dt1,[fl fold2(j).name '.xls'],'Sheet',1);
            writetable(dt2,[fl fold2(j).name '.xls'],'Sheet',2);
            writetable(dt3,[fl fold2(j).name '.xls'],'Sheet',3);
            writetable(dt4,[fl fold2(j).name '.xls'],'Sheet',4);
        end
    end
end