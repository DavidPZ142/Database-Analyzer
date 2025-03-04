CREATE DATABASE supermarket;
USE supermarket;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    supplier VARCHAR(100),
    barcode VARCHAR(50) UNIQUE,
    weight DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '555-1234', 'Calle Falsa 123', 'Ciudad de México', 'CDMX', '01000'),
('María', 'González', 'maria.gonzalez@email.com', '555-5678', 'Avenida Siempre Viva 742', 'Guadalajara', 'Jalisco', '44100'),
('Carlos', 'Ramírez', 'carlos.ramirez@email.com', '555-8765', 'Callejón del Beso 12', 'Monterrey', 'Nuevo León', '64000'),
('Ana', 'Fernández', 'ana.fernandez@email.com', '555-4321', 'Plaza Mayor 5', 'León', 'Guanajuato', '37000'),
('Pedro', 'Sánchez', 'pedro.sanchez@email.com', '555-3456', 'Calle 8', 'Mérida', 'Yucatán', '97000'),
('Sofía', 'López', 'sofia.lopez@email.com', '555-9876', 'Av. Juárez 77', 'Puebla', 'Puebla', '72000'),
('Diego', 'Torres', 'diego.torres@email.com', '555-2222', 'Calle Revolución 11', 'Tijuana', 'Baja California', '22000'),
('Lucía', 'Martínez', 'lucia.martinez@email.com', '555-3333', 'Paseo de la Reforma 300', 'Ciudad de México', 'CDMX', '06600'),
('Andrés', 'Hernández', 'andres.hernandez@email.com', '555-4444', 'Calle Bolívar 20', 'Oaxaca', 'Oaxaca', '68000'),
('Carmen', 'Díaz', 'carmen.diaz@email.com', '555-5555', 'Calle Morelos 15', 'Querétaro', 'Querétaro', '76000'),
('Jorge', 'Ortega', 'jorge.ortega@email.com', '555-6666', 'Blvd. Insurgentes 88', 'Mexicali', 'Baja California', '21000'),
('Elena', 'Navarro', 'elena.navarro@email.com', '555-7777', 'Calle Hidalgo 30', 'Aguascalientes', 'Aguascalientes', '20000'),
('Fernando', 'Rojas', 'fernando.rojas@email.com', '555-8888', 'Calle Victoria 50', 'Veracruz', 'Veracruz', '91700'),
('Isabel', 'Moreno', 'isabel.moreno@email.com', '555-9999', 'Av. Chapultepec 99', 'Morelia', 'Michoacán', '58000'),
('Ricardo', 'Castro', 'ricardo.castro@email.com', '555-1010', 'Calle Juárez 60', 'Saltillo', 'Coahuila', '25000'),
('Paula', 'Vega', 'paula.vega@email.com', '555-1111', 'Paseo Montejo 40', 'Campeche', 'Campeche', '24000'),
('Héctor', 'Mendoza', 'hector.mendoza@email.com', '555-1212', 'Calle Colón 70', 'Toluca', 'Estado de México', '50000'),
('Adriana', 'Flores', 'adriana.flores@email.com', '555-1313', 'Av. Constitución 101', 'San Luis Potosí', 'SLP', '78000'),
('Manuel', 'Aguilar', 'manuel.aguilar@email.com', '555-1414', 'Calle Independencia 32', 'Culiacán', 'Sinaloa', '80000'),
('Natalia', 'Guerrero', 'natalia.guerrero@email.com', '555-1515', 'Blvd. del Mar 55', 'La Paz', 'Baja California Sur', '23000');

