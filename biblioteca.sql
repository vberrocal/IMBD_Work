CREATE DATABASE BIBLIOTECA;
GO

USE BIBLIOTECA;
GO

-- tablas principales

CREATE TABLE Autor
(
codigo int NOT NULL,
nombres varchar(50) NOT NULL,
email varchar(60) NULL,
);

alter table Autor add constraint PK_AUTOR
primary key (codigo);

INSERT INTO Autor VALUES
(1,'Maribel Sabana Mendoza','mary_123@gmail.com'),
(2,'Orlando Toribio Fuentes',NULL),
(3,'Rosa Toro Campos','tora@gmail.com'),
(4,'Alfredo Santiago Santiago','santi_314@spee.com'),
(5,'César Cueto Barreto','barreto@gmail.com'),
(6,'Joaquin Espinoza Ortega',NULL),
(7,'Andrés Benavides Lara',NULL),
(8,'Clara Ponce León','clara_ponce@gmail.com'),
(9,'Valeria Camacho Gutierrez',NULL),
(10,'Esteban Loayza Pérez',NULL),
(11,'Antonio Bayer Flores','anto_77@grupoarg.com'),
(12,'Diana Mejía Gómez',NULL),
(13,'Ignacio Ramirez Prieto',NULL);

CREATE TABLE Editorial
(
codigo int NOT NULL,
nombre varchar(50) NOT NULL,
direccion varchar(100) NULL,
telefono varchar(20) NULL
);

alter table Editorial add constraint PK_EDITORIAL
primary key (codigo);

INSERT INTO Editorial VALUES
(1,'NAVARRETE','Av. Nicolas Piérola 351 SanLuis','5213696'),
(2,'NORMA','Calle Los Pinos 841 Santa Beatriz','3581299'),
(3,'SANTILLANA','Av. Juan Suarez 101 Lima','2315184 - 5329566');

CREATE TABLE EspecialidadLibro
(
codigo int NOT NULL,
nombre varchar(50) NOT NULL
);

alter table EspecialidadLibro add constraint PK_ESPECIALIDADLIBRO
primary key (codigo);

INSERT INTO EspecialidadLibro VALUES
(1,'MATEMÁTICA'),
(2,'COMPUTACIÓN'),
(3,'INGLÉS'),
(4,'LENGUA'),
(5,'LITERATURA'),
(6,'RELIGIÓN');

CREATE TABLE EstadoCarnet
(
codigo char(1) NOT NULL,
denominacion varchar(30) NOT NULL
);

alter table EstadoCarnet add constraint PK_ESTADOCARNET
primary key (codigo);

INSERT INTO EstadoCarnet VALUES
('H','Habilitado'),
('R','Retenido'),
('S','Suspendido');

CREATE TABLE EstadoLibro
(
codigo char(1) NOT NULL,
denominacion varchar(30) NOT NULL
);

alter table EstadoLibro add constraint PK_ESTADOLIBRO
primary key (codigo);

INSERT INTO EstadoLibro VALUES
('D','Disponible'),
('F','Fuera de Servicio'),
('P','Prestado');

CREATE TABLE Lector
(
codigo int NOT NULL identity(1,1),
nombres varchar(40) NOT NULL,
apellidos varchar(40) NOT NULL
);

alter table Lector add constraint PK_LECTOR
primary key (codigo);

INSERT INTO Lector VALUES
('Veruska','Berrocal'),
('Gabriel','Sotomayor'),
('Walter','Acosta'),
('Erick','Cayllahua');

-- fin

-- tablas relacionadas

CREATE TABLE Carnet
(
codigo int NOT NULL,
observacion varchar(100) NULL,
carnet_codigo char(1) NOT NULL,
lector_codigo int NOT NULL
);

alter table Carnet add constraint PK_CARNETBIBLIOTECA
primary key (codigo);

alter table Carnet add constraint FK_ESTADOCARNET
foreign key (carnet_codigo) references EstadoCarnet;

alter table Carnet add constraint FK_LECTOR_CARNETBIBLIOTECA
foreign key (lector_codigo) references Lector;

INSERT INTO Carnet VALUES
(1,'- -','H',1),
(2,'-','H',2),
(3,'-','H',3),
(4,'-','H',4);

CREATE TABLE Libro
(
codigo int NOT NULL,
titulo varchar(50) NOT NULL,
registro varchar(20) NULL,
cantidad_paginas int NULL,
editorial_codigo int NOT NULL,
especialidad_libro_codigo int NOT NULL,
estado_libro_codigo char(1) NOT NULL
);

alter table Libro add constraint PK_LIBRO
primary key (codigo);

alter table Libro add constraint FK_EDITORIAL
foreign key (editorial_codigo) references Editorial;

