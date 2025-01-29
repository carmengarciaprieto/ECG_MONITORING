% Analiza datos de acelerómetros de archivos dados
% Calcula media y desviación estándar
% Grafica el histograma de Potencia Total XYZ

archivos = {'power_FileName_Arm.csv','power_FileName_Sternum.csv'};

% Iterar sobre los archivos que contienen listas de archivos
for j = 1:length(archivos)
    archivo = archivos{j};  
   
    % omite la cabecera (la primera línea)
    lista_archivos = readlines(archivo);
    lista_archivos = lista_archivos(2:end); % Omitir la primera línea (cabecera)
    
    % Iterar sobre cada archivo de la lista
    for i = 1:length(lista_archivos)-1
        archivo_dato = lista_archivos{i};  
        
        data = readmatrix(archivo_dato);  
        
        % Leer la cuarta columna (potencia_total_xyz)
        datos = data(:,4); 
        
        % Calcular media y desviación estándar
        media = mean(datos);
        desviacion = std(datos);
        
        % Mostrar resultados
        fprintf("Archivo: %s\n", archivo_dato);
        fprintf("Valor medio: %.8f\n", media);
        fprintf("Desviación estándar: %.8f\n", desviacion);
        
       % Graficar histograma
        figure;
        histogram(datos, 50);
        xlabel("Potencia Total XYZ");
        ylabel("Frecuencia");
        
        % Eliminar guiones bajos del nombre del archivo para el título
        titulo = strrep(archivo_dato, '_', ' ');  % Reemplaza los guiones bajos por espacios
        title(["Histograma de Potencia Total XYZ - ", titulo]);
        
        grid on;

    end
end