INSERT INTO products (name, description, category, price, stock_quantity, supplier, barcode, weight) VALUES
('Laptop Dell Inspiron', 'Laptop de 15.6 pulgadas con procesador Intel Core i5', 'Electrónica', 799.99, 25, 'Dell', '1234567890123', 2.5),
('Smartphone Samsung Galaxy S21', 'Teléfono inteligente con pantalla AMOLED de 6.2 pulgadas', 'Electrónica', 999.99, 30, 'Samsung', '9876543210987', 0.17),
('Mouse Inalámbrico Logitech', 'Mouse óptico inalámbrico con conexión Bluetooth', 'Accesorios', 29.99, 50, 'Logitech', '4561237896543', 0.1),
('Teclado Mecánico Redragon', 'Teclado mecánico RGB con switches rojos', 'Accesorios', 59.99, 40, 'Redragon', '3217894561234', 0.8),
('Monitor LG 24”', 'Monitor LED Full HD de 24 pulgadas', 'Electrónica', 189.99, 20, 'LG', '8529637412589', 3.5),
('Silla Gamer Razer', 'Silla ergonómica con soporte lumbar ajustable', 'Muebles', 299.99, 15, 'Razer', '1597534862589', 15.0),
('Auriculares Sony WH-1000XM4', 'Auriculares inalámbricos con cancelación de ruido', 'Audio', 349.99, 25, 'Sony', '3698521479632', 0.3),
('Disco Duro Externo WD 2TB', 'Disco duro portátil USB 3.0', 'Almacenamiento', 89.99, 35, 'Western Digital', '9517538527412', 0.25),
('Impresora HP LaserJet', 'Impresora láser monocromática', 'Oficina', 199.99, 10, 'HP', '1237896548521', 5.0),
('Tablet Apple iPad Air', 'Tablet de 10.9 pulgadas con chip A14 Bionic', 'Electrónica', 599.99, 18, 'Apple', '8521479632587', 0.46),
('Cámara Canon EOS M50', 'Cámara digital sin espejo con lente 15-45mm', 'Fotografía', 699.99, 12, 'Canon', '7412589631478', 0.9),
('Smartwatch Garmin Fenix 6', 'Reloj inteligente con GPS y pulsómetro', 'Wearables', 549.99, 22, 'Garmin', '3579518526541', 0.08),
('Router TP-Link Archer', 'Router inalámbrico de doble banda', 'Redes', 79.99, 28, 'TP-Link', '4569873216547', 0.5),
('SSD NVMe Samsung 1TB', 'Unidad de estado sólido PCIe Gen4', 'Almacenamiento', 149.99, 45, 'Samsung', '6547893214567', 0.04),
('Microondas Panasonic', 'Microondas de 1000W con grill', 'Electrodomésticos', 129.99, 10, 'Panasonic', '3574568521596', 12.0),
('Cafetera Nespresso', 'Máquina de café de cápsulas con espumador', 'Cocina', 169.99, 18, 'Nespresso', '8524563579514', 3.2),
('Licuadora Oster', 'Licuadora de alta potencia con jarra de vidrio', 'Cocina', 89.99, 20, 'Oster', '9513578526541', 4.5),
('Aspiradora Dyson V11', 'Aspiradora sin cable con potencia ciclónica', 'Hogar', 499.99, 8, 'Dyson', '7896541238524', 2.9),
('Parlante JBL Charge 5', 'Altavoz portátil Bluetooth resistente al agua', 'Audio', 179.99, 30, 'JBL', '4561597538526', 0.98),
('Bicicleta Trek Marlin 5', 'Bicicleta de montaña con cuadro de aluminio', 'Deportes', 699.99, 5, 'Trek', '1593578524569', 14.2);

INSERT INTO branches (name, address, city, state, postal_code, country, phone, email) VALUES
('Downtown Branch', '123 Main St', 'New York', 'NY', '10001', 'USA', '+1 212-555-1234', 'downtown@company.com'),
('Westside Office', '456 Elm St', 'Los Angeles', 'CA', '90012', 'USA', '+1 310-555-5678', 'westside@company.com'),
('Central HQ', '789 Oak St', 'Chicago', 'IL', '60601', 'USA', '+1 312-555-7890', 'hq@company.com'),
('London Hub', '10 Downing St', 'London', 'Greater London', 'SW1A 2AA', 'UK', '+44 20 7946 0958', 'london@company.com'),
('Berlin Office', 'Friedrichstr. 68', 'Berlin', 'Berlin', '10117', 'Germany', '+49 30 555-9876', 'berlin@company.com'),
('Tokyo Branch', 'Shibuya Crossing 1', 'Tokyo', 'Tokyo', '150-0002', 'Japan', '+81 3-5555-6789', 'tokyo@company.com');

