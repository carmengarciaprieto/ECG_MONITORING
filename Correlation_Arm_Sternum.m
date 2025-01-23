
potencia_files_arm = readmatrix('power_FileName_Arm.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');
potencia_files_sternum = readmatrix('power_FileName_Sternum.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');

% Almacenar los promedios de potencia
promedios_arm = [];
promedios_sternum = [];
nombres_archivos = []; 

% Resultados de la correlación
resultados_correlacion = [];

% Iteramos sobre la lista de archivos y calculamos los promedios
for i = 1:length(potencia_files_arm)
    % Obtener el nombre del archivo de la lista
    archivo_arm = potencia_files_arm(i);  % Archivo de brazo
    archivo_sternum = potencia_files_sternum(i);  % Archivo de esternón
    
    % Leer los datos de los archivos correspondientes (con encabezado eliminado)
    datos_arm = readmatrix(archivo_arm, 'Delimiter', ',', 'NumHeaderLines', 1);
    datos_sternum = readmatrix(archivo_sternum, 'Delimiter', ',', 'NumHeaderLines', 1);
    
    % Obtener las columnas de potencia
    columna_arm = datos_arm(:, 4);  
    columna_sternum = datos_sternum(:, 4);

    % Ajustar las longitudes para que sean iguales
    min_length = min(length(columna_arm), length(columna_sternum));  % Encontrar la longitud mínima
    columna_arm = columna_arm(1:min_length);  % Recortar según la longitud mínima
    columna_sternum = columna_sternum(1:min_length);  % Recortar según la longitud mínima
    
    % Calcular los promedios
    promedio_arm = mean(columna_arm);
    promedio_sternum = mean(columna_sternum);

    promedios_arm = [promedios_arm; promedio_arm];
    promedios_sternum = [promedios_sternum; promedio_sternum];
    
    % Calcular la correlación entre los promedios
    [coef, p_value] = corr(columna_arm, columna_sternum, 'Type', 'Pearson');
    
    % Almacenar los resultados de la correlación y los nombres de los archivos
    resultados_correlacion = [resultados_correlacion; coef, p_value];
    nombres_archivos = [nombres_archivos; string(archivo_arm) + ' & ' + string(archivo_sternum)];
end

% Crear una tabla con los resultados de todas las correlaciones, incluyendo los nombres de archivos
resultados = array2table(resultados_correlacion, 'VariableNames', {'Coeficiente_de_Correlacion', 'Valor_p'});
resultados.Nombres_Archivos = nombres_archivos;  % Agregar la columna de nombres de archivos

% Guardar
nombreArchivoResultado = 'resultados_correlacion_por_promedios.csv';
writetable(resultados, nombreArchivoResultado);

disp(['Los resultados han sido guardados en: ', nombreArchivoResultado]);
