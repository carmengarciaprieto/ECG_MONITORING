
sampling_rate = 1000; 

start_time = 30;
end_time = 5 * 60 + 30; 

time_vector = (start_time * sampling_rate):(end_time * sampling_rate);


    files_pequeno_tumbada = {'1_peque“o_tumbada.txt', 
                  '2_peque“o_tumbada.txt', 
                  '3_peque“o_tumbada.txt', 
                  '4_peque“o_tumbada.txt'};

    files_mediano_tumbada = {'1_mediano_tumbada.txt', 
                  '2_mediano_tumbada.txt', 
                  '3_mediano_tumbada.txt', 
                  '4_mediano_tumbada.txt'};

    files_grande_tumbada = {'1_grande_tumbada.txt', 
                  '2_grande_tumbada.txt', 
                  '3_grande_tumbada.txt', 
                  '4_grande_tumbada.txt'};

    files_extragrande_tumbada = {'1_extragrande_tumbada.txt', 
                   '2_extragrande_tumbada.txt', 
                   '3_extragrande_tumbada.txt', 
                   '4_extragrande_tumbada.txt'};
    
    files_pequeno_sentada = {'1_peque“o_sentada.txt', 
                  '2_peque“o_sentada.txt', 
                  '3_peque“o_sentada.txt', 
                  '4_peque“o_sentada.txt'};

    files_mediano_sentada = {'1_mediano_sentada.txt', 
                  '2_mediano_sentada.txt', 
                  '3_mediano_sentada.txt', 
                  '4_mediano_sentada.txt'};

    files_grande_sentada = {'1_grande_sentada.txt', 
                  '2_grande_sentada.txt', 
                  '3_grande_sentada.txt', 
                  '4_grande_sentada.txt'};

    files_extragrande_sentada = {'1_extragrande_sentada.txt', 
                   '2_extragrande_sentada.txt', 
                   '3_extragrande_sentada.txt', 
                   '4_extragrande_sentada.txt'};
           
    files_pequeno_andando = {'1_peque“o_andando.txt', 
                  '2_peque“o_andando.txt', 
                  '3_peque“o_andando.txt', 
                  '4_peque“o_andando.txt'};

    files_mediano_andando = {'1_mediano_andando.txt', 
                  '2_mediano_andando.txt', 
                  '3_mediano_andando.txt', 
                  '4_mediano_andando.txt'};

    files_grande_andando = {'1_grande_andando.txt', 
                  '2_grande_andando.txt', 
                  '3_grande_andando.txt', 
                  '4_grande_andando.txt'};

    files_extragrande_andando = {'1_extragrande_andando.txt', 
                   '2_extragrande_andando.txt', 
                   '3_extragrande_andando.txt', 
                   '4_extragrande_andando.txt'};
               
    files_pequeno_escaleras = {'1_peque“o_escaleras.txt', 
                  '2_peque“o_escaleras.txt', 
                  '3_peque“o_escaleras.txt', 
                  '4_peque“o_escaleras.txt'};

    files_mediano_escaleras = {'1_mediano_escaleras.txt', 
                  '2_mediano_escaleras.txt', 
                  '3_mediano_escaleras.txt', 
                  '4_mediano_escaleras.txt'};

    files_grande_escaleras = {'1_grande_escaleras.txt', 
                  '2_grande_escaleras.txt', 
                  '3_grande_escaleras.txt', 
                  '4_grande_escaleras.txt'};

    files_extragrande_escaleras = {'1_extragrande_escaleras.txt', 
                   '2_extragrande_escaleras.txt', 
                   '3_extragrande_escaleras.txt', 
                   '4_extragrande_escaleras.txt'};

fileSets = {files_pequeno_tumbada, files_pequeno_sentada, files_pequeno_andando, files_pequeno_escaleras, files_mediano_tumbada, files_mediano_sentada, files_mediano_andando, files_mediano_escaleras, files_grande_tumbada, files_grande_sentada, files_grande_andando, files_grande_escaleras, files_extragrande_tumbada, files_extragrande_sentada, files_extragrande_andando, files_extragrande_escaleras,  };
indexes = cell(1, length(fileSets)); % indexes = cell(1, length(fileSets)); -> vector de 3 pos

