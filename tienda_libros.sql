CREATE DATABASE IF NOT EXISTS tienda_libros
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tienda_libros;

CREATE TABLE libro (
    isbn              VARCHAR(20)  NOT NULL,
    titulo            VARCHAR(150) NOT NULL,
    autor             VARCHAR(100) NOT NULL,
    fecha_publicacion DATE         NOT NULL,
    editorial         VARCHAR(100) NOT NULL,
    categoria         VARCHAR(50)  NOT NULL,
    precio            DECIMAL(8,2) NOT NULL,
    stock             INT          NOT NULL DEFAULT 0,
    CONSTRAINT pk_libro PRIMARY KEY (isbn)
);

CREATE TABLE cliente (
    id_cliente INT          NOT NULL AUTO_INCREMENT,
    nombre     VARCHAR(100) NOT NULL,
    correo     VARCHAR(100) NOT NULL,
    direccion  VARCHAR(150) NOT NULL,
    telefono   VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_correo  UNIQUE (correo)
);

CREATE TABLE venta (
    id_venta    INT          NOT NULL AUTO_INCREMENT,
    isbn        VARCHAR(20)  NOT NULL,
    id_cliente  INT          NOT NULL,
    metodo_pago VARCHAR(50)  NOT NULL,
    monto       DECIMAL(8,2) NOT NULL,
    fecha_venta DATE         NOT NULL,
    CONSTRAINT pk_venta         PRIMARY KEY (id_venta),
    CONSTRAINT fk_venta_libro   FOREIGN KEY (isbn)       REFERENCES libro(isbn),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

INSERT INTO libro VALUES
  ('978-3-16-148410-0','El Principito','Antoine de Saint-Exupéry','1943-04-06','Gallimard','Infantil',10.00,80),
  ('978-0-14-143960-0','Orgullo y Prejuicio','Jane Austen','1813-01-28','Penguin Classics','Romance',15.00,30),
  ('978-0-45-231317-0','1984','George Orwell','1949-06-08','Signet Classics','Ciencia Ficción',20.00,20);

INSERT INTO cliente (nombre,correo,direccion,telefono) VALUES
  ('Juan Pérez','juan.perez@email.com','Calle Falsa 123','3001234567'),
  ('María García','maria.garcia@email.com','Avenida Siempreviva 456','3109876543');

INSERT INTO venta (isbn,id_cliente,metodo_pago,monto,fecha_venta) VALUES
  ('978-3-16-148410-0',1,'Tarjeta Crédito',10.00,CURDATE()),
  ('978-0-14-143960-0',2,'PayPal',15.00,CURDATE()),
  ('978-0-45-231317-0',1,'Tarjeta Crédito',20.00,CURDATE());
