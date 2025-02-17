% Multiplca la potencia y msqi ajustando vectores de dichos valores 
% devuelve el msqi corregido 

function msqi_power_product = calculate_product_msqi_power(msqi_data_adjusted, potencia_xyz_adjusted)
    % Verificar que las dimensiones de las matrices coincidan
    if size(msqi_data_adjusted) ~= size(potencia_xyz_adjusted)
        error('Las dimensiones de los vectores no coinciden');
    end
    
    % Calcular el producto elemento por elemento
    msqi_power_product = msqi_data_adjusted .* potencia_xyz_adjusted;
end