% Iterar sobre los conjuntos de archivos
for setIndex = 1:length(indexes)
    currentFiles = fileSets{setIndex}; % Obtiene el grupo de archivos actual
    indexes{setIndex} = cell(1, length(currentFiles)); % Inicializa la celda para los resultados

    for fileIndex = 1:length(currentFiles) % Itera sobre cada archivo en el grupo actual
        % Importar datos del archivo
        s1 = "/Users/carmengarciaprieto/Desktop/mediciones/";
        s2 = currentFiles{fileIndex};
        data = ImportPluxData( strcat(s1,s2) , 3);

        % Extraer el segmento de inter»s (segundo 30 al minuto 5:30)
        ecg_segment = data(time_vector);

        % Calcular Ãndices de calidad para el segmento
        [~, ~, ~, ~, ~, ~, ~, geometricMean_vector, averageGeometricMean] = mSQI(ecg_segment, 1000);

        % Guardar resultados
        indexes{setIndex}{fileIndex} = geometricMean_vector;

        % Mostrar el promedio para el segmento actual
        fprintf("Average mean of segment (30s-5:30) in %s: %f\n", currentFiles{fileIndex}, averageGeometricMean);
    end
end

% Separar resultados por conjuntos
indexes_pequeno_tumbada = indexes{1};
indexes_pequeno_sentada = indexes{2};
indexes_pequeno_andando = indexes{3};
indexes_pequeno_escaleras = indexes{4};
indexes_mediano_tumbada = indexes{5};
indexes_mediano_sentada = indexes{6};
indexes_mediano_andando = indexes{7};
indexes_mediano_escaleras = indexes{8};
indexes_grande_tumbada = indexes{9};
indexes_grande_sentada = indexes{10};
indexes_grande_andando = indexes{11};
indexes_grande_escaleras = indexes{12};
indexes_extragrande_tumbada = indexes{13};
indexes_extragrande_sentada = indexes{14};
indexes_extragrande_andando = indexes{15};
indexes_extragrande_escaleras = indexes{16};

% Agrupaci€n de datos
data_pequeno_tumbada = [indexes_pequeno_tumbada{:}];
data_mediano_tumbada = [indexes_mediano_tumbada{:}];
data_grande_tumbada = [indexes_grande_tumbada{:}];
data_extragrande_tumbada = [indexes_extragrande_tumbada{:}];

data_pequeno_sentada = [indexes_pequeno_sentada{:}];
data_mediano_sentada = [indexes_mediano_sentada{:}];
data_grande_sentada = [indexes_grande_sentada{:}];
data_extragrande_sentada = [indexes_extragrande_sentada{:}];

data_pequeno_andando = [indexes_pequeno_andando{:}];
data_mediano_andando = [indexes_mediano_andando{:}];
data_grande_andando = [indexes_grande_andando{:}];
data_extragrande_andando = [indexes_extragrande_andando{:}];

data_pequeno_escaleras = [indexes_pequeno_escaleras{:}];
data_mediano_escaleras = [indexes_mediano_escaleras{:}];
data_grande_escaleras = [indexes_grande_escaleras{:}];
data_extragrande_escaleras = [indexes_extragrande_escaleras{:}];

% Peque“o
comparacion_pequeno_tumbada = {data_pequeno_tumbada, [data_mediano_tumbada, data_grande_tumbada, data_extragrande_tumbada]};
comparacion_pequeno_sentada = {data_pequeno_sentada, [data_mediano_sentada, data_grande_sentada, data_extragrande_sentada]};
comparacion_pequeno_andando = {data_pequeno_andando, [data_mediano_andando, data_grande_andando, data_extragrande_andando]};
comparacion_pequeno_escaleras = {data_pequeno_escaleras, [data_mediano_escaleras, data_grande_escaleras, data_extragrande_escaleras]};

% Agrupado por tama“o peque“o
comparacion_pequeno = {
    'tumbada', comparacion_pequeno_tumbada;
    'sentada', comparacion_pequeno_sentada;
    'andando', comparacion_pequeno_andando;
    'escaleras', comparacion_pequeno_escaleras
};

% Mediano
comparacion_mediano_tumbada = {data_mediano_tumbada, [data_pequeno_tumbada, data_grande_tumbada, data_extragrande_tumbada]};
comparacion_mediano_sentada = {data_mediano_sentada, [data_pequeno_sentada, data_grande_sentada, data_extragrande_sentada]};
comparacion_mediano_andando = {data_mediano_andando, [data_pequeno_andando, data_grande_andando, data_extragrande_andando]};
comparacion_mediano_escaleras = {data_mediano_escaleras, [data_pequeno_escaleras, data_grande_escaleras, data_extragrande_escaleras]};

% Agrupado por tama“o mediano
comparacion_mediano = {
    'tumbada', comparacion_mediano_tumbada;
    'sentada', comparacion_mediano_sentada;
    'andando', comparacion_mediano_andando;
    'escaleras', comparacion_mediano_escaleras
};

