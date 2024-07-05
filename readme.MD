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

    

