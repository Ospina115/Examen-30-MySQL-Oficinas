# **SOLUCION CASOS DE USO:**

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

    