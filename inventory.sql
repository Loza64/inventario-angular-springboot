use inventory;

create table user(
    id bigint primary key auto_increment,
    dui varchar(10) unique not null ,
    username varchar(16) unique not null,
    name varchar(100) not null,
    surname varchar(100) not null,
    email varchar(200) not null,
    phone int unique not null,
    password varchar(200) not null,
    role ENUM('ADMIN', 'NORMAL', 'PROVIDER') null default 'NORMAL',
    state boolean null default true
);

create table user_photo (
    id bigint primary key auto_increment,
    id_user bigint not null,
    public_id varchar(100) not null,
    url varchar(300) not null,
    constraint FK_USER_PHOTO foreign key (id_user) references user(id) on delete cascade on update cascade
);

create table people(
    id bigint primary key auto_increment,
    name varchar(100) not null,
    surname varchar(100) not null,
    email varchar(200) not null,
    phone int unique not null,
    address varchar(340) not null,
    type ENUM('CLIENT', 'PROVIDER') null default 'CLIENT', -- Client or Provider
    created datetime null default CURRENT_TIMESTAMP
);

create table category(
    id bigint primary key auto_increment,
    name varchar(100) unique not null
);

create table product(
    id bigint primary key auto_increment,
    name varchar(100) unique not null,
    description varchar(900) not null,
    stock int not null,
    price_in double not null,
    price_out double not null,
    id_user bigint null,
    id_category bigint null,
    discount double null default 0.0,
    created datetime null default CURRENT_TIMESTAMP,
    constraint FK_PRODUCT_CATEGORY foreign key (id_category) references category(id) on delete set null on update cascade ,
    constraint FK_PRODUCT_USER foreign key (id_user) references user(id) on delete set null on update cascade
);

create table product_photo(
    id bigint primary key auto_increment,
    id_product bigint not null,
    public_id varchar(100) not null,
    url varchar(300) not null,
    constraint FK_PRODUCT_PHOTO foreign key (id_product) references product(id) on delete cascade on update cascade
);

create table type(
    id bigint primary key auto_increment,
    type ENUM('entrance', 'exit') not null -- Entrada o Salida
);

create table operation(
    id bigint primary key auto_increment,
    id_user bigint null,
    id_people bigint null,
    id_type bigint not null,
    total double not null,
    cash double not null,
    discount double null default 0.0,
    created datetime null default CURRENT_TIMESTAMP,
    CONSTRAINT FK_OPERATION_TYPE foreign key (id_type) references type(id) on update cascade ,
    CONSTRAINT FK_OPERATION_USER foreign key (id_user) references user(id) on delete set null on update cascade ,
    CONSTRAINT FK_OPERATION_PEOPLE foreign key (id_people) references  people(id) on delete set null on update cascade
);

create table details(
    id bigint primary key auto_increment,
    id_operation bigint not null,
    id_product bigint null,
    cant int not null,
    id_type bigint not null,
    created datetime null default CURRENT_TIMESTAMP,
    CONSTRAINT FK_DETAILS_TYPE foreign key (id_type) references  type(id) on update cascade ,
    CONSTRAINT FK_DETAILS_PRODUCT foreign key (id_product) references  product(id) on delete set null on update cascade ,
    CONSTRAINT FK_DETAILS_OPERATION foreign key (id_operation) references operation(id) on update cascade
);