% Grande
comparacion_grande_tumbada = {data_grande_tumbada, [data_pequeno_tumbada, data_mediano_tumbada, data_extragrande_tumbada]};
comparacion_grande_sentada = {data_grande_sentada, [data_pequeno_sentada, data_mediano_sentada, data_extragrande_sentada]};
comparacion_grande_andando = {data_grande_andando, [data_pequeno_andando, data_mediano_andando, data_extragrande_andando]};
comparacion_grande_escaleras = {data_grande_escaleras, [data_pequeno_escaleras, data_mediano_escaleras, data_extragrande_escaleras]};

% Agrupado por tama“o grande
comparacion_grande = {
    'tumbada', comparacion_grande_tumbada;
    'sentada', comparacion_grande_sentada;
    'andando', comparacion_grande_andando;
    'escaleras', comparacion_grande_escaleras
};

% Extragrande
comparacion_extragrande_tumbada = {data_extragrande_tumbada, [data_pequeno_tumbada, data_mediano_tumbada, data_grande_tumbada]};
comparacion_extragrande_sentada = {data_extragrande_sentada, [data_pequeno_sentada, data_mediano_sentada, data_grande_sentada]};
comparacion_extragrande_andando = {data_extragrande_andando, [data_pequeno_andando, data_mediano_andando, data_grande_andando]};
comparacion_extragrande_escaleras = {data_extragrande_escaleras, [data_pequeno_escaleras, data_mediano_escaleras, data_grande_escaleras]};

% Agrupado por tama“o extragrande
comparacion_extragrande = {
    'tumbada', comparacion_extragrande_tumbada;
    'sentada', comparacion_extragrande_sentada;
    'andando', comparacion_extragrande_andando;
    'escaleras', comparacion_extragrande_escaleras
};

% Par∑metros para los intervalos de confianza
alph = 0.01; % Nivel de significancia
iter = 1000; % Iteraciones para bootstrap

% Peque“o
% Tumbada
CIMedian_pequeno_tumbada = estimateCIMedian(comparacion_pequeno_tumbada{1}, comparacion_pequeno_tumbada{2}, alph, iter);
CIMean_pequeno_tumbada = estimateCIMean(comparacion_pequeno_tumbada{1}, comparacion_pequeno_tumbada{2}, alph, iter);

% Sentada
CIMedian_pequeno_sentada = estimateCIMedian(comparacion_pequeno_sentada{1}, comparacion_pequeno_sentada{2}, alph, iter);
CIMean_pequeno_sentada = estimateCIMean(comparacion_pequeno_sentada{1}, comparacion_pequeno_sentada{2}, alph, iter);

% Andando
CIMedian_pequeno_andando = estimateCIMedian(comparacion_pequeno_andando{1}, comparacion_pequeno_andando{2}, alph, iter);
CIMean_pequeno_andando = estimateCIMean(comparacion_pequeno_andando{1}, comparacion_pequeno_andando{2}, alph, iter);

% Escaleras
CIMedian_pequeno_escaleras = estimateCIMedian(comparacion_pequeno_escaleras{1}, comparacion_pequeno_escaleras{2}, alph, iter);
CIMean_pequeno_escaleras = estimateCIMean(comparacion_pequeno_escaleras{1}, comparacion_pequeno_escaleras{2}, alph, iter);

% Mediano
% Tumbada
CIMedian_mediano_tumbada = estimateCIMedian(comparacion_mediano_tumbada{1}, comparacion_mediano_tumbada{2}, alph, iter);
CIMean_mediano_tumbada = estimateCIMean(comparacion_mediano_tumbada{1}, comparacion_mediano_tumbada{2}, alph, iter);

% Sentada
CIMedian_mediano_sentada = estimateCIMedian(comparacion_mediano_sentada{1}, comparacion_mediano_sentada{2}, alph, iter);
CIMean_mediano_sentada = estimateCIMean(comparacion_mediano_sentada{1}, comparacion_mediano_sentada{2}, alph, iter);

% Andando
CIMedian_mediano_andando = estimateCIMedian(comparacion_mediano_andando{1}, comparacion_mediano_andando{2}, alph, iter);
CIMean_mediano_andando = estimateCIMean(comparacion_mediano_andando{1}, comparacion_mediano_andando{2}, alph, iter);

% Escaleras
CIMedian_mediano_escaleras = estimateCIMedian(comparacion_mediano_escaleras{1}, comparacion_mediano_escaleras{2}, alph, iter);
CIMean_mediano_escaleras = estimateCIMean(comparacion_mediano_escaleras{1}, comparacion_mediano_escaleras{2}, alph, iter);

% Grande
% Tumbada
CIMedian_grande_tumbada = estimateCIMedian(comparacion_grande_tumbada{1}, comparacion_grande_tumbada{2}, alph, iter);
CIMean_grande_tumbada = estimateCIMean(comparacion_grande_tumbada{1}, comparacion_grande_tumbada{2}, alph, iter);

