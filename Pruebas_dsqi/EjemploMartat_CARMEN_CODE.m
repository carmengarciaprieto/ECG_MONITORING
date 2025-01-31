
TEST = 0;

if (TEST)
    time_vector = 1:((7*60 + 59)*60); 
    
    files_TopM = {'M/TopM/n_Registro1_TopM_2023_10_19.txt', 
        'M/TopM/n_Registro2_TopM_2023-10-24_08-26-59.txt',
        'M/TopM/n_Regsitro3_TopM_2023-10-29_09-00-19.txt',
        'M/TopM/n_Registro4_TopM_2023-11-13_09-33-54.txt'};

    files_TopS = {'M/TopS/n_Registro1_TopS_2023-10-21.txt', 
        'M/TopS/n_Resgistro2_TopS_2023-10-26_08-52-56.txt',
        'M/TopS/n_Registro3_TopS_2023-10-30_08-33-05.txt',
        'M/TopS/n_Registro 4_TopS_2023-11-16_08-26-59.txt'};

    files_TopXS = {'M/TopXS/n_Registro1_topXS_2023_10_20.txt', 
        'M/TopXS/n_Registro2_TopXS_2023-10-27_11-04-10.txt',
        'M/TopXS/n_Registro3_TopXS_2023-11-03_08-25-57.txt',
        'M/TopXS/n_Registro4_TopXS_2023-11-20_08-17-57.txt'}; 
else
     time_vector = 1:(((7*60 + 59)*60)*1000-360000); 
     
     files_TopM = {'M/TopM/Registro1_TopM_2023_10_19.txt', 
        'M/TopM/Registro2_TopM_2023-10-24_08-26-59.txt',
        'M/TopM/Regsitro3_TopM_2023-10-29_09-00-19.txt',
        'M/TopM/Registro4_TopM_2023-11-13_09-33-54.txt'};

    files_TopS = {'M/TopS/Registro1_TopS_2023-10-21.txt', 
        'M/TopS/Resgistro2_TopS_2023-10-26_08-52-56.txt',
        'M/TopS/Registro3_TopS_2023-10-30_08-33-05.txt',
        'M/TopS/Registro 4_TopS_2023-11-16_08-26-59.txt'};

    files_TopXS = {'M/TopXS/Registro1_topXS_2023_10_20.txt', 
        'M/TopXS/Registro2_TopXS_2023-10-27_11-04-10.txt',
        'M/TopXS/Registro3_TopXS_2023-11-03_08-25-57.txt',
        'M/TopXS/Registro4_TopXS_2023-11-20_08-17-57.txt'}; 
 end



fileSets = {files_TopM, files_TopS, files_TopXS};
indexes = cell(1, length(fileSets)); % indexes = cell(1, length(fileSets)); -> vector de 3 pos

for setIndex = 1: length(indexes)
    currentFiles = fileSets{setIndex};% ej: currentFiles= fileSets{1} -> files_TopM ->(...,...,....,....)
    indexes{setIndex} = cell(1, length(currentFiles)); % indexes{1}= a un vector con 4 pos 

    for fileIndex = 1:length(currentFiles) % fileIndex = 1:length(currentFiles)=4
        data = ImportPluxData(currentFiles{fileIndex}, 3);
        ecg = data(time_vector);
        [kSQI_01_vector, sSQI_01_vector, pSQI_01_vector, rel_powerLine01_vector, cSQI_01_vector, basSQI_01_vector, dSQI_01_vector, geometricMean_vector, averageGeometricMean] = mSQI(ecg, 1000);
        indexes{setIndex}{fileIndex} = geometricMean_vector;
        fprintf("Average mean of windows of %s: %f\n", currentFiles{fileIndex}, averageGeometricMean);
    end
end

indexes_topM = indexes{1};
indexes_topS = indexes{2};
indexes_topXS = indexes{3};



%significance level for calculating the confidence intervals
alph = 0.01;
%number of iterations to use in boostrap
iter = 1000;

% Data for the Comparison Within Each Register
% data of topM that will be used for the CI
data_topM_R2R3R4 =[indexes_topM{2},indexes_topM{3},indexes_topM{4}]; % data_topM_R2R3R4 -> R2:register2, R3:register3, R4:register of  of topM
data_topM_R1R3R4 =[indexes_topM{1},indexes_topM{3},indexes_topM{4}];
data_topM_R1R2R4 =[indexes_topM{1},indexes_topM{2},indexes_topM{4}];
data_topM_R1R2R3 =[indexes_topM{1},indexes_topM{2},indexes_topM{3}];