INSERT INTO user (id, dui, username, name, surname, email, phone, password, role, state) VALUES
(1, '12345678-9', 'RockStartX64', 'Roberto', 'Loza', 'robertoloxa88@gmail.com', 61157626, '$2a$10$KSKCTC8vLODLbVaTpBXjx.yCyagJU26.gZLAlKrwMjQJU5xJi32lK', 'ADMIN', 1), /* qwert */
(2, '12344678-9', 'juan.perez', 'Juan', 'Pérez', 'juan.perez@example.com', 5551234, '$2a$10$2aI2PlQAcPAjK7QGZsZ8buSZ2x2HofdhsjRUVnwfAqMRssFViAMEW', 'NORMAL', 1), /* password1 */
(3, '98765432-1', 'maria.gomez', 'María', 'Gómez', 'maria.gomez@example.com', 5555678, '$2a$10$Gz/8r4OyUNwhjRAoEP4ET.1BtZiQ8f/uexXDfQivTRpGYDoyx8QZi', 'NORMAL', 1), /* password2 */
(4, '23456789-0', 'carlos.lopez', 'Carlos', 'Lopez', 'carlos.lopez@example.com', 5558765, '$2a$10$nlYT6eD3xeebDWhn0hd1YudtsEeyxOUQx5bwnwmv265ZA2roc.0N.', 'NORMAL', 1), /* password3 */
(5, '34567890-1', 'ana.martinez', 'Ana', 'Martínez', 'ana.martinez@example.com', 5552345, '$2a$10$YQJtMSloie1CZQ0LcIJpS.1nOGN1oRnWjzKCBer/oi2PDn83IZ8c6', 'NORMAL', 1), /* password4 */
(6, '45678901-2', 'luis.fernandez', 'Luis', 'Fernández', 'luis.fernandez@example.com', 5554321, '$2a$10$YKrWc0N5ISQH1ZVj0fa/CezZSlSRZylpzo5ZbxXfFIrDux6V7cw3e', 'PROVIDER', 1), /* password5 */
(7, '56789012-3', 'sofia.ramirez', 'Sofía', 'Ramírez', 'sofia.ramirez@example.com', 5553456, '$2a$10$FvfjR2pjE64f/caquOzCk.uWDFGF/AdXMEuHEWIoVzuIwCyoO68b2', 'NORMAL', 1), /* password6 */
(8, '67890123-4', 'javier.cruz', 'Javier', 'Cruz', 'javier.cruz@example.com', 5556543, '$2a$10$iv6vRKAPLzuxKHPdX0RH1edMpAs9tH2imfUGKcudme1g0Vguo1Rou', 'PROVIDER', 1), /* password7 */
(9, '78901234-5', 'laura.torres', 'Laura', 'Torres', 'laura.torres@example.com', 5557890, '$2a$10$utdslpoBBRDseUpYKNVvPe34aL4vY3sAsACiw762hi170RMHvIhP6', 'NORMAL', 1), /* password8 */
(10, '89012345-6', 'diego.jimenez', 'Diego', 'Jiménez', 'diego.jimenez@example.com', 5551111, '$2a$10$OhGwiUtige/Nw3nsbt56KeaB5lL7DKqWD.1B6tZAucXpeRrwuDTN2', 'NORMAL', 1), /* password9 */
(11, '90123456-7', 'veronica.vazquez', 'Verónica', 'Vázquez', 'veronica.vazquez@example.com', 5552222, '$2a$10$7Lc/9woSAbByh4hlHoRbduS/18mSXVRL6lnVlMAO321hTV..9j04y', 'PROVIDER', 1), /* password10 */
(12, '11234567-8', 'admin.usuario', 'admin', 'Usuario', 'admin.usuario@example.com', 5550000, '$2a$10$qrYQMEvvnMYm2A0EPIfn4.jR/TUoMggOb52pioNo5rr.ztd1XjNwS', 'ADMIN', 1), /* admin123 */
(13, '11234567-9', 'fernando.mora', 'Fernando', 'Mora', 'fernando.mora@example.com', 5553333, '$2a$10$zn11D3.GFfGQkdWWHzpB6.piUXo4gk2EH29laBgor66uRMI/nwI.e', 'NORMAL', 1), /* password11 */
(14, '12345678-0', 'patricia.soto', 'Patricia', 'Soto', 'patricia.soto@example.com', 5554444, '$2a$10$0Dx3b2zmuLxMaDRcymGV9umRuNrkUMAio.ycG0IuDo.FGS.j0JLX6', 'NORMAL', 1), /* password12 */
(15, '23456789-1', 'jose.phillips', 'José', 'Phillips', 'jose.phillips@example.com', 5555555, '$2a$10$OIDfRPTB4hITxV.zMPDn4.NZxg2DvQxmfbeUdyFu2bIwVuGbQ6v2O', 'PROVIDER', 1), /* password13 */
(16, '34567890-2', 'mariana.ortega', 'Mariana', 'Ortega', 'mariana.ortega@example.com', 5556666, '$2a$10$MYCiISY2IWfmE/evTEu71.14wRmMBMZhp0Temvf/vuuD1TmWe5Qzq', 'NORMAL', 1), /* password14 */
(17, '45678901-3', 'rafael.baeza', 'Rafael', 'Baeza', 'rafael.baeza@example.com', 5557777, '$2a$10$/x8iXCdNJSAcqbMKrS.FR.nRKgHfj9fJBl7xQX1BorKUnbeKDjZJ2', 'PROVIDER', 1), /* password15 */
(18, '56789012-4', 'lucia.melendez', 'Lucía', 'Meléndez', 'lucia.melendez@example.com', 5558888, '$2a$10$yzSf0IG0g88eUyvHd1whUeMaP5lAx6Q5i99joucHqDhjw68vk89Yu', 'NORMAL', 1), /* password16 */
(19, '67890123-5', 'antonio.pineda', 'Antonio', 'Pineda', 'antonio.pineda@example.com', 5559999, '$2a$10$h0BYCUWZ.UFE2I9bNCuXD.3f8m6EMaHiuf8dSyxI4Geabs9/hOhjq', 'ADMIN', 1), /* password17 */
(20, '71901234-6', 'isabel.acosta', 'Isabel', 'Acosta', 'isabel.acosta@example.com', 5560000, '$2a$10$YM4gSygM2rBe76W4njng1eF8VjGgEUGmmw5RDuTJnRknML5LytIba', 'NORMAL', 1); /* password18 */

