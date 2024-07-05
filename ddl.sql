-- Table: oficinas
CREATE TABLE oficinas (
  codigo_oficina INT PRIMARY KEY,
  ciudad VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL
);

-- Table: empleados
CREATE TABLE empleados (
  codigo_empleado INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_jefe INT,
  puesto VARCHAR(50) NOT NULL,
  FOREIGN KEY (codigo_jefe) REFERENCES empleados(codigo_empleado)
);

-- Table: clientes
CREATE TABLE clientes (
  codigo_cliente INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  representante_venta INT,
  FOREIGN KEY (representante_venta) REFERENCES empleados(codigo_empleado)
);

-- Table: pedidos
CREATE TABLE pedidos (
  codigo_pedido INT PRIMARY KEY,
  codigo_cliente INT NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE,
  estado VARCHAR(50) NOT NULL,
  FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo_cliente)
);

-- Table: pagos
CREATE TABLE pagos (
  codigo_pago INT PRIMARY KEY,
  codigo_cliente INT NOT NULL,
  fecha_pago DATE NOT NULL,
  forma_pago VARCHAR(50) NOT NULL,
  cantidad DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo_cliente)
);

-- Table: productos
CREATE TABLE productos (
  codigo_producto INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  imagen VARCHAR(100) NOT NULL,
  precio_venta DECIMAL(10, 2) NOT NULL,
  gama VARCHAR(50) NOT NULL
);

-- Table: detalle_pedido
CREATE TABLE detalle_pedido (
  codigo_pedido INT NOT NULL,
  codigo_producto INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY (codigo_pedido, codigo_producto),
  FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido),
  FOREIGN KEY (codigo_producto) REFERENCES productos(codigo_producto)
);