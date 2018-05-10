
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % Left Eyebrow    = 1 - 5
% % Right Eyebrow   = 6 - 10
% % Left Eyes       = 20 - 25
% % Right Eyes      = 26 - 31
% % Nose            = 11 - 19
% % mouth           = 32 - 49
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

warning('off','images:initSize:adjustingMag');

clear; close all; clc;
addpath(genpath('.'));
MyWorkDir = genpath('../');
addpath(MyWorkDir, '-end');

% % Load Models
fitting_model='../models/Chehra_f1.0.mat';
load(fitting_model);    

FD      = vision.CascadeObjectDetector();
catTipe = {'AlisKiri' 'AlisKanan' 'MataKiri' 'MataKanan' 'Mulut' 'Dahi' 'All'};
locFig  = {'northwest' 'north' 'northeast' 'southwest' 'south' 'southeast'};
% labelName = {'DISGUST','HAPPINESS','SADNESS','SURPRISE'};
labelName = {'HAPPINESS'};
% % INPUT USER

% catTipe{1} = AlisKiri
% catTipe{2} = AlisKanan
% catTipe{3} = MataKiri
% catTipe{4} = MataKanan
% catTipe{5} = Mulut
% catTipe{6} = Dahi
% catTipe{7} = All
tipeFeat   = catTipe{7}; % type feature
is_show    = 'off'; % set figure on or off

fold = '../test_images/sequence/DATATEST/';
com        = 1; 
block      = 9; 

for mn = 1: length(labelName)
    label      = labelName{mn}; % label for dataset
    labelDir   = dir([fold label '/']); 
    
    for fdd = 3: length(labelDir)
        nFold      = [fold label '/' labelDir(fdd).name '/'];
        disp(nFold);
        imFol       = dir(fullfile(nFold,'*.jpg'));
        imFol       = natsortfiles({imFol.name});
        sMax       = size(imFol,2);
    %     nmFoldRes  = ['../results/sequence/' nmFold];
    %     disp('Get Data.........');
        disp(nFold);
        if(sMax > 0)
            for tp = 1: length(catTipe)-1
                for frame = 1: numel(imFol)-1
                    % % name file
                    nameFile1 = [nFold imFol{com}];
                    nameFile2 = [nFold imFol{frame+1}];

                    % % Load Image
                    img0 = imread(nameFile1);
                    img1 = imread(nameFile2);


                    if frame == 1
                         bbox = step(FD, img0);
                    else
                         bbox = [bbox(1),bbox(2),bbox(3),bbox(4)];
                    end

                    img0  = imcrop(img0, bbox);
                    img1  = imcrop(img1, bbox);

                    [input0, init0] = getLandmark(img0,refShape,[0,0,bbox(3),bbox(4)]);
                    [input1, init1] = getLandmark(img1,refShape,[0,0,bbox(3),bbox(4)]);

                    MaxIter=6;

                    if frame == 1 
                         points = Fitting(input0,init0,RegMat,MaxIter);
                    else
                         points = [points(:,1), points(:,2)];
                    end

                    [imgFeature0,bboxFeat0] = getFeaturesFace(points,input0,catTipe{tp});
                    [imgFeature1,bboxFeat1] = getFeaturesFace(points,input1,catTipe{tp});    

                    numCat = size(catTipe,2)-1;  

                    w = figure('Name', num2str(tipeFeat),'visible',is_show);
                    movegui(w,locFig{1});

                    header = {'Frame' ['Rx' tipeFeat] ['Ry' tipeFeat] ['R' tipeFeat] ['Teta' tipeFeat] ['Sum' tipeFeat] ['Label' tipeFeat]};
                    sName{1,1} = tipeFeat;

                    [poc{frame},output{frame}]  = getPOC(imgFeature0, imgFeature1,block);
                    [Q1{frame},Q2{frame},Q3{frame},Q4{frame}]=getCoordinate(output{frame},block,frame);
                    quiv(frame,7:7) = {label};

                    save(['../Result/' label '/' labelDir(fdd).name '/' catTipe{tp} '/' 'output-' catTipe{tp} '.mat'  ],'output');
                    
                    disp(['=========================' num2str(frame) '===============================']);
                end

                mkdir(['../Result/'  label '/' labelDir(fdd).name '/' catTipe{tp} '/']);

                Q1 = transpose(Q1);
                Q2 = transpose(Q2);
                Q3 = transpose(Q3);
                Q4 = transpose(Q4);
                
                disp(['=========================' catTipe{tp} '===============================']);
 
%                 save(['../Result/' label '/' labelDir(fdd).name '/' catTipe{tp} '/' 'Q1.mat'  ],'Q1');
%                 save(['../Result/' label '/' labelDir(fdd).name '/' catTipe{tp} '/' 'Q2.mat'  ],'Q2');
%                 save(['../Result/' label '/' labelDir(fdd).name '/' catTipe{tp} '/' 'Q3.mat'  ],'Q3');
%                 save(['../Result/' label '/' labelDir(fdd).name '/' catTipe{tp} '/' 'Q4.mat'  ],'Q4'); 

                 
            end
        else
            disp('Folder Tidak Ditemukan');
        end
    end
end
