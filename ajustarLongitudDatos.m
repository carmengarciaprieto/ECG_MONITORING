
% Toma dos vectores como entrada, ajusta sus longitudes agregando ceros al más corto, 
% Devolve: los dos vectores ajustados.

function [data1_adjusted, data2_adjusted] = ajustarLongitudDatos(data1, data2)
    % Ajusta las longitudes de dos vectores, añadiendo ceros al más corto.
    len_data1 = length(data1);
    len_data2 = length(data2);
    
    if len_data1 < len_data2
        % Añadir ceros a data1
        data1_adjusted = [data1; zeros(len_data2 - len_data1, 1)];
        data2_adjusted = data2;
    elseif len_data1 > len_data2
        % Añadir ceros a data2
        data1_adjusted = data1;
        data2_adjusted = [data2; zeros(len_data1 - len_data2, 1)];
    else
        % Si ya son del mismo tamaño, no se necesita ajuste
        data1_adjusted = data1;
        data2_adjusted = data2;
    end
end
