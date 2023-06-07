use sprint3;
-- Crear tabla Proveedor
CREATE TABLE Proveedor (
  id_proveedor INT PRIMARY KEY,
  nombre_representante VARCHAR(50),
  nombre_corporativo VARCHAR(100),
  telefono1 VARCHAR(15),
  telefono2 VARCHAR(15),
  contacto_llamadas VARCHAR(50),
  categoria VARCHAR(50),
  correo_facturacion VARCHAR(100)
);

-- Insertar datos en la tabla Proveedor
INSERT INTO Proveedor (id_proveedor, nombre_representante, nombre_corporativo, telefono1, telefono2, contacto_llamadas, categoria, correo_facturacion)
VALUES
  (1, 'Representante1', 'Corporativo1', '111111111', '111111112', 'Contacto1', 'Electrónicos', 'correo1@proveedor1.com'),
  (2, 'Representante2', 'Corporativo2', '222222221', '222222222', 'Contacto2', 'Electrónicos', 'correo2@proveedor2.com'),
  (3, 'Representante3', 'Corporativo3', '333333331', '333333332', 'Contacto3', 'Electrónicos', 'correo3@proveedor3.com'),
  (4, 'Representante4', 'Corporativo4', '444444441', '444444442', 'Contacto4', 'Electrónicos', 'correo4@proveedor4.com'),
  (5, 'Representante5', 'Corporativo5', '555555551', '555555552', 'Contacto5', 'Electrónicos', 'correo5@proveedor5.com');

-- Crear tabla Cliente
CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  direccion VARCHAR(100)
);

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (id_cliente, nombre, apellido, direccion)
VALUES
  (1, 'Cliente1', 'Apellido1', 'Dirección1'),
  (2, 'Cliente2', 'Apellido2', 'Dirección2'),
  (3, 'Cliente3', 'Apellido3', 'Dirección3'),
  (4, 'Cliente4', 'Apellido4', 'Dirección4'),
  (5, 'Cliente5', 'Apellido5', 'Dirección5');

-- Crear tabla Producto
CREATE TABLE Producto (
  id_producto INT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10, 2),
  categoria VARCHAR(50),
  color VARCHAR(50)
);

-- Insertar datos en la tabla Producto
INSERT INTO Producto (id_producto, nombre, precio, categoria, color)
VALUES
  (1, 'Producto1', 10.99, 'Electrónicos', 'Rojo'),
  (2, 'Producto2', 19.99, 'Electrónicos', 'Negro'),
  (3, 'Producto3', 5.99, 'Electrónicos', 'Azul'),
  (4, 'Producto4', 8.99, 'Electrónicos', 'Blanco'),
  (5, 'Producto5', 15.99, 'Electrónicos', 'Verde'),
  (6, 'Producto6', 12.99, 'Electrónicos', 'Rojo'),
  (7, 'Producto7', 9.99, 'Electrónicos', 'Negro'),
  (8, 'Producto8', 14.99, 'Electrónicos', 'Azul'),
  (9, 'Producto9', 7.99, 'Electrónicos', 'Blanco'),
  (10, 'Producto10', 11.99, 'Electrónicos', 'Verde');

-- Crear tabla Proveedor_Producto
CREATE TABLE Proveedor_Producto (
  id_proveedor_producto INT PRIMARY KEY,
  id_proveedor INT,
  id_producto INT,
  stock INT,
  FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Insertar datos en la tabla Proveedor_Producto
INSERT INTO Proveedor_Producto (id_proveedor_producto, id_proveedor, id_producto, stock)
VALUES
  (1, 1, 1, 50),
  (2, 1, 2, 100),
  (3, 2, 3, 30),
  (4, 2, 4, 20),
  (5, 3, 5, 80),
  (6, 3, 6, 10),
  (7, 4, 7, 40),
  (8, 4, 8, 70),
  (9, 5, 9, 15),
  (10, 5, 10, 5);

#Cuál es la categoría de productos que más se repite:
SELECT categoria, COUNT(*) AS cantidad
FROM Producto
GROUP BY categoria
ORDER BY cantidad DESC
LIMIT 1;

#Cuáles son los productos con mayor stock:
SELECT p.nombre, pp.stock
FROM Producto p
INNER JOIN Proveedor_Producto pp ON p.id_producto = pp.id_producto
ORDER BY pp.stock DESC
LIMIT 5;

#Qué color de producto es más común en nuestra tienda:
SELECT color, COUNT(*) AS cantidad
FROM Producto
GROUP BY color
ORDER BY cantidad DESC
LIMIT 1;

#Cual o cuales son los proveedores con menor stock de productos:
SELECT pr.nombre_representante, SUM(pp.stock) AS total_stock
FROM Proveedor pr
INNER JOIN Proveedor_Producto pp ON pr.id_proveedor = pp.id_proveedor
GROUP BY pr.nombre_representante
ORDER BY total_stock ASC
LIMIT 5;


#Cambiar la categoría de productos más popular por 'Electrónica y computación':
UPDATE Producto
SET categoria = 'Electrónica y computación'
WHERE id_producto IN (
  SELECT id_producto
  FROM (
    SELECT id_producto, categoria
    FROM Producto
    GROUP BY id_producto, categoria
    ORDER BY COUNT(*) DESC
    LIMIT 1
  ) AS subquery
);





