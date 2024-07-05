# **SOLUCION CASOS DE USO:**

integrantes: Joseph Samuel Ospina Velasco

#### **CONSULTAS SOBRE UNA TABLA**

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```sql
   SELECT codigo_oficina, ciudad
   FROM oficinas;
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```sql
   SELECT ciudad, telefono
   FROM oficinas
   WHERE ciudad LIKE '%España%';
   ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
   jefe tiene un código de jefe igual a 7.

   ```sql
   SELECT e.nombre, e.apellidos, e.email
   FROM empleados e
   WHERE e.codigo_jefe = 7;
   ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
   empresa.

   ```sql
   SELECT e.puesto, e.nombre, e.apellidos, e.email
   FROM empleados e
   WHERE e.codigo_empleado = 7;
   ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
   empleados que no sean representantes de ventas.

   ```sql
   SELECT e.nombre, e.apellidos, e.puesto
   FROM empleados e
   WHERE e.codigo_empleado NOT IN (
     SELECT c.representante_venta
     FROM clientes c
     WHERE c.representante_venta IS NOT NULL
   );
   ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```sql
   SELECT c.nombre, c.apellidos
   FROM clientes c
   WHERE c.ciudad LIKE '%España%' OR c.ciudad LIKE '%Spain%';
   ```

7. Devuelve un listado con los distintos estados por los que puede pasar un
   pedido.

   ```sql
   SELECT DISTINCT estado
   FROM pedidos;
   ```

8. Devuelve un listado con el código de cliente de aquellos clientes que
   realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
   aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
   • Utilizando la función YEAR de MySQL.
   • Utilizando la función DATE_FORMAT de MySQL.
   • Sin utilizar ninguna de las funciones anteriores.

   ```sql
   SELECT DISTINCT c.codigo_cliente
   FROM clientes c
   JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   WHERE YEAR(p.fecha_pago) = 2008;
   
   SELECT DISTINCT c.codigo_cliente
   FROM clientes c
   JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   WHERE DATE_FORMAT(p.fecha_pago, '%Y') = '2008';
   
   SELECT DISTINCT c.codigo_cliente
   FROM clientes c
   JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   WHERE p.fecha_pago >= '2008-01-01' AND p.fecha_pago < '2009-01-01';
   ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
   esperada y fecha de entrega de los pedidos que no han sido entregados a
   tiempo.

   ```sql
   SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_esperada, p.fecha_entrega
   FROM pedidos p
   WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL;
   ```

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.
    • Utilizando la función ADDDATE de MySQL.
    • Utilizando la función DATEDIFF de MySQL.
    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

    ```sql
    SELECT 
      p.codigo_pedido, 
      p.codigo_cliente, 
      p.fecha_esperada, 
      p.fecha_entrega
    FROM 
      pedidos p
    WHERE 
      DATEDIFF(p.fecha_entrega, p.fecha_esperada) <= -2;
      
      SELECT 
      p.codigo_pedido, 
      p.codigo_cliente, 
      p.fecha_esperada, 
      p.fecha_entrega
    FROM 
      pedidos p
    WHERE 
      p.fecha_entrega <= ADDDATE(p.fecha_esperada, INTERVAL -2 DAY);
    ```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```sql
    SELECT 
      p.codigo_pedido, 
      p.codigo_cliente, 
      p.fecha_esperada, 
      p.fecha_entrega, 
      p.estado
    FROM 
      pedidos p
    WHERE 
      p.estado = 'Rechazado' 
      AND YEAR(p.fecha_entrega) = 2009;
    ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```sql
    SELECT 
      p.codigo_pedido, 
      p.codigo_cliente, 
      p.fecha_esperada, 
      p.fecha_entrega, 
      p.estado
    FROM 
      pedidos p
    WHERE 
      MONTH(p.fecha_entrega) = 1 
      AND p.estado = 'Entregado';
    ```

13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```sql
    SELECT 
      p.codigo_pago, 
      p.codigo_cliente, 
      p.fecha_pago, 
      p.forma_pago, 
      p.cantidad
    FROM 
      pagos p
    WHERE 
      p.forma_pago = 'Paypal' 
      AND YEAR(p.fecha_pago) = 2008
    ORDER BY 
      p.cantidad DESC;
    ```

14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```sql
    SELECT DISTINCT forma_pago
    FROM pagos;
    ```

15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```sql
    SELECT 
      p.nombre, 
      p.descripcion, 
      p.imagen, 
      p.precio_venta
    FROM 
      productos p
    WHERE 
      p.gama = 'Ornamentales'
      AND p.cantidad_stock > 100
    ORDER BY 
      p.precio_venta DESC;
    ```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.

    ```sql
    SELECT c.nombre, c.apellidos, c.ciudad
    FROM clientes c
    WHERE c.ciudad = 'Madrid'
    AND c.representante_venta IN (11, 30);
    ```

    

### Consultas multitabla (Composición interna)

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
   representante de ventas.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado;
   ```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
   nombre de sus representantes de ventas.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado
   WHERE c.codigo_cliente IN (SELECT p.codigo_cliente FROM pagos p);
   ```

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
   el nombre de sus representantes de ventas.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado
   WHERE c.codigo_cliente NOT IN (SELECT p.codigo_cliente FROM pagos p);
   ```

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
   representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos, o.ciudad
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado
   JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina
   WHERE c.codigo_cliente IN (SELECT p.codigo_cliente FROM pagos p);
   ```

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
   de sus representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos, o.ciudad
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado
   JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina
   WHERE c.codigo_cliente NOT IN (SELECT p.codigo_cliente FROM pagos p);
   ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   SELECT o.ciudad, o.telefono
   FROM oficinas o
   JOIN empleados e ON o.codigo_oficina = e.codigo_oficina
   JOIN clientes c ON e.codigo_empleado = c.representante_venta
   WHERE c.ciudad = 'Fuenlabrada';
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
   con la ciudad de la oficina a la que pertenece el representante.

   ```sql
   SELECT c.nombre, c.apellidos, e.nombre, e.apellidos, o.ciudad
   FROM clientes c
   JOIN empleados e ON c.representante_venta = e.codigo_empleado
   JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina;
   ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre
   de sus jefes.

   ```sql
   SELECT e.nombre, e.apellidos, j.nombre, j.apellidos
   FROM empleados e
   LEFT JOIN empleados j ON e.codigo_jefe = j.codigo_empleado;
   ```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
   de su jefe y el nombre del jefe de sus jefe.

   ```sql
   SELECT e.nombre, j1.nombre AS jefe, j2.nombre AS jefe_jefe
   FROM empleados e
   LEFT JOIN empleados j1 ON e.codigo_jefe = j1.codigo_empleado
   LEFT JOIN empleados j2 ON j1.codigo_jefe = j2.codigo_empleado;
   ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    SELECT c.nombre, c.apellidos
    FROM clientes c
    JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.fecha_entrega > p.fecha_esperada;
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ```sql
    SELECT c.nombre, c.apellidos, p.gama
    FROM clientes c
    JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
    JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    JOIN productos pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY c.nombre, c.apellidos, p.gama
    ORDER BY c.nombre, c.apellidos;
    ```



### Consultas multitabla (Composición externa)

1. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pago.

   ```sql
   SELECT c.nombre, c.apellidos
   FROM clientes c
   LEFT JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   WHERE p.codigo_pago IS NULL;
   ```

2. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pedido.

   ```sql
   SELECT c.nombre, c.apellidos
   FROM clientes c
   LEFT JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
   WHERE p.codigo_pedido IS NULL;
   ```

3. Devuelve un listado que muestre los clientes que no han realizado ningún
   pago y los que no han realizado ningún pedido.

   ```sql
   SELECT c.nombre, c.apellidos
   FROM clientes c
   LEFT JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   LEFT JOIN pedidos pd ON c.codigo_cliente = pd.codigo_cliente
   WHERE p.codigo_pago IS NULL AND pd.codigo_pedido IS NULL;
   ```

4. Devuelve un listado que muestre solamente los empleados que no tienen
   una oficina asociada.

   ```sql
   SELECT e.nombre, e.apellidos
   FROM empleados e
   LEFT JOIN oficinas o ON e.codigo_empleado = o.codigo_oficina
   WHERE o.codigo_oficina IS NULL;
   ```

5. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado.

   ```sql
   SELECT e.nombre, e.apellidos
   FROM empleados e
   LEFT JOIN clientes c ON e.codigo_empleado = c.representante_venta
   WHERE c.codigo_cliente IS NULL;
   ```

6. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado junto con los datos de la oficina donde trabajan.

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellidos, o.ciudad
   FROM empleados e
   LEFT JOIN clientes c ON e.codigo_empleado = c.representante_venta
   LEFT JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina
   WHERE c.codigo_cliente IS NULL;
   ```