alter table Libro add constraint FK_ESPECIALIDADLIBRO
foreign key (especialidad_libro_codigo) references EspecialidadLibro;

alter table Libro add constraint FK_ESTADOLIBRO
foreign key (estado_libro_codigo) references EstadoLibro;

INSERT INTO Libro VALUES
(1,'Matemática Primer Grado','25-25-9541',88,3,1,'D'),
(2,'Aprendiendo Inglés','321-4522-1',75,2,3,'D'),
(3,'La vida de Jesús','101-85-999',50,1,6,'D'),
(4,'Funciones lineales','1-89-444-2',53,3,1,'D'),
(5,'Mantenimiento de PC','35-99-8941',84,2,2,'D'),
(6,'CONAMAT V','4-44-89511',48,3,1,'D'),
(7,'¿Quién se ha llevado mi queso?','22-96-556-1',45,1,5,'D'),
(8,'La computadora y sus partes','11-84-5-55',55,1,2,'D'),
(9,'Oraciones al señor','211-359-5',51,1,6,'D'),
(10,'CONAMAT IV','11-25-5589',45,3,1,'D'),
(45,'EL DELFIN','23421',34,2,2,'D'),
(111,'DESARROLLO WEB','54209',67,1,1,'D'),
(123,'EPE','9123',35,1,2,'D'),
(234,'DESARROLLO MOVIL','6757',34,2,2,'D'),
(444,'REPARACION DE PC','63000',265,1,2,'D'),
(2013008743,'Casos de la vida',NULL,123,1,1,'D');

CREATE TABLE LibroAutor
(
codigo int NOT NULL,
autor_codigo int NOT NULL,
libro_codigo int NOT NULL
);

alter table LibroAutor add constraint PK_LIBROAUTOR
primary key (codigo);

alter table LibroAutor add constraint FK_AUTOR
foreign key (autor_codigo) references Autor;

alter table LibroAutor add constraint FK_LIBRO_LIBROAUTOR
foreign key (libro_codigo) references Libro;

INSERT INTO LibroAutor VALUES
(1,1,1),
(2,2,2),
(3,4,4),
(4,5,1),
(5,6,4),
(6,5,234),
(7,8,10),
(8,11,10),
(9,4,123),
(10,12,9);

CREATE TABLE TipoUsuario
(
codigo int IDENTITY(1,1) NOT NULL,
descripcion varchar(50) NO NULL
)

alter table TipoUsuario add constraint PK_TIPOUSUARIO
primary key (codigo);

INSERT INTO TipoUsuario 
(descripcion)
VALUES
('administrador'),
('estudiante');

CREATE TABLE Usuario
(
codigo int NOT NULL,
usuario varchar(45) NOT NULL,
clave varchar(45) NOT NULL,
nombre_completo varchar(100) NULL,
lector_codigo int NULL,
tipo_usuario_codigo varchar(1) NULL
);

alter table Usuario add constraint PK_USUARIO
primary key (codigo);

alter table Usuario add constraint FK_LECTOR_USUARIO
foreign key (lector_codigo) references Lector;

alter table Usuario add constraint FK_TIPO_USUARIO
foreign key (tipo_usuario_codigo) references TipoUsuario;

INSERT INTO Usuario VALUES
(1,'vberrocal','111','',1,'A'),
(2,'gsotomayor','222','',2,'U'),
(3,'wacosta','333','',3,'A'),
(4,'ecayllahua','444','',4,'U');

-- tiene campos de auditoria
CREATE TABLE Prestamo
(
codigo int NOT NULL,
usuario_codigo int NOT NULL,
libro_codigo int NOT NULL,
fecha_prestamo varchar(20) NOT NULL,
fecha_devolucion varchar(20) NOT NULL,
devuelto char(1) NOT NULL,
observacion varchar(100) NULL,
usuario_creacion_codigo int NOT NULL,
fecha_creacion datetime NOT NULL,
usuario_ultima_actualizacion_codigo int NOT NULL,
fecha_ultima_actualizacion datetime NOT NULL
);

alter table Prestamo add constraint PK_PRESTAMO
primary key (codigo);

alter table Prestamo add constraint FK_USUARIO
foreign key (usuario_codigo) references Usuario;

alter table Prestamo add constraint FK_LIBRO_PRESTAMO
foreign key (libro_codigo) references Libro;

INSERT INTO Prestamo VALUES
(1,3,4,'12/09/2014','13/09/2014','0','OBSERVACION'),
(2,3,444,'12/09/2014','03/10/2014','0','OBSERVACION'),
(3,3,444,'12/09/2014','03/10/2014','0','OBSERVACION'),
(4,3,444,'12/09/2014','13/09/2014','0','OBSERVACION'),
(5,3,444,'12/09/2014','13/09/2014','0','OBSERVACION');
