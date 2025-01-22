
% Función para guardar los datos en un archivo CSV

function guardarEnCSV(nombreArchivo, datos, nombresColumnas)
    try
        if isnumeric(datos) || islogical(datos)
            % Convertir matriz numérica a tabla
            tabla = array2table(datos, 'VariableNames', nombresColumnas);
        elseif iscell(datos)
            % Convertir celdas a tabla
            tabla = cell2table(datos, 'VariableNames', nombresColumnas);
        else
            error('Tipo de datos no soportado para guardar en CSV.');
        end
        
        % Asegurar que el nombre termine en .csv
        [filepath, name, ext] = fileparts(nombreArchivo);
        if ~strcmp(ext, '.csv')
            nombreArchivo = fullfile(filepath, [name '.csv']);
        end
        
        % Guardar la tabla en un archivo CSV
        writetable(tabla, nombreArchivo);
    catch ME
        fprintf('Error al guardar el archivo %s: %s\n', nombreArchivo, ME.message);
    end
end