7. Devuelve un listado que muestre los empleados que no tienen una oficina
   asociada y los que no tienen un cliente asociado.

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellidos
   FROM empleados e
   LEFT JOIN oficinas o ON e.codigo_oficina = o.codigo_oficina
   LEFT JOIN clientes c ON e.codigo_empleado = c.representante_venta
   WHERE o.codigo_oficina IS NULL AND c.codigo_cliente IS NULL;
   ```

8. Devuelve un listado de los productos que nunca han aparecido en un
   pedido.

   ```sql
   SELECT * FROM productos
   WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);
   ```

9. Devuelve un listado de los productos que nunca han aparecido en un
   pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
   producto.

   ```sql
   SELECT nombre, descripcion, imagen 
   FROM productos 
   WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);
   ```

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    SELECT * FROM oficinas o
    WHERE NOT EXISTS (
      SELECT * FROM empleados e
      WHERE e.codigo_oficina = o.codigo_oficina
      AND e.codigo_empleado IN (
        SELECT DISTINCT representante_venta FROM clientes c
        WHERE c.codigo_cliente IN (
          SELECT pedidos.codigo_cliente FROM pedidos
          JOIN detalle_pedido ON pedidos.codigo_pedido = detalle_pedido.codigo_pedido
          JOIN productos ON detalle_pedido.codigo_producto = productos.codigo_producto
          WHERE productos.gama = 'Frutales'
        )
      )
    ;
    ```

11. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    SELECT * FROM clientes c
    WHERE EXISTS (
      SELECT * FROM pedidos p WHERE p.codigo_cliente = c.codigo_cliente
    ) AND NOT EXISTS (
      SELECT * FROM pagos p WHERE p.codigo_cliente = c.codigo_cliente
    );
    ```

12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```sql
    SELECT e.codigo_empleado, e.nombre, e.apellidos, j.nombre AS nombre_jefe, j.apellidos AS apellidos_jefe
    FROM empleados e
    LEFT JOIN empleados j ON e.codigo_jefe = j.codigo_empleado
    WHERE e.codigo_empleado NOT IN (
      SELECT DISTINCT representante_venta FROM clientes
    );
    ```

    

### Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```sql
   SELECT COUNT(*) AS num_empleados
   FROM empleados;
   ```

2. ¿Cuántos clientes tiene cada país?

   ```sql
   SELECT 
     c.ciudad, 
     COUNT(*) AS num_clientes
   FROM 
     clientes c
   GROUP BY 
     c.ciudad
   ORDER BY 
     num_clientes DESC;
   ```

3. ¿Cuál fue el pago medio en 2009?

   ```sql
   SELECT AVG(p.cantidad) AS pago_medio
   FROM pagos p
   WHERE YEAR(p.fecha_pago) = 2009;
   ```

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
   descendente por el número de pedidos.

   ```sql
   SELECT estado, COUNT(*) AS num_pedidos
   FROM pedidos
   GROUP BY estado
   ORDER BY num_pedidos DESC;
   ```

5. Calcula el precio de venta del producto más caro y más barato en una
   misma consulta.

   ```sql
   SELECT 
     MAX(precio_venta) AS precio_mas_caro,
     MIN(precio_venta) AS precio_mas_barato
   FROM 
     productos;
   ```

6. Calcula el número de clientes que tiene la empresa.

   ```sql
   SELECT COUNT(*) AS num_clientes
   FROM clientes;
   ```

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```sql
   SELECT COUNT(*) AS num_clientes
   FROM clientes
   WHERE ciudad = 'Madrid';
   ```

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
   por M?

   ```sql
   SELECT ciudad, COUNT(*) AS num_clientes
   FROM clientes
   WHERE ciudad LIKE 'M%'
   GROUP BY ciudad;
   ```

9. Devuelve el nombre de los representantes de ventas y el número de clientes
   al que atiende cada uno.

   ```sql
   SELECT e.nombre, COUNT(c.codigo_cliente) AS num_clientes
   FROM empleados e
   JOIN clientes c ON e.codigo_empleado = c.representante_venta
   GROUP BY e.nombre;
   ```

10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```sql
    SELECT COUNT(*)
    FROM clientes
    WHERE representante_venta IS NULL;
    ```

11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```sql
    SELECT 
      c.nombre, 
      c.apellidos, 
      MIN(p.fecha_pago) AS primera_fecha_pago, 
      MAX(p.fecha_pago) AS ultima_fecha_pago
    FROM 
      clientes c
      JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
    GROUP BY 
      c.nombre, 
      c.apellidos;
    ```

12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```sql
    SELECT 
      p.codigo_pedido, 
      COUNT(DISTINCT dp.codigo_producto) AS num_productos
    FROM 
      pedidos p
      JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    GROUP BY 
      p.codigo_pedido;
    ```

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```sql
    SELECT 
      p.codigo_pedido, 
      SUM(dp.cantidad) AS cantidad_total
    FROM 
      pedidos p
      JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    GROUP BY 
      p.codigo_pedido;
    ```

14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```sql
    SELECT 
      p.nombre, 
      SUM(dp.cantidad) AS total_unidades_vendidas
    FROM 
      productos p
      JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
    GROUP BY 
      p.nombre
    ORDER BY 
      total_unidades_vendidas DESC
    LIMIT 20;
    ```

15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```sql
    SELECT 
      SUM(dp.cantidad * p.precio_venta) AS base_imponible,
      (SUM(dp.cantidad * p.precio_venta) * 0.21) AS iva,
      (SUM(dp.cantidad * p.precio_venta) * 1.21) AS total_facturado
    FROM 
      detalle_pedido dp
      JOIN pedidos p ON dp.codigo_pedido = p.codigo_pedido
      JOIN clientes c ON p.codigo_cliente = c.codigo_cliente
      JOIN empleados e ON c.representante_venta = e.codigo_empleado;
    ```

16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```sql
    SELECT 
      p.codigo_producto,
      SUM(dp.cantidad * p.precio_venta) AS base_imponible,
      (SUM(dp.cantidad * p.precio_venta) * 0.21) AS iva,
      (SUM(dp.cantidad * p.precio_venta) * 1.21) AS total_facturado
    FROM 
      detalle_pedido dp
      JOIN pedidos p ON dp.codigo_pedido = p.codigo_pedido
      JOIN clientes c ON p.codigo_cliente = c.codigo_cliente
      JOIN empleados e ON c.representante_venta = e.codigo_empleado
      JOIN productos pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY 
      p.codigo_producto;
    ```

17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```sql
    SELECT 
      p.codigo_producto,
      SUM(dp.cantidad * p.precio_venta) AS base_imponible,
      (SUM(dp.cantidad * p.precio_venta) * 0.21) AS iva,
      (SUM(dp.cantidad * p.precio_venta) * 1.21) AS total_facturado
    FROM 
      detalle_pedido dp
      JOIN pedidos p ON dp.codigo_pedido = p.codigo_pedido
      JOIN clientes c ON p.codigo_cliente = c.codigo_cliente
      JOIN empleados e ON c.representante_venta = e.codigo_empleado
      JOIN productos pr ON dp.codigo_producto = pr.codigo_producto
    WHERE 
      p.codigo_producto LIKE 'OR%'
    GROUP BY 
      p.codigo_producto;
    ```

18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```sql
    SELECT 
      p.nombre,
      SUM(dp.cantidad) AS unidades_vendidas,
      SUM(dp.cantidad * p.precio_venta) AS total_facturado,
      SUM(dp.cantidad * p.precio_venta * 1.21) AS total_facturado_iva
    FROM 
      detalle_pedido dp
      JOIN pedidos p ON dp.codigo_pedido = p.codigo_pedido
      JOIN clientes c ON p.codigo_cliente = c.codigo_cliente
      JOIN empleados e ON c.representante_venta = e.codigo_empleado
      JOIN productos pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY 
      p.nombre
    HAVING 
      SUM(dp.cantidad * p.precio_venta) > 3000;
    ```

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```sql
    SELECT 
      YEAR(fecha_pago) AS anio,
      SUM(cantidad) AS total_pagado
    FROM 
      pagos
    GROUP BY 
      anio
    ORDER BY 
      anio;
    ```

    

### Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
   pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
   han realizado ningún pedido.

   ```sql
   SELECT 
     c.nombre,
     COUNT(p.codigo_pedido) AS pedidos_realizados
   FROM 
     clientes c
     LEFT JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
   GROUP BY 
     c.nombre;
   ```

2. Devuelve un listado con los nombres de los clientes y el total pagado por
   cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
   realizado ningún pago.

   ```sql
   SELECT 
     c.nombre,
     c.apellidos,
     COALESCE(SUM(p.cantidad), 0) AS total_pagado
   FROM 
     clientes c
     LEFT JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   GROUP BY 
     c.nombre, c.apellidos
   ORDER BY 
     total_pagado DESC;
   ```

3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
   ordenados alfabéticamente de menor a mayor.

   ```sql
   SELECT DISTINCT c.nombre, c.apellidos
   FROM clientes c
   JOIN pedidos p ON c.codigo_cliente = p.codigo_cliente
   WHERE YEAR(p.fecha_esperada) = 2008
   ORDER BY c.nombre ASC, c.apellidos ASC;
   ```

4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

   ```sql
   SELECT 
     c.nombre AS cliente_nombre,
     e.nombre AS representante_nombre,
     SUBSTRING(e.apellidos, 1, 1) AS representante_apellido_inicial,
     o.telefono AS oficina_telefono
   FROM 
     clientes c
     LEFT JOIN empleados re ON c.representante_venta = re.codigo_empleado
     LEFT JOIN empleados jefe ON re.codigo_jefe = jefe.codigo_empleado
     LEFT JOIN oficinas o ON jefe.oficina = o.codigo_oficina
     LEFT JOIN pagos p ON c.codigo_cliente = p.codigo_cliente
   WHERE 
     p.codigo_pago IS NULL
   ORDER BY 
     cliente_nombre ASC;
   ```

5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
   nombre y primer apellido de su representante de ventas y la ciudad donde
   está su oficina.

   ```sql
   SELECT 
     c.nombre AS cliente_nombre,
     CONCAT(e.nombre, ' ', SUBSTRING(e.apellidos, 1, 1)) AS representante_nombre_apellido_inicial,
     o.ciudad AS oficina_ciudad
   FROM 
     clientes c
     JOIN empleados re ON c.representante_venta = re.codigo_empleado
     JOIN empleados jefe ON re.codigo_jefe = jefe.codigo_empleado
     JOIN oficinas o ON jefe.oficina = o.codigo_oficina;
   ```

6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
   empleados que no sean representante de ventas de ningún cliente.

   ```sql
   SELECT 
     e.nombre,
     e.apellidos,
     e.puesto,
     o.telefono
   FROM 
     empleados e
     LEFT JOIN clientes c ON e.codigo_empleado = c.representante_venta
     LEFT JOIN oficinas o ON e.oficina = o.codigo_oficina
   WHERE 
     c.codigo_cliente IS NULL;
   ```

7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
   número de empleados que tiene.

   ```sql
   SELECT 
     o.ciudad,
     COUNT(e.codigo_empleado) AS num_empleados
   FROM 
     oficinas o
     LEFT JOIN empleados e ON o.codigo_oficina = e.oficina
   GROUP BY 
     o.ciudad;
   ```

   