% Sentada
CIMedian_grande_sentada = estimateCIMedian(comparacion_grande_sentada{1}, comparacion_grande_sentada{2}, alph, iter);
CIMean_grande_sentada = estimateCIMean(comparacion_grande_sentada{1}, comparacion_grande_sentada{2}, alph, iter);

% Andando
CIMedian_grande_andando = estimateCIMedian(comparacion_grande_andando{1}, comparacion_grande_andando{2}, alph, iter);
CIMean_grande_andando = estimateCIMean(comparacion_grande_andando{1}, comparacion_grande_andando{2}, alph, iter);

% Escaleras
CIMedian_grande_escaleras = estimateCIMedian(comparacion_grande_escaleras{1}, comparacion_grande_escaleras{2}, alph, iter);
CIMean_grande_escaleras = estimateCIMean(comparacion_grande_escaleras{1}, comparacion_grande_escaleras{2}, alph, iter);

% Extragrande
% Tumbada
CIMedian_extragrande_tumbada = estimateCIMedian(comparacion_extragrande_tumbada{1}, comparacion_extragrande_tumbada{2}, alph, iter);
CIMean_extragrande_tumbada = estimateCIMean(comparacion_extragrande_tumbada{1}, comparacion_extragrande_tumbada{2}, alph, iter);

% Sentada
CIMedian_extragrande_sentada = estimateCIMedian(comparacion_extragrande_sentada{1}, comparacion_extragrande_sentada{2}, alph, iter);
CIMean_extragrande_sentada = estimateCIMean(comparacion_extragrande_sentada{1}, comparacion_extragrande_sentada{2}, alph, iter);

% Andando
CIMedian_extragrande_andando = estimateCIMedian(comparacion_extragrande_andando{1}, comparacion_extragrande_andando{2}, alph, iter);
CIMean_extragrande_andando = estimateCIMean(comparacion_extragrande_andando{1}, comparacion_extragrande_andando{2}, alph, iter);

% Escaleras
CIMedian_extragrande_escaleras = estimateCIMedian(comparacion_extragrande_escaleras{1}, comparacion_extragrande_escaleras{2}, alph, iter);
CIMean_extragrande_escaleras = estimateCIMean(comparacion_extragrande_escaleras{1}, comparacion_extragrande_escaleras{2}, alph, iter);

% Convertir las matrices de Ãndices a vectores planos
indexes_pequeno_tumbada_v = cell2mat(indexes_pequeno_tumbada);
indexes_mediano_tumbada_v = cell2mat(indexes_mediano_tumbada);
indexes_grande_tumbada_v = cell2mat(indexes_grande_tumbada);
indexes_extragrande_tumbada_v = cell2mat(indexes_extragrande_tumbada);

indexes_pequeno_sentada_v = cell2mat(indexes_pequeno_sentada);
indexes_mediano_sentada_v = cell2mat(indexes_mediano_sentada);
indexes_grande_sentada_v = cell2mat(indexes_grande_sentada);
indexes_extragrande_sentada_v = cell2mat(indexes_extragrande_sentada);

indexes_pequeno_andando_v = cell2mat(indexes_pequeno_andando);
indexes_mediano_andando_v = cell2mat(indexes_mediano_andando);
indexes_grande_andando_v = cell2mat(indexes_grande_andando);
indexes_extragrande_andando_v = cell2mat(indexes_extragrande_andando);

indexes_pequeno_escaleras_v = cell2mat(indexes_pequeno_escaleras);
indexes_mediano_escaleras_v = cell2mat(indexes_mediano_escaleras);
indexes_grande_escaleras_v = cell2mat(indexes_grande_escaleras);
indexes_extragrande_escaleras_v = cell2mat(indexes_extragrande_escaleras);

% Par∑metros
alph = 0.01; % Nivel de significancia
iter = 1000; % N?mero de iteraciones para el bootstrap

% Calcular media y varianza para cada actividad y tama“o
% Tumbada
mean_pequeno_tumbada = mean(indexes_pequeno_tumbada_v);
var_pequeno_tumbada = var(indexes_pequeno_tumbada_v);

mean_mediano_tumbada = mean(indexes_mediano_tumbada_v);
var_mediano_tumbada = var(indexes_mediano_tumbada_v);

mean_grande_tumbada = mean(indexes_grande_tumbada_v);
var_grande_tumbada = var(indexes_grande_tumbada_v);

mean_extragrande_tumbada = mean(indexes_extragrande_tumbada_v);
var_extragrande_tumbada = var(indexes_extragrande_tumbada_v);

% Sentada
mean_pequeno_sentada = mean(indexes_pequeno_sentada_v);
var_pequeno_sentada = var(indexes_pequeno_sentada_v);