insert into type(type) values ('entrance'), ('exit');

INSERT INTO category(name) VALUES
('Electrónica'),('Ropa'),('Hogar y Jardín'),
('Belleza y Cuidado Personal'),('Deportes'),
('Alimentos y Bebidas'),('Juguetes'),('Libros'),
('Automotriz'),('Salud'),('Muebles'),('Tecnología'),
('Accesorios de Moda'),('Videojuegos'),('Productos para Mascotas'),
('Artículos de Oficina'),('Cuidado del Hogar'),('Fitness y Ejercicio'),
('Joyas y Relojes'),('Cursos y Educación'),('Viajes y Aventura');

INSERT INTO product (name, description, stock, price_in, price_out, id_user, id_category, discount, created)
VALUES
-- Accesorios de Moda
('Collar Elegante', 'Collar de oro con diamantes.', 10, 50.00, 75.00, 1, 13, 0.10, '2024-01-01 10:00:00'),
('Pulsera Moderna', 'Pulsera de plata moderna.', 15, 30.00, 45.00, 2, 13, 0.15, '2024-01-01 11:00:00'),
('Anillo de Compromiso', 'Anillo de compromiso con diamantes.', 5, 200.00, 300.00, 3, 13, 0.20, '2024-01-01 12:00:00'),
('Aretes de Perla', 'Aretes con perlas naturales.', 8, 40.00, 60.00, 4, 13, 0.10, '2024-01-01 13:00:00'),
('Reloj de Pulsera', 'Reloj de pulsera de acero inoxidable.', 12, 80.00, 120.00, 5, 13, 0.05, '2024-01-01 14:00:00'),
('Gafas de Sol', 'Gafas de sol polarizadas.', 20, 25.00, 35.00, 6, 13, 0.10, '2024-01-01 15:00:00'),
('Bufanda de Seda', 'Bufanda de seda suave.', 25, 20.00, 30.00, 7, 13, 0.10, '2024-01-01 16:00:00'),
('Sombrero de Paja', 'Sombrero de paja para el verano.', 30, 15.00, 25.00, 8, 13, 0.20, '2024-01-01 17:00:00'),

-- Alimentos y Bebidas
('Chocolate Negro', 'Chocolate negro de alta calidad.', 50, 2.00, 3.00, 1, 6, 0.10, '2024-01-02 10:00:00'),
('Café Colombiano', 'Café colombiano orgánico.', 60, 5.00, 8.00, 2, 6, 0.15, '2024-01-02 11:00:00'),
('Té Verde', 'Té verde japonés.', 40, 3.00, 5.00, 3, 6, 0.20, '2024-01-02 12:00:00'),
('Vino Tinto', 'Vino tinto español.', 30, 10.00, 15.00, 4, 6, 0.10, '2024-01-02 13:00:00'),
('Queso Manchego', 'Queso manchego curado.', 25, 12.00, 18.00, 5, 6, 0.05, '2024-01-02 14:00:00'),
('Aceite de Oliva', 'Aceite de oliva extra virgen.', 40, 7.00, 10.00, 6, 6, 0.10, '2024-01-02 15:00:00'),
('Mermelada de Fresa', 'Mermelada de fresa casera.', 35, 4.00, 6.00, 7, 6, 0.10, '2024-01-02 16:00:00'),
('Pan Integral', 'Pan integral hecho a mano.', 45, 3.00, 5.00, 8, 6, 0.20, '2024-01-02 17:00:00'),