% data of topS that will be used for the CI
data_topS_R2R3R4 =[indexes_topS{2},indexes_topS{3},indexes_topS{4}]; % data_topS_R2R3R4 -> R2:register2, R3:register3, R4:register of topS
data_topS_R1R3R4 =[indexes_topS{1},indexes_topS{3},indexes_topS{4}];
data_topS_R1R2R4 =[indexes_topS{1},indexes_topS{2},indexes_topS{4}];
data_topS_R1R2R3 =[indexes_topS{1},indexes_topS{2},indexes_topS{3}];

% data of topXS that will be used for the CI
data_topXS_R2R3R4 =[indexes_topXS{2},indexes_topXS{3},indexes_topXS{4}]; % data_topS_R2R3R4 -> R2:register2, R3:register3, R4:register of topS
data_topXS_R1R3R4 =[indexes_topXS{1},indexes_topXS{3},indexes_topXS{4}];
data_topXS_R1R2R4 =[indexes_topXS{1},indexes_topXS{2},indexes_topXS{4}];
data_topXS_R1R2R3 =[indexes_topXS{1},indexes_topXS{2},indexes_topXS{3}];


% Data for the Comparison Across Registers
data_topMvstopS_topXS=cell2mat([indexes_topS,indexes_topXS]); % cell2mat-> convert the contents of a cell array into a single matrix
data_topSvstopM_topXS=cell2mat([indexes_topM,indexes_topXS]);
data_topXSvstopM_topS=cell2mat([indexes_topM,indexes_topS]);


%CONFIDENCE INTERVALS (CI)
% Comparison Within Each Register of TopM Data
%CI for R1 vs {R2, R3 y R4}
CIMedian_topM_R1vsR2R3R4 = estimateCIMedian(indexes_topM{1},data_topM_R2R3R4,alph,iter);
CIMean_topM_R1vsR2R3R4 = estimateCIMean(indexes_topM{1},data_topM_R2R3R4,alph,iter);
%CI for R2 vs {R1, R3 y R4}
CIMedian_topM_R2vsR1R3R4 = estimateCIMedian(indexes_topM{2},data_topM_R1R3R4,alph,iter);
CIMean_topM_R2vsR1R3R4 = estimateCIMean(indexes_topM{2},data_topM_R1R3R4,alph,iter);
%CI for R3 vs {R1, R2 y R4}
CIMedian_topM_R3vsR1R2R4 = estimateCIMedian(indexes_topM{3},data_topM_R1R2R4,alph,iter);
CIMean_topM_R3vsR1R2R4 = estimateCIMean(indexes_topM{3},data_topM_R1R2R4,alph,iter);
%CI for R4 vs {R1, R2 y R3}
CIMedian_topM_R4vsR1R2R3 = estimateCIMedian(indexes_topM{4},data_topM_R1R2R3,alph,iter);
CIMean_topM_R4vsR1R2R3 = estimateCIMean(indexes_topM{4},data_topM_R1R2R3,alph,iter);

% Comparison Within Each Register of TopS Data
%CI for R1 vs {R2, R3 y R4}
CIMedian_topS_R1vsR2R3R4 = estimateCIMedian(indexes_topS{1},data_topS_R2R3R4,alph,iter);
CIMean_topS_R1vsR2R3R4 = estimateCIMean(indexes_topS{1},data_topS_R2R3R4,alph,iter);
%CI for R2 vs {R1, R3 y R4}
CIMedian_topS_R2vsR1R3R4 = estimateCIMedian(indexes_topS{2},data_topS_R1R3R4,alph,iter);
CIMean_topS_R2vsR1R3R4 = estimateCIMean(indexes_topS{2},data_topS_R1R3R4,alph,iter);
%CI for R3 vs {R1, R2 y R4}
CIMedian_topS_R3vsR1R2R4 = estimateCIMedian(indexes_topS{3},data_topS_R1R2R4,alph,iter);
CIMean_topS_R3vsR1R2R4 = estimateCIMean(indexes_topS{3},data_topS_R1R2R4,alph,iter);
%CI for R4 vs {R1, R2 y R3}
CIMedian_topS_R4vsR1R2R3 = estimateCIMedian(indexes_topS{4},data_topS_R1R2R3,alph,iter);
CIMean_topS_R4vsR1R2R3 = estimateCIMean(indexes_topS{4},data_topS_R1R2R3,alph,iter);