mean_mediano_sentada = mean(indexes_mediano_sentada_v);
var_mediano_sentada = var(indexes_mediano_sentada_v);

mean_grande_sentada = mean(indexes_grande_sentada_v);
var_grande_sentada = var(indexes_grande_sentada_v);

mean_extragrande_sentada = mean(indexes_extragrande_sentada_v);
var_extragrande_sentada = var(indexes_extragrande_sentada_v);

% Andando
mean_pequeno_andando = mean(indexes_pequeno_andando_v);
var_pequeno_andando = var(indexes_pequeno_andando_v);

mean_mediano_andando = mean(indexes_mediano_andando_v);
var_mediano_andando = var(indexes_mediano_andando_v);

mean_grande_andando = mean(indexes_grande_andando_v);
var_grande_andando = var(indexes_grande_andando_v);

mean_extragrande_andando = mean(indexes_extragrande_andando_v);
var_extragrande_andando = var(indexes_extragrande_andando_v);

% Escaleras
mean_pequeno_escaleras = mean(indexes_pequeno_escaleras_v);
var_pequeno_escaleras = var(indexes_pequeno_escaleras_v);

mean_mediano_escaleras = mean(indexes_mediano_escaleras_v);
var_mediano_escaleras = var(indexes_mediano_escaleras_v);

mean_grande_escaleras = mean(indexes_grande_escaleras_v);
var_grande_escaleras = var(indexes_grande_escaleras_v);

mean_extragrande_escaleras = mean(indexes_extragrande_escaleras_v);
var_extragrande_escaleras = var(indexes_extragrande_escaleras_v);