-- Artículos de Oficina
('Cuaderno A5', 'Cuaderno de notas tamaño A5.', 80, 1.50, 2.50, 1, 16, 0.10, '2024-01-03 10:00:00'),
('Bolígrafo de Gel', 'Bolígrafo de gel de colores.', 100, 0.50, 1.00, 2, 16, 0.15, '2024-01-03 11:00:00'),
('Carpeta Archivadora', 'Carpeta para archivar documentos.', 70, 2.00, 3.50, 3, 16, 0.20, '2024-01-03 12:00:00'),
('Silla de Oficina', 'Silla ergonómica de oficina.', 15, 50.00, 75.00, 4, 16, 0.10, '2024-01-03 13:00:00'),
('Impresora Láser', 'Impresora láser multifunción.', 20, 100.00, 150.00, 5, 16, 0.05, '2024-01-03 14:00:00'),
('Grapadora Metálica', 'Grapadora de metal resistente.', 90, 3.00, 5.00, 6, 16, 0.10, '2024-01-03 15:00:00'),
('Bloc de Notas', 'Bloc de notas adhesivas.', 120, 0.80, 1.50, 7, 16, 0.10, '2024-01-03 16:00:00'),
('Tijeras de Oficina', 'Tijeras de oficina de acero.', 60, 2.50, 4.00, 8, 16, 0.20, '2024-01-03 17:00:00'),

-- Automotriz
('Llantas Todo Terreno', 'Llantas para todo terreno.', 20, 75.00, 100.00, 1, 9, 0.10, '2024-01-04 10:00:00'),
('Aceite de Motor', 'Aceite de motor sintético.', 50, 20.00, 30.00, 2, 9, 0.15, '2024-01-04 11:00:00'),
('Filtro de Aire', 'Filtro de aire de alta calidad.', 40, 15.00, 25.00, 3, 9, 0.20, '2024-01-04 12:00:00'),
('Batería de Auto', 'Batería de auto de larga duración.', 15, 80.00, 120.00, 4, 9, 0.10, '2024-01-04 13:00:00'),
('Cera para Auto', 'Cera para pulir autos.', 30, 10.00, 15.00, 5, 9, 0.05, '2024-01-04 14:00:00'),
('Kit de Herramientas', 'Kit de herramientas básico para autos.', 25, 30.00, 45.00, 6, 9, 0.10, '2024-01-04 15:00:00'),
('Limpiaparabrisas', 'Juego de limpiaparabrisas.', 60, 12.00, 20.00, 7, 9, 0.10, '2024-01-04 16:00:00'),
('Tapetes para Auto', 'Tapetes de goma para auto.', 40, 25.00, 35.00, 8, 9, 0.20, '2024-01-04 17:00:00'),

-- Belleza y Cuidado Personal
('Shampoo Orgánico', 'Shampoo orgánico sin sulfatos.', 50, 8.00, 12.00, 1, 4, 0.10, '2024-01-05 10:00:00'),
('Acondicionador Nutritivo', 'Acondicionador con nutrientes.', 45, 7.00, 11.00, 2, 4, 0.15, '2024-01-05 11:00:00'),
('Crema Hidratante', 'Crema hidratante para la piel.', 40, 12.00, 18.00, 3, 4, 0.20, '2024-01-05 12:00:00'),
('Perfume Floral', 'Perfume con aroma floral.', 35, 50.00, 75.00, 4, 4, 0.10, '2024-01-05 13:00:00'),
('Maquillaje Mineral', 'Maquillaje mineral natural.', 60, 20.00, 30.00, 5, 4, 0.05, '2024-01-05 14:00');


