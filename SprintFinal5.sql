-- crear usuario con todos los privilegios

CREATE USER Administrador IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON sprint5.* TO Administrador;
FLUSH PRIVILEGES;


-- crear tabla para usuarios con id, nombre, apellido, edad, correo electrónico y cantidad de usos (de aplicación

CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  apellido VARCHAR(30),
  edad INT,
  correo_electronico VARCHAR(100),
  cantidad_uso INT DEFAULT 1
);

-- insertar 5 usuarios en tabla usuarios


INSERT INTO usuarios (nombre, apellido, edad, correo_electronico)
VALUES
  ('Usuario1', 'Apellido1', 25, 'usuario1@correo.com'),
  ('Usuario2', 'Apellido2', 30, 'usuario2@correo.com'),
  ('Usuario3', 'Apellido3', 28, 'usuario3@correo.com'),
  ('Usuario4', 'Apellido4', 35, 'usuario4@correo.com'),
  ('Usuario5', 'Apellido5', 22, 'usuario5@correo.com');
  

  -- crear tabla operadores
  
CREATE TABLE operadores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  calificacion INT,
  correo_electronico VARCHAR(100),
  veces_servicio INT DEFAULT 1
);

-- crea tabla calificaciones para ''guardar'' la calificacion que entrega el usuario al operador

CREATE TABLE calificaciones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT,
  id_operario INT,
  calificacion INT,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  FOREIGN KEY (id_operario) REFERENCES operadores(id)
);



-- crear 5 operadores

INSERT INTO operadores (nombre, apellido, edad, correo_electronico)
VALUES
  ('Operador1', 'Apellido1', 30, 'operador1@correo.com'),
  ('Operador2', 'Apellido2', 32, 'operador2@correo.com'),
  ('Operador3', 'Apellido3', 27, 'operador3@correo.com'),
  ('Operador4', 'Apellido4', 29, 'operador4@correo.com'),
  ('Operador5', 'Apellido5', 31, 'operador5@correo.com');
  

-- crear tabla operadores de soporte

CREATE TABLE operadores_soporte (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  correo_electronico VARCHAR(100),
  veces_servicio INT DEFAULT 1
);


-- crear 10 operadores de soporte

INSERT INTO operadores_soporte (nombre, apellido, edad, correo_electronico)
VALUES
  ('Soporte1', 'Apellido1', 30, 'soporte1@correo.com'),
  ('Soporte2', 'Apellido2', 32, 'soporte2@correo.com'),
  ('Soporte3', 'Apellido3', 27, 'soporte3@correo.com'),
  ('Soporte4', 'Apellido4', 29, 'soporte4@correo.com'),
  ('Soporte5', 'Apellido5', 31, 'soporte5@correo.com'),
  ('Soporte6', 'Apellido6', 28, 'soporte6@correo.com'),
  ('Soporte7', 'Apellido7', 33, 'soporte7@correo.com'),
  ('Soporte8', 'Apellido8', 26, 'soporte8@correo.com'),
  ('Soporte9', 'Apellido9', 34, 'soporte9@correo.com'),
  ('Soporte10', 'Apellido10', 25, 'soporte10@correo.com');


-- renombrar columnas correo electronico a email

ALTER TABLE usuarios
CHANGE COLUMN correo_electronico email VARCHAR(100);

ALTER TABLE operadores
CHANGE COLUMN correo_electronico email VARCHAR(100);

ALTER TABLE operadores_soporte
CHANGE COLUMN correo_electronico email VARCHAR(100);


-- seleccionar todos los peradores de la tabla operadores mayores de 20 años

SELECT * FROM operadores WHERE edad > 20;


-- agregar 10 años a los 3 primeros usuarios registrados

UPDATE usuarios
SET edad = edad + 10
ORDER BY id ASC
LIMIT 3;

-- seleccionar al usuario que menos veces ha utilizado la aplicación

SELECT * FROM usuarios
ORDER BY cantidad_uso ASC
LIMIT 1;


-- seleccionar al operador que mas servicios ha entregado

SELECT * FROM operadores
ORDER BY veces_servicio DESC
LIMIT 1;

-- seleccionar las 3 operaciones con mejor evaluación

SELECT * FROM calificaciones
ORDER BY calificacion DESC
LIMIT 3;


-- seleccionar las 3 operaciones con menor evaluación

SELECT * FROM calificaciones
ORDER BY calificacion ASC
LIMIT 3;

-- seleccionar un usuario de forma aleatoria
SELECT id AS id_usuario FROM usuarios ORDER BY RAND() LIMIT 1;

-- seleccionar un operador de forma aleatoria
SELECT id AS id_operador FROM operadores ORDER BY RAND() LIMIT 1;


-- dejar calificación aleatoria a un operador

INSERT INTO calificaciones (id_usuario, id_operario, calificacion)
VALUES ((SELECT id AS id_usuario FROM usuarios ORDER BY RAND() LIMIT 1),
        (SELECT id AS id_operador FROM operadores ORDER BY RAND() LIMIT 1),
        FLOOR(RAND() * 7) + 1);
        
        