% Intervalos de confianza
% Tumbada
CIMedian_tumbada_pequeno_vs_otros = estimateCIMedian(indexes_pequeno_tumbada_v, [indexes_mediano_tumbada_v, indexes_grande_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);
CIMean_tumbada_pequeno_vs_otros = estimateCIMean(indexes_pequeno_tumbada_v, [indexes_mediano_tumbada_v, indexes_grande_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);

CIMedian_tumbada_mediano_vs_otros = estimateCIMedian(indexes_mediano_tumbada_v, [indexes_pequeno_tumbada_v, indexes_grande_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);
CIMean_tumbada_mediano_vs_otros = estimateCIMean(indexes_mediano_tumbada_v, [indexes_pequeno_tumbada_v, indexes_grande_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);

CIMedian_tumbada_grande_vs_otros = estimateCIMedian(indexes_grande_tumbada_v, [indexes_pequeno_tumbada_v, indexes_mediano_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);
CIMean_tumbada_grande_vs_otros = estimateCIMean(indexes_grande_tumbada_v, [indexes_pequeno_tumbada_v, indexes_mediano_tumbada_v, indexes_extragrande_tumbada_v], alph, iter);

CIMedian_tumbada_extragrande_vs_otros = estimateCIMedian(indexes_extragrande_tumbada_v, [indexes_pequeno_tumbada_v, indexes_mediano_tumbada_v, indexes_grande_tumbada_v], alph, iter);
CIMean_tumbada_extragrande_vs_otros = estimateCIMean(indexes_extragrande_tumbada_v, [indexes_pequeno_tumbada_v, indexes_mediano_tumbada_v, indexes_grande_tumbada_v], alph, iter);

% Sentada
CIMedian_sentada_pequeno_vs_otros = estimateCIMedian(indexes_pequeno_sentada_v, [indexes_mediano_sentada_v, indexes_grande_sentada_v, indexes_extragrande_sentada_v], alph, iter);
CIMean_sentada_pequeno_vs_otros = estimateCIMean(indexes_pequeno_sentada_v, [indexes_mediano_sentada_v, indexes_grande_sentada_v, indexes_extragrande_sentada_v], alph, iter);

CIMedian_sentada_mediano_vs_otros = estimateCIMedian(indexes_mediano_sentada_v, [indexes_pequeno_sentada_v, indexes_grande_sentada_v, indexes_extragrande_sentada_v], alph, iter);
CIMean_sentada_mediano_vs_otros = estimateCIMean(indexes_mediano_sentada_v, [indexes_pequeno_sentada_v, indexes_grande_sentada_v, indexes_extragrande_sentada_v], alph, iter);

CIMedian_sentada_grande_vs_otros = estimateCIMedian(indexes_grande_sentada_v, [indexes_pequeno_sentada_v, indexes_mediano_sentada_v, indexes_extragrande_sentada_v], alph, iter);
CIMean_sentada_grande_vs_otros = estimateCIMean(indexes_grande_sentada_v, [indexes_pequeno_sentada_v, indexes_mediano_sentada_v, indexes_extragrande_sentada_v], alph, iter);

CIMedian_sentada_extragrande_vs_otros = estimateCIMedian(indexes_extragrande_sentada_v, [indexes_pequeno_sentada_v, indexes_mediano_sentada_v, indexes_grande_sentada_v], alph, iter);
CIMean_sentada_extragrande_vs_otros = estimateCIMean(indexes_extragrande_sentada_v, [indexes_pequeno_sentada_v, indexes_mediano_sentada_v, indexes_grande_sentada_v], alph, iter);

% Andando
CIMedian_andando_pequeno_vs_otros = estimateCIMedian(indexes_pequeno_andando_v, [indexes_mediano_andando_v, indexes_grande_andando_v, indexes_extragrande_andando_v], alph, iter);
CIMean_andando_pequeno_vs_otros = estimateCIMean(indexes_pequeno_andando_v, [indexes_mediano_andando_v, indexes_grande_andando_v, indexes_extragrande_andando_v], alph, iter);

CIMedian_andando_mediano_vs_otros = estimateCIMedian(indexes_mediano_andando_v, [indexes_pequeno_andando_v, indexes_grande_andando_v, indexes_extragrande_andando_v], alph, iter);
CIMean_andando_mediano_vs_otros = estimateCIMean(indexes_mediano_andando_v, [indexes_pequeno_andando_v, indexes_grande_andando_v, indexes_extragrande_andando_v], alph, iter);

CIMedian_andando_grande_vs_otros = estimateCIMedian(indexes_grande_andando_v, [indexes_pequeno_andando_v, indexes_mediano_andando_v, indexes_extragrande_andando_v], alph, iter);
CIMean_andando_grande_vs_otros = estimateCIMean(indexes_grande_andando_v, [indexes_pequeno_andando_v, indexes_mediano_andando_v, indexes_extragrande_andando_v], alph, iter);

CIMedian_andando_extragrande_vs_otros = estimateCIMedian(indexes_extragrande_andando_v, [indexes_pequeno_andando_v, indexes_mediano_andando_v, indexes_grande_andando_v], alph, iter);
CIMean_andando_extragrande_vs_otros = estimateCIMean(indexes_extragrande_andando_v, [indexes_pequeno_andando_v, indexes_mediano_andando_v, indexes_grande_andando_v], alph, iter);

% Escaleras
CIMedian_escaleras_pequeno_vs_otros = estimateCIMedian(indexes_pequeno_escaleras_v, [indexes_mediano_escaleras_v, indexes_grande_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);
CIMean_escaleras_pequeno_vs_otros = estimateCIMean(indexes_pequeno_escaleras_v, [indexes_mediano_escaleras_v, indexes_grande_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);

CIMedian_escaleras_mediano_vs_otros = estimateCIMedian(indexes_mediano_escaleras_v, [indexes_pequeno_escaleras_v, indexes_grande_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);
CIMean_escaleras_mediano_vs_otros = estimateCIMean(indexes_mediano_escaleras_v, [indexes_pequeno_escaleras_v, indexes_grande_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);

CIMedian_escaleras_grande_vs_otros = estimateCIMedian(indexes_grande_escaleras_v, [indexes_pequeno_escaleras_v, indexes_mediano_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);
CIMean_escaleras_grande_vs_otros = estimateCIMean(indexes_grande_escaleras_v, [indexes_pequeno_escaleras_v, indexes_mediano_escaleras_v, indexes_extragrande_escaleras_v], alph, iter);

CIMedian_escaleras_extragrande_vs_otros = estimateCIMedian(indexes_extragrande_escaleras_v, [indexes_pequeno_escaleras_v, indexes_mediano_escaleras_v, indexes_grande_escaleras_v], alph, iter);
CIMean_escaleras_extragrande_vs_otros = estimateCIMean(indexes_extragrande_escaleras_v, [indexes_pequeno_escaleras_v, indexes_mediano_escaleras_v, indexes_grande_escaleras_v], alph, iter);

% Tumbada
x_mean_indexes_tumbada_pequeno = cellfun(@mean, indexes_pequeno_tumbada);
x_mean_indexes_tumbada_mediano = cellfun(@mean, indexes_mediano_tumbada);
x_mean_indexes_tumbada_grande = cellfun(@mean, indexes_grande_tumbada);
x_mean_indexes_tumbada_extragrande = cellfun(@mean, indexes_extragrande_tumbada);

x_var_indexes_tumbada_pequeno = cellfun(@var, indexes_pequeno_tumbada);
x_var_indexes_tumbada_mediano = cellfun(@var, indexes_mediano_tumbada);
x_var_indexes_tumbada_grande = cellfun(@var, indexes_grande_tumbada);
x_var_indexes_tumbada_extragrande = cellfun(@var, indexes_extragrande_tumbada);

% Sentada
x_mean_indexes_sentada_pequeno = cellfun(@mean, indexes_pequeno_sentada);
x_mean_indexes_sentada_mediano = cellfun(@mean, indexes_mediano_sentada);
x_mean_indexes_sentada_grande = cellfun(@mean, indexes_grande_sentada);
x_mean_indexes_sentada_extragrande = cellfun(@mean, indexes_extragrande_sentada);

x_var_indexes_sentada_pequeno = cellfun(@var, indexes_pequeno_sentada);
x_var_indexes_sentada_mediano = cellfun(@var, indexes_mediano_sentada);
x_var_indexes_sentada_grande = cellfun(@var, indexes_grande_sentada);
x_var_indexes_sentada_extragrande = cellfun(@var, indexes_extragrande_sentada);

% Andando
x_mean_indexes_andando_pequeno = cellfun(@mean, indexes_pequeno_andando);
x_mean_indexes_andando_mediano = cellfun(@mean, indexes_mediano_andando);
x_mean_indexes_andando_grande = cellfun(@mean, indexes_grande_andando);
x_mean_indexes_andando_extragrande = cellfun(@mean, indexes_extragrande_andando);

x_var_indexes_andando_pequeno = cellfun(@var, indexes_pequeno_andando);
x_var_indexes_andando_mediano = cellfun(@var, indexes_mediano_andando);
x_var_indexes_andando_grande = cellfun(@var, indexes_grande_andando);
x_var_indexes_andando_extragrande = cellfun(@var, indexes_extragrande_andando);

% Escaleras
x_mean_indexes_escaleras_pequeno = cellfun(@mean, indexes_pequeno_escaleras);
x_mean_indexes_escaleras_mediano = cellfun(@mean, indexes_mediano_escaleras);
x_mean_indexes_escaleras_grande = cellfun(@mean, indexes_grande_escaleras);
x_mean_indexes_escaleras_extragrande = cellfun(@mean, indexes_extragrande_escaleras);

x_var_indexes_escaleras_pequeno = cellfun(@var, indexes_pequeno_escaleras);
x_var_indexes_escaleras_mediano = cellfun(@var, indexes_mediano_escaleras);
x_var_indexes_escaleras_grande = cellfun(@var, indexes_grande_escaleras);
x_var_indexes_escaleras_extragrande = cellfun(@var, indexes_extragrande_escaleras);

% Tumbada
fprintf("Tumbada - Peque“o: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_pequeno_tumbada_v), std(indexes_pequeno_tumbada_v));
fprintf("Tumbada - Mediano: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_mediano_tumbada_v), std(indexes_mediano_tumbada_v));
fprintf("Tumbada - Grande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_grande_tumbada_v), std(indexes_grande_tumbada_v));
fprintf("Tumbada - Extragrande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_extragrande_tumbada_v), std(indexes_extragrande_tumbada_v));

% Sentada
fprintf("Sentada - Peque“o: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_pequeno_sentada_v), std(indexes_pequeno_sentada_v));
fprintf("Sentada - Mediano: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_mediano_sentada_v), std(indexes_mediano_sentada_v));
fprintf("Sentada - Grande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_grande_sentada_v), std(indexes_grande_sentada_v));
fprintf("Sentada - Extragrande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_extragrande_sentada_v), std(indexes_extragrande_sentada_v));

% Andando
fprintf("Andando - Peque“o: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_pequeno_andando_v), std(indexes_pequeno_andando_v));
fprintf("Andando - Mediano: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_mediano_andando_v), std(indexes_mediano_andando_v));
fprintf("Andando - Grande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_grande_andando_v), std(indexes_grande_andando_v));
fprintf("Andando - Extragrande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_extragrande_andando_v), std(indexes_extragrande_andando_v));

% Escaleras
fprintf("Escaleras - Peque“o: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_pequeno_escaleras_v), std(indexes_pequeno_escaleras_v));
fprintf("Escaleras - Mediano: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_mediano_escaleras_v), std(indexes_mediano_escaleras_v));
fprintf("Escaleras - Grande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_grande_escaleras_v), std(indexes_grande_escaleras_v));
fprintf("Escaleras - Extragrande: Media = %.6f, Desviaci€n est∑ndar = %.6f\n", mean(indexes_extragrande_escaleras_v), std(indexes_extragrande_escaleras_v));

% Intervalos de confianza para comparaciones adicionales

% Todos los registros
CIMedian_extragrande_vs_grande = estimateCIMedian(indexes_extragrande_tumbada_v, indexes_grande_tumbada_v, alph, iter);
CIMean_extragrande_vs_grande = estimateCIMean(indexes_extragrande_tumbada_v, indexes_grande_tumbada_v, alph, iter);
fprintf("Todos los registros - Extra grande vs Grande: Intervalo de confianza media = [%f, %f]\n", CIMean_extragrande_vs_grande(1), CIMean_extragrande_vs_grande(2));
fprintf("Todos los registros - Extra grande vs Grande: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_extragrande_vs_grande(1), CIMedian_extragrande_vs_grande(2));

CIMedian_grande_vs_mediano = estimateCIMedian(indexes_grande_tumbada_v, indexes_mediano_tumbada_v, alph, iter);
CIMean_grande_vs_mediano = estimateCIMean(indexes_grande_tumbada_v, indexes_mediano_tumbada_v, alph, iter);
fprintf("Todos los registros - Grande vs Mediano: Intervalo de confianza media = [%f, %f]\n", CIMean_grande_vs_mediano(1), CIMean_grande_vs_mediano(2));
fprintf("Todos los registros - Grande vs Mediano: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_grande_vs_mediano(1), CIMedian_grande_vs_mediano(2));

CIMedian_mediano_vs_pequeno = estimateCIMedian(indexes_mediano_tumbada_v, indexes_pequeno_tumbada_v, alph, iter);
CIMean_mediano_vs_pequeno = estimateCIMean(indexes_mediano_tumbada_v, indexes_pequeno_tumbada_v, alph, iter);
fprintf("Todos los registros - Mediano vs Peque“o: Intervalo de confianza media = [%f, %f]\n", CIMean_mediano_vs_pequeno(1), CIMean_mediano_vs_pequeno(2));
fprintf("Todos los registros - Mediano vs Peque“o: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_mediano_vs_pequeno(1), CIMedian_mediano_vs_pequeno(2));

% Escaleras
CIMedian_escaleras_extragrande_vs_grande = estimateCIMedian(indexes_extragrande_escaleras_v, indexes_grande_escaleras_v, alph, iter);
CIMean_escaleras_extragrande_vs_grande = estimateCIMean(indexes_extragrande_escaleras_v, indexes_grande_escaleras_v, alph, iter);
fprintf("Escaleras - Extra grande vs Grande: Intervalo de confianza media = [%f, %f]\n", CIMean_escaleras_extragrande_vs_grande(1), CIMean_escaleras_extragrande_vs_grande(2));
fprintf("Escaleras - Extra grande vs Grande: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_escaleras_extragrande_vs_grande(1), CIMedian_escaleras_extragrande_vs_grande(2));

% Andando
CIMedian_andando_extragrande_vs_grande = estimateCIMedian(indexes_extragrande_andando_v, indexes_grande_andando_v, alph, iter);
CIMean_andando_extragrande_vs_grande = estimateCIMean(indexes_extragrande_andando_v, indexes_grande_andando_v, alph, iter);
fprintf("Andando - Extra grande vs Grande: Intervalo de confianza media = [%f, %f]\n", CIMean_andando_extragrande_vs_grande(1), CIMean_andando_extragrande_vs_grande(2));
fprintf("Andando - Extra grande vs Grande: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_andando_extragrande_vs_grande(1), CIMedian_andando_extragrande_vs_grande(2));

% Sentada
CIMedian_sentada_extragrande_vs_grande = estimateCIMedian(indexes_extragrande_sentada_v, indexes_grande_sentada_v, alph, iter);
CIMean_sentada_extragrande_vs_grande = estimateCIMean(indexes_extragrande_sentada_v, indexes_grande_sentada_v, alph, iter);
fprintf("Sentada - Extra grande vs Grande: Intervalo de confianza media = [%f, %f]\n", CIMean_sentada_extragrande_vs_grande(1), CIMean_sentada_extragrande_vs_grande(2));
fprintf("Sentada - Extra grande vs Grande: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_sentada_extragrande_vs_grande(1), CIMedian_sentada_extragrande_vs_grande(2));

% Tumbada
CIMedian_tumbada_extragrande_vs_grande = estimateCIMedian(indexes_extragrande_tumbada_v, indexes_grande_tumbada_v, alph, iter);
CIMean_tumbada_extragrande_vs_grande = estimateCIMean(indexes_extragrande_tumbada_v, indexes_grande_tumbada_v, alph, iter);
fprintf("Tumbada - Extra grande vs Grande: Intervalo de confianza media = [%f, %f]\n", CIMean_tumbada_extragrande_vs_grande(1), CIMean_tumbada_extragrande_vs_grande(2));
fprintf("Tumbada - Extra grande vs Grande: Intervalo de confianza mediana = [%f, %f]\n", CIMedian_tumbada_extragrande_vs_grande(1), CIMedian_tumbada_extragrande_vs_grande(2));
