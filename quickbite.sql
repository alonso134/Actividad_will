-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-02-2024 a las 02:37:53
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `quickbite`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente` (IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(50), IN `p_telefono` VARCHAR(10), IN `p_direccion` VARCHAR(255))   BEGIN
    DECLARE cliente_uuid VARCHAR(36);

    -- Generar UUID para el cliente
    SET cliente_uuid = UUID();

    -- Insertar el nuevo cliente
    INSERT INTO clientes (cliente_id, nombre, apellido, telefono, direccion)
    VALUES (cliente_uuid, p_nombre, p_apellido, p_telefono, p_direccion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarDetallePedido` (IN `p_pedido_id` VARCHAR(36), IN `p_producto_id` VARCHAR(36), IN `p_cantidad` INT, IN `p_precio_unitario` DECIMAL(10,2), IN `p_subtotal` DECIMAL(10,2))   BEGIN
    DECLARE detalle_uuid VARCHAR(36);

    -- Generar UUID para el detalle
    SET detalle_uuid = UUID();

    -- Insertar el nuevo detalle de pedido
    INSERT INTO detalles_pedido (detalle_id, pedido_id, producto_id, cantidad, precio_unitario, subtotal)
    VALUES (detalle_uuid, p_pedido_id, p_producto_id, p_cantidad, p_precio_unitario, p_subtotal);
    
    -- Actualizar existencias del producto (llamando al trigger)
    -- Esto asume que el trigger se activa después de la inserción en detalles_pedido
    INSERT INTO productos_dummy (dummy) VALUES (NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEmpleado` (IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(50), IN `p_cargo` VARCHAR(50), IN `p_fecha_contratacion` DATE, IN `p_salario` DECIMAL(10,2))   BEGIN
    DECLARE empleado_uuid VARCHAR(36);

    -- Generar UUID para el empleado
    SET empleado_uuid = UUID();

    -- Insertar el nuevo empleado
    INSERT INTO empleados (empleado_id, nombre, apellido, cargo, fecha_contratacion, salario)
    VALUES (empleado_uuid, p_nombre, p_apellido, p_cargo, p_fecha_contratacion, p_salario);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPedido` (IN `p_cliente_id` VARCHAR(36), IN `p_fecha_pedido` DATE, IN `p_total` DECIMAL(10,2), IN `p_estado` VARCHAR(20), IN `p_empleado_id` VARCHAR(36))   BEGIN
    DECLARE pedido_uuid VARCHAR(36);

    -- Generar UUID para el pedido
    SET pedido_uuid = UUID();

    -- Insertar el nuevo pedido
    INSERT INTO pedidos (pedido_id, cliente_id, fecha_pedido, total, estado, empleado_id)
    VALUES (pedido_uuid, p_cliente_id, p_fecha_pedido, p_total, p_estado, p_empleado_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto` (IN `p_nombre` VARCHAR(100), IN `p_descripcion` VARCHAR(255), IN `p_precio` DECIMAL(10,2), IN `p_existencias` INT)   BEGIN
    DECLARE producto_uuid VARCHAR(36);

    -- Generar UUID para el producto
    SET producto_uuid = UUID();

    -- Insertar el nuevo producto
    INSERT INTO productos (producto_id, nombre, descripcion, precio, existencias)
    VALUES (producto_uuid, p_nombre, p_descripcion, p_precio, p_existencias);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` varchar(36) NOT NULL DEFAULT uuid(),
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES
('2563ec2d-d690-11ee-89ac-00ff2926a2f1', 'Luis', 'Martínez', '5551234567', 'Calle C, Pueblo Nuevo'),
('256b6932-d690-11ee-89ac-00ff2926a2f1', 'Laura', 'García', '5559876543', 'Avenida D, Ciudad Vieja'),
('25702092-d690-11ee-89ac-00ff2926a2f1', 'Pedro', 'Hernández', '5555678901', 'Calle E, Barrio Antiguo'),
('25749c3a-d690-11ee-89ac-00ff2926a2f1', 'Ana', 'Ramírez', '5552345678', 'Avenida F, Nuevo Horizonte'),
('2579e913-d690-11ee-89ac-00ff2926a2f1', 'Miguel', 'Díaz', '5558765432', 'Calle G, Villa Nueva'),
('257e8838-d690-11ee-89ac-00ff2926a2f1', 'Isabel', 'Gutiérrez', '5557890123', 'Avenida H, Pueblo Libre'),
('25832c55-d690-11ee-89ac-00ff2926a2f1', 'Javier', 'López', '5553456789', 'Calle I, Barrio Moderno'),
('2587ac4a-d690-11ee-89ac-00ff2926a2f1', 'Carmen', 'Fernández', '5559012345', 'Avenida J, Ciudad Nueva'),
('258c1377-d690-11ee-89ac-00ff2926a2f1', 'Gabriel', 'Sánchez', '5554567890', 'Calle K, Barrio Feliz'),
('25902d1e-d690-11ee-89ac-00ff2926a2f1', 'Adriana', 'Torres', '5551098765', 'Avenida L, Pueblo Alegre'),
('25943ab8-d690-11ee-89ac-00ff2926a2f1', 'Ricardo', 'Ortega', '5556789012', 'Calle M, Villa Feliz'),
('2598d1b9-d690-11ee-89ac-00ff2926a2f1', 'Sofía', 'Núñez', '5551237890', 'Avenida N, Ciudad Contenta'),
('6aabdfca-d68e-11ee-89ac-00ff2926a2f1', 'Juan', 'Perez', '1234567890', 'Calle A, Ciudad'),
('6abc5067-d68e-11ee-89ac-00ff2926a2f1', 'María', 'Gómez', '9876543210', 'Avenida B, Pueblo'),
('89eaedfc-d691-11ee-89ac-00ff2926a2f1', 'Raul', 'González', '5555555555', 'Calle O, Pueblo Nuevo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `detalle_id` varchar(36) NOT NULL DEFAULT uuid(),
  `pedido_id` varchar(36) DEFAULT NULL,
  `producto_id` varchar(36) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_pedido`
--

INSERT INTO `detalles_pedido` (`detalle_id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
('01847943-d6a2-11ee-89ac-00ff2926a2f1', 'bfcbaaf1-d696-11ee-89ac-00ff2926a2f1', 'cfaaa135-d691-11ee-89ac-00ff2926a2f1', 2, 120.00, 240.00),
('06cd01f2-d6a2-11ee-89ac-00ff2926a2f1', '90caf47c-d69b-11ee-89ac-00ff2926a2f1', 'cf97d89e-d691-11ee-89ac-00ff2926a2f1', 2, 50.00, 100.00),
('09a286a3-d6a2-11ee-89ac-00ff2926a2f1', '77277d0d-d697-11ee-89ac-00ff2926a2f1', 'cfa1efd0-d691-11ee-89ac-00ff2926a2f1', 2, 20.00, 40.00),
('0f28e0ce-d6a2-11ee-89ac-00ff2926a2f1', 'bfc5d224-d696-11ee-89ac-00ff2926a2f1', 'cfaf31fb-d691-11ee-89ac-00ff2926a2f1', 2, 40.00, 80.00),
('11e97efd-d6a0-11ee-89ac-00ff2926a2f1', '71244797-d698-11ee-89ac-00ff2926a2f1', 'e892e1ec-d691-11ee-89ac-00ff2926a2f1', 2, 600.00, 1200.00),
('15e65a17-d6a2-11ee-89ac-00ff2926a2f1', '772f519a-d697-11ee-89ac-00ff2926a2f1', 'cf9c8ded-d691-11ee-89ac-00ff2926a2f1', 2, 80.00, 160.00),
('199dd69b-d6a2-11ee-89ac-00ff2926a2f1', '7117dc67-d698-11ee-89ac-00ff2926a2f1', 'cf93374b-d691-11ee-89ac-00ff2926a2f1', 2, 200.00, 400.00),
('1d130a37-d6a2-11ee-89ac-00ff2926a2f1', '90e3e9ca-d69b-11ee-89ac-00ff2926a2f1', 'cf8e9289-d691-11ee-89ac-00ff2926a2f1', 2, 30.00, 60.00),
('23c7af54-d6a2-11ee-89ac-00ff2926a2f1', '229e0ba2-d698-11ee-89ac-00ff2926a2f1', 'cfbbbba3-d691-11ee-89ac-00ff2926a2f1', 2, 60.00, 120.00),
('270c9090-d6a2-11ee-89ac-00ff2926a2f1', '711e5c50-d698-11ee-89ac-00ff2926a2f1', 'cfc038e1-d691-11ee-89ac-00ff2926a2f1', 2, 1200.00, 2400.00),
('5900e66f-d6a1-11ee-89ac-00ff2926a2f1', '710d9dbb-d698-11ee-89ac-00ff2926a2f1', 'cfb395b3-d691-11ee-89ac-00ff2926a2f1', 2, 25.00, 50.00),
('8d5c89e8-d6a1-11ee-89ac-00ff2926a2f1', '90dd60d1-d69b-11ee-89ac-00ff2926a2f1', 'cfa5ef58-d691-11ee-89ac-00ff2926a2f1', 2, 70.00, 140.00),
('d4cec674-d6a1-11ee-89ac-00ff2926a2f1', 'bfbd142d-d696-11ee-89ac-00ff2926a2f1', 'cfb7c9fb-d691-11ee-89ac-00ff2926a2f1', 2, 35.00, 70.00),
('dad93182-d6a0-11ee-89ac-00ff2926a2f1', 'bfb6dc86-d696-11ee-89ac-00ff2926a2f1', 'cfc4916b-d691-11ee-89ac-00ff2926a2f1', 2, 500.00, 1000.00),
('f8177122-d6a0-11ee-89ac-00ff2926a2f1', '77131b2c-d697-11ee-89ac-00ff2926a2f1', 'cf7e3ee9-d691-11ee-89ac-00ff2926a2f1', 2, 150.00, 300.00);

--
-- Disparadores `detalles_pedido`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pedido` AFTER INSERT ON `detalles_pedido` FOR EACH ROW BEGIN
    DECLARE producto_existencias INT;

    -- Obtener las existencias actuales del producto
    SELECT existencias INTO producto_existencias
    FROM productos
    WHERE producto_id = NEW.producto_id;

    -- Actualizar las existencias restando la cantidad comprada
    UPDATE productos
    SET existencias = producto_existencias - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `empleado_id` varchar(36) NOT NULL DEFAULT uuid(),
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`empleado_id`, `nombre`, `apellido`, `cargo`, `fecha_contratacion`, `salario`) VALUES
('0c9cf71c-d691-11ee-89ac-00ff2926a2f1', 'Elena', 'Gómez', 'Asistente', '2023-03-10', 38000.00),
('0ca4b24e-d691-11ee-89ac-00ff2926a2f1', 'Francisco', 'Martínez', 'Vendedor', '2023-06-25', 42000.00),
('0ca9970a-d691-11ee-89ac-00ff2926a2f1', 'Carolina', 'Hernández', 'Gerente de Ventas', '2023-02-15', 58000.00),
('0cae55ca-d691-11ee-89ac-00ff2926a2f1', 'David', 'Ramírez', 'Analista de Marketing', '2023-08-05', 50000.00),
('0cb30ba8-d691-11ee-89ac-00ff2926a2f1', 'Isaac', 'García', 'Desarrollador', '2023-04-20', 55000.00),
('0cb7b50c-d691-11ee-89ac-00ff2926a2f1', 'Marta', 'López', 'Asistente de Ventas', '2023-01-08', 40000.00),
('0cbca514-d691-11ee-89ac-00ff2926a2f1', 'Roberto', 'Fernández', 'Jefe de Proyectos', '2023-11-15', 65000.00),
('0cc17d54-d691-11ee-89ac-00ff2926a2f1', 'Alicia', 'Díaz', 'Analista de Finanzas', '2023-07-30', 52000.00),
('0cc6272d-d691-11ee-89ac-00ff2926a2f1', 'Pablo', 'Ortega', 'Recepcionista', '2023-09-18', 35000.00),
('0ccb0a18-d691-11ee-89ac-00ff2926a2f1', 'Lorena', 'Sánchez', 'Diseñador Gráfico', '2023-12-05', 48000.00),
('0ccfc931-d691-11ee-89ac-00ff2926a2f1', 'Jorge', 'Núñez', 'Analista de Sistemas', '2023-10-10', 60000.00),
('0cd45203-d691-11ee-89ac-00ff2926a2f1', 'Clara', 'Torres', 'Asistente Administrativo', '2023-05-05', 40000.00),
('6c63cd16-d691-11ee-89ac-00ff2926a2f1', 'Alejandro', 'Mendoza', 'Analista de Recursos Humanos', '2023-09-30', 48000.00),
('dedfc34d-d690-11ee-89ac-00ff2926a2f1', 'Carlos', 'Rodríguez', 'Gerente', '2023-01-15', 60000.00),
('def0571d-d690-11ee-89ac-00ff2926a2f1', 'Ana', 'López', 'Vendedor', '2023-05-20', 45000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `pedido_id` varchar(36) NOT NULL DEFAULT uuid(),
  `cliente_id` varchar(36) DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `empleado_id` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`pedido_id`, `cliente_id`, `fecha_pedido`, `total`, `estado`, `empleado_id`) VALUES
('229e0ba2-d698-11ee-89ac-00ff2926a2f1', '257e8838-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', 'def0571d-d690-11ee-89ac-00ff2926a2f1'),
('710d9dbb-d698-11ee-89ac-00ff2926a2f1', '25902d1e-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0ccfc931-d691-11ee-89ac-00ff2926a2f1'),
('7117dc67-d698-11ee-89ac-00ff2926a2f1', '25943ab8-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0cd45203-d691-11ee-89ac-00ff2926a2f1'),
('711e5c50-d698-11ee-89ac-00ff2926a2f1', '2598d1b9-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '6c63cd16-d691-11ee-89ac-00ff2926a2f1'),
('71244797-d698-11ee-89ac-00ff2926a2f1', '89eaedfc-d691-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', 'dedfc34d-d690-11ee-89ac-00ff2926a2f1'),
('77131b2c-d697-11ee-89ac-00ff2926a2f1', '25832c55-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0cc17d54-d691-11ee-89ac-00ff2926a2f1'),
('77277d0d-d697-11ee-89ac-00ff2926a2f1', '2587ac4a-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0cc6272d-d691-11ee-89ac-00ff2926a2f1'),
('772f519a-d697-11ee-89ac-00ff2926a2f1', '258c1377-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0ccb0a18-d691-11ee-89ac-00ff2926a2f1'),
('90caf47c-d69b-11ee-89ac-00ff2926a2f1', '25749c3a-d690-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0ca9970a-d691-11ee-89ac-00ff2926a2f1'),
('90dd60d1-d69b-11ee-89ac-00ff2926a2f1', '6aabdfca-d68e-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0cae55ca-d691-11ee-89ac-00ff2926a2f1'),
('90e3e9ca-d69b-11ee-89ac-00ff2926a2f1', '6abc5067-d68e-11ee-89ac-00ff2926a2f1', '2024-03-17', 200.00, 'En Proceso', '0cb7b50c-d691-11ee-89ac-00ff2926a2f1'),
('bfb6dc86-d696-11ee-89ac-00ff2926a2f1', '2563ec2d-d690-11ee-89ac-00ff2926a2f1', '2024-03-15', 250.00, 'En Proceso', '0ca4b24e-d691-11ee-89ac-00ff2926a2f1'),
('bfbd142d-d696-11ee-89ac-00ff2926a2f1', '256b6932-d690-11ee-89ac-00ff2926a2f1', '2024-03-15', 250.00, 'En Proceso', '0c9cf71c-d691-11ee-89ac-00ff2926a2f1'),
('bfc5d224-d696-11ee-89ac-00ff2926a2f1', '25702092-d690-11ee-89ac-00ff2926a2f1', '2024-03-15', 250.00, 'En Proceso', '0cb30ba8-d691-11ee-89ac-00ff2926a2f1'),
('bfcbaaf1-d696-11ee-89ac-00ff2926a2f1', '2579e913-d690-11ee-89ac-00ff2926a2f1', '2024-03-15', 250.00, 'En Proceso', '0cbca514-d691-11ee-89ac-00ff2926a2f1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `producto_id` varchar(36) NOT NULL DEFAULT uuid(),
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `existencias` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`producto_id`, `nombre`, `descripcion`, `precio`, `existencias`) VALUES
('cf7e3ee9-d691-11ee-89ac-00ff2926a2f1', 'Monitor HD', 'Monitor de alta definición 24 pulgadas', 150.00, 28),
('cf8e9289-d691-11ee-89ac-00ff2926a2f1', 'Teclado inalámbrico', 'Teclado compacto con conexión Bluetooth', 30.00, 48),
('cf93374b-d691-11ee-89ac-00ff2926a2f1', 'Impresora láser', 'Impresora monocromática de alta velocidad', 200.00, 13),
('cf97d89e-d691-11ee-89ac-00ff2926a2f1', 'Cámara web HD', 'Cámara web para videoconferencias de alta resolución', 50.00, 38),
('cf9c8ded-d691-11ee-89ac-00ff2926a2f1', 'Auriculares Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 80.00, 21),
('cfa1efd0-d691-11ee-89ac-00ff2926a2f1', 'Mouse ergonómico', 'Mouse óptico ergonómico para mayor comodidad', 20.00, 58),
('cfa5ef58-d691-11ee-89ac-00ff2926a2f1', 'Disco duro externo', 'Almacenamiento externo de 1TB USB 3.0', 70.00, 8),
('cfaaa135-d691-11ee-89ac-00ff2926a2f1', 'Tablet Android', 'Tableta táctil con sistema operativo Android', 120.00, 16),
('cfaf31fb-d691-11ee-89ac-00ff2926a2f1', 'Altavoces Bluetooth', 'Altavoces portátiles con conectividad Bluetooth', 40.00, 33),
('cfb395b3-d691-11ee-89ac-00ff2926a2f1', 'Lámpara LED', 'Lámpara de escritorio LED con ajuste de intensidad', 25.00, 48),
('cfb7c9fb-d691-11ee-89ac-00ff2926a2f1', 'Mochila para laptop', 'Mochila resistente para laptops de hasta 15 pulgadas', 35.00, 28),
('cfbbbba3-d691-11ee-89ac-00ff2926a2f1', 'Licuadora de alta potencia', 'Licuadora con motor de 1000W y cuchillas de acero inoxidable', 60.00, 10),
('cfc038e1-d691-11ee-89ac-00ff2926a2f1', 'Laptop', 'Portátil de alta gama', 1200.00, 48),
('cfc4916b-d691-11ee-89ac-00ff2926a2f1', 'Smartphone', 'Teléfono inteligente', 500.00, 98),
('e892e1ec-d691-11ee-89ac-00ff2926a2f1', 'Smart TV 4K', 'Televisor inteligente de 55 pulgadas con resolución 4K', 600.00, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Indices de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`detalle_id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`empleado_id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`pedido_id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `empleado_id` (`empleado_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`producto_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD CONSTRAINT `detalles_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`),
  ADD CONSTRAINT `detalles_pedido_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