% Comparison Within Each Register of TopXS Data
%CI for R1 vs {R2, R3 y R4}
CIMedian_topXS_R1vsR2R3R4 = estimateCIMedian(indexes_topXS{1},data_topXS_R2R3R4,alph,iter);
CIMean_topXS_R1vsR2R3R4 = estimateCIMean(indexes_topXS{1},data_topXS_R2R3R4,alph,iter);
%CI for R2 vs {R1, R3 y R4}
CIMedian_topXS_R2vsR1R3R4 = estimateCIMedian(indexes_topXS{2},data_topXS_R1R3R4,alph,iter);
CIMean_topXS_R2vsR1R3R4 = estimateCIMean(indexes_topXS{2},data_topXS_R1R3R4,alph,iter);
%CI for R3 vs {R1, R2 y R4}
CIMedian_topXS_R3vsR1R2R4 = estimateCIMedian(indexes_topXS{3},data_topXS_R1R2R4,alph,iter);
CIMean_topXS_R3vsR1R2R4 = estimateCIMean(indexes_topXS{3},data_topXS_R1R2R4,alph,iter);
%CI for R4 vs {R1, R2 y R3}
CIMedian_topXS_R4vsR1R2R3 = estimateCIMedian(indexes_topXS{4},data_topXS_R1R2R3,alph,iter);
CIMean_topXS_R4vsR1R2R3 = estimateCIMean(indexes_topXS{4},data_topXS_R1R2R3,alph,iter);


% Histograms for each register of TopM
for i = 1:4
    figure;
    histogram(indexes_topM{i}, 20);
    title(['Histogram for indexes\_topM{' num2str(i) '}']);
end

% Histograms for each register of TopS
for i = 1:4
    figure;
    histogram(indexes_topS{i}, 20);
    title(['Histogram for indexes\_topS{' num2str(i) '}']);
end

% Histograms for each register of TopXS
for i = 1:4
    figure;
    histogram(indexes_topXS{i}, 20);
    title(['Histogram for indexes\_topXS{' num2str(i) '}']);
end

%histogram(indexes_topM{1}, 20)
%figure()
%histogram(geometricMean_V_24, 20)


indexes_topM_v = cell2mat(indexes_topM);
indexes_topS_v = cell2mat(indexes_topS);
indexes_topXS_v = cell2mat(indexes_topXS);

z_mean_indexes_topM = mean (indexes_topM_v);
z_var_indexes_topM = var(indexes_topM_v);
z_mean_indexes_topS = mean (indexes_topS_v);
z_var_indexes_topS = var(indexes_topS_v);
z_mean_indexes_topXS = mean (indexes_topXS_v);
z_var_indexes_topXS = var(indexes_topXS_v);


y_CIMedian_topMvstopS= estimateCIMedian(indexes_topM_v, indexes_topS_v, alph, iter);
y_CIMean_topMvstopS= estimateCIMean(indexes_topM_v, indexes_topS_v, alph, iter);

y_CIMedian_topMvstopXS= estimateCIMedian(indexes_topM_v, indexes_topXS_v, alph, iter);
y_CIMean_topMvstopXS= estimateCIMean(indexes_topM_v, indexes_topXS_v, alph, iter);

y_CIMedian_topSvstopXS= estimateCIMedian(indexes_topS_v, indexes_topXS_v, alph, iter);
y_CIMean_topSvstopXS= estimateCIMean(indexes_topS_v, indexes_topXS_v, alph, iter);


x_mean_indexes_topM = cellfun(@mean, indexes_topM);
x_mean_indexes_topS = cellfun(@mean, indexes_topS);
x_mean_indexes_topXS = cellfun(@mean, indexes_topXS);

x_var_indexes_topM = cellfun(@var, indexes_topM);
x_var_indexes_topS = cellfun(@var, indexes_topS);
x_var_indexes_topXS = cellfun(@var, indexes_topXS);

figure
histogram(indexes_topM_v, 20);
title(['Histogram for indexes top M']);

figure
histogram(indexes_topS_v, 20);
title(['Histogram for indexes top S']);

figure
histogram(indexes_topXS_v, 20);
title(['Histogram for indexes top XS']);


tiledlayout(3,1)

nexttile
histogram(indexes_topM_v, 20);
title(['Histogram for indexes top M']);

nexttile
histogram(indexes_topS_v, 20);
title(['Histogram for indexes top S']);

nexttile
histogram(indexes_topXS_v, 20);
title(['Histogram for indexes top XS']);