INSERT INTO transactions (user_id, product_id, quantity, total_price, payment_method, status) VALUES
(5, 3, 2, 59.98, 'Credit Card', 'completed'),
(12, 7, 1, 349.99, 'PayPal', 'pending'),
(8, 15, 1, 129.99, 'Debit Card', 'completed'),
(3, 1, 1, 799.99, 'Credit Card', 'shipped'),
(17, 9, 3, 599.97, 'Bank Transfer', 'completed'),
(2, 5, 1, 189.99, 'Credit Card', 'pending'),
(10, 18, 2, 999.98, 'PayPal', 'shipped'),
(15, 4, 1, 59.99, 'Credit Card', 'completed'),
(1, 12, 1, 549.99, 'Debit Card', 'canceled'),
(18, 6, 1, 299.99, 'Credit Card', 'shipped'),
(9, 16, 1, 169.99, 'PayPal', 'completed'),
(14, 2, 2, 1999.98, 'Bank Transfer', 'pending'),
(6, 11, 1, 699.99, 'Credit Card', 'completed'),
(4, 13, 1, 79.99, 'PayPal', 'completed'),
(16, 20, 1, 699.99, 'Debit Card', 'pending'),
(7, 8, 2, 179.98, 'Credit Card', 'completed'),
(11, 19, 1, 179.99, 'Bank Transfer', 'completed'),
(20, 14, 3, 449.97, 'PayPal', 'shipped'),
(13, 10, 1, 599.99, 'Credit Card', 'completed'),
(19, 17, 1, 89.99, 'Debit Card', 'pending'),
(8, 2, 1, 999.99, 'Credit Card', 'completed'),
(5, 15, 2, 259.98, 'PayPal', 'shipped'),
(12, 7, 1, 349.99, 'Credit Card', 'completed'),
(3, 1, 1, 799.99, 'Debit Card', 'pending'),
(17, 9, 2, 399.98, 'Credit Card', 'completed'),
(2, 5, 1, 189.99, 'Bank Transfer', 'completed'),
(10, 18, 1, 499.99, 'Credit Card', 'canceled'),
(15, 4, 3, 179.97, 'PayPal', 'completed'),
(1, 12, 1, 549.99, 'Debit Card', 'shipped'),
(18, 6, 2, 599.98, 'Credit Card', 'completed'),
(9, 16, 1, 169.99, 'PayPal', 'pending'),
(14, 2, 1, 999.99, 'Credit Card', 'completed'),
(6, 11, 1, 699.99, 'Bank Transfer', 'shipped'),
(4, 13, 2, 159.98, 'PayPal', 'completed'),
(16, 20, 1, 699.99, 'Credit Card', 'completed'),
(7, 8, 1, 89.99, 'Debit Card', 'pending'),
(11, 19, 3, 539.97, 'Credit Card', 'completed'),
(20, 14, 1, 149.99, 'PayPal', 'shipped'),
(13, 10, 1, 599.99, 'Credit Card', 'completed'),
(19, 17, 2, 179.98, 'Bank Transfer', 'pending'),
(8, 2, 1, 999.99, 'Credit Card', 'completed'),
(5, 15, 1, 129.99, 'Debit Card', 'shipped'),
(12, 7, 2, 699.98, 'PayPal', 'completed'),
(3, 1, 1, 799.99, 'Credit Card', 'pending'),
(17, 9, 1, 199.99, 'Bank Transfer', 'completed'),
(2, 5, 1, 189.99, 'Credit Card', 'completed'),
(10, 18, 3, 1499.97, 'Debit Card', 'canceled'),
(15, 4, 2, 119.98, 'PayPal', 'completed'),
(1, 12, 1, 549.99, 'Credit Card', 'shipped');
