CREATE DATABASE BIBLIOTECA;
GO

USE BIBLIOTECA;
GO

-- tablas principales

CREATE TABLE Autor
(
codigo int IDENTITY(1,1) NOT NULL,
nombres varchar(50) NOT NULL,
email varchar(60) NULL,
);

alter table Autor add constraint PK_AUTOR
primary key (codigo);

INSERT INTO Autor (nombres, email) VALUES
('Maribel Sabana Mendoza','mary_123@gmail.com'),
('Orlando Toribio Fuentes',NULL),
('Rosa Toro Campos','tora@gmail.com'),
('Alfredo Santiago Santiago','santi_314@spee.com'),
('César Cueto Barreto','barreto@gmail.com'),
('Joaquin Espinoza Ortega',NULL),
('Andrés Benavides Lara',NULL),
('Clara Ponce León','clara_ponce@gmail.com'),
('Valeria Camacho Gutierrez',NULL),
('Esteban Loayza Pérez',NULL),
('Antonio Bayer Flores','anto_77@grupoarg.com'),
('Diana Mejía Gómez',NULL),
('Ignacio Ramirez Prieto',NULL);

CREATE TABLE Editorial
(
codigo int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL,
direccion varchar(100) NULL,
telefono varchar(20) NULL
);

alter table Editorial add constraint PK_EDITORIAL
primary key (codigo);

INSERT INTO Editorial (nombre, direccion, telefono) VALUES
('NAVARRETE','Av. Nicolas Piérola 351 SanLuis','5213696'),
('NORMA','Calle Los Pinos 841 Santa Beatriz','3581299'),
('SANTILLANA','Av. Juan Suarez 101 Lima','2315184 - 5329566');

CREATE TABLE EspecialidadLibro
(
codigo int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL
);

alter table EspecialidadLibro add constraint PK_ESPECIALIDADLIBRO
primary key (codigo);

INSERT INTO EspecialidadLibro (nombre) VALUES
('MATEMÁTICA'),
('COMPUTACIÓN'),
('INGLÉS'),
('LENGUA'),
('LITERATURA'),
('RELIGIÓN');

CREATE TABLE EstadoCarnet
(
codigo int IDENTITY(1,1) NOT NULL,
estado char(1) NOT NULL,
denominacion varchar(30) NOT NULL
);

alter table EstadoCarnet add constraint PK_ESTADOCARNET
primary key (codigo);

INSERT INTO EstadoCarnet (estado, denominacion) VALUES
('H','Habilitado'),
('R','Retenido'),
('S','Suspendido');

CREATE TABLE EstadoLibro
(
codigo int IDENTITY(1,1) NOT NULL,
estado char(1) NOT NULL,
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
apellidos varchar(40) NOT NULL,
telefono varchar(11) NULL
);

alter table Lector add constraint PK_LECTOR
primary key (codigo);

INSERT INTO Lector (nombres, apellidos) VALUES
('Veruska','Berrocal'),
('Gabriel','Sotomayor'),
('Walter','Acosta'),
('Erick','Cayllahua');

-- fin

-- tablas relacionadas

CREATE TABLE Carnet
(
codigo int identity(1,1) NOT NULL,
codigo_carnet varchar(10) NOT NULL,
estado_carnet_codigo int NOT NULL,
lector_codigo int NOT NULL,
observacion varchar(100) NULL
);

alter table Carnet add constraint PK_CARNETBIBLIOTECA
primary key (codigo);

alter table Carnet add constraint FK_ESTADOCARNET
foreign key (estado_carnet_codigo) references EstadoCarnet;

alter table Carnet add constraint FK_LECTOR_CARNETBIBLIOTECA
foreign key (lector_codigo) references Lector;

INSERT INTO Carnet (codigo_carnet, estado_carnet_codigo, lector_codigo, observacion) VALUES
('20140011',1,1, null),
('20140511',1,2, null),
('20140711',1,3, null),
('20149811',1,4, null);

CREATE TABLE Libro
(
codigo int identity(1,1) NOT NULL,
titulo varchar(50) NOT NULL,
registro date NULL,
cantidad_paginas int NULL,
editorial_codigo int NOT NULL,
especialidad_libro_codigo int NOT NULL,
estado_libro_codigo int NOT NULL
);

alter table Libro add constraint PK_LIBRO
primary key (codigo);

alter table Libro add constraint FK_EDITORIAL
foreign key (editorial_codigo) references Editorial;

alter table Libro add constraint FK_ESPECIALIDADLIBRO
foreign key (especialidad_libro_codigo) references EspecialidadLibro;

alter table Libro add constraint FK_ESTADOLIBRO
foreign key (estado_libro_codigo) references EstadoLibro;

INSERT INTO Libro (titulo, registro, cantidad_paginas, editorial_codigo, especialidad_libro_codigo,
 estado_libro_codigo) VALUES
('Matemática Primer Grado','2014-01-01',88,3,1,1),
('Aprendiendo Inglés','2014-01-02',75,2,3,1),
('La vida de Jesús','2014-01-04',50,1,6,1),
('Funciones lineales','2014-01-01',53,3,1,1),
('Mantenimiento de PC','2014-01-01',84,2,2,1),
('CONAMAT V','2014-01-01',48,3,1,1),
('¿Quién se ha llevado mi queso?','2014-01-01',45,1,5,1),
('La computadora y sus partes','2014-01-01',55,1,2,1),
('Oraciones al señor','2014-01-01',51,1,6,1),
('CONAMAT IV','2014-01-01',45,3,1,1),
('EL DELFIN','2014-01-01',34,2,2,1),
('DESARROLLO WEB','2014-01-01',67,1,1,1),
('EPE','2014-01-01',35,1,2,1),
('DESARROLLO MOVIL','2014-01-01',34,2,2,1),
('REPARACION DE PC','2014-01-01',265,1,2,1),
('Casos de la vida','2014-01-01',123,1,1,1);

CREATE TABLE LibroAutor
(
codigo int identity(1,1) NOT NULL,
autor_codigo int NOT NULL,
libro_codigo int NOT NULL
);

alter table LibroAutor add constraint PK_LIBROAUTOR
primary key (codigo);

alter table LibroAutor add constraint FK_AUTOR
foreign key (autor_codigo) references Autor;

alter table LibroAutor add constraint FK_LIBRO_LIBROAUTOR
foreign key (libro_codigo) references Libro;

INSERT INTO LibroAutor (autor_codigo, libro_codigo) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

CREATE TABLE TipoUsuario
(
codigo int IDENTITY(1,1) NOT NULL,
descripcion varchar(50) NOT NULL
)

alter table TipoUsuario add constraint PK_TIPOUSUARIO
primary key (codigo);

INSERT INTO TipoUsuario
(descripcion)
VALUES
('ADMINISTRADOR'),
('ESTUDIANTE');

CREATE TABLE Usuario
(
codigo int IDENTITY(1,1) NOT NULL,
usuario varchar(45) NOT NULL,
clave varchar(45) NOT NULL,
nombre_completo varchar(100) NULL,
lector_codigo int NULL,
tipo_usuario_codigo int NULL
);

alter table Usuario add constraint PK_USUARIO
primary key (codigo);

alter table Usuario add constraint FK_LECTOR_USUARIO
foreign key (lector_codigo) references Lector;

alter table Usuario add constraint FK_TIPO_USUARIO
foreign key (tipo_usuario_codigo) references TipoUsuario;

INSERT INTO Usuario (usuario, clave, nombre_completo, lector_codigo, tipo_usuario_codigo) VALUES
('vberrocal','111','',1,2),
('gsotomayor','222','',2,2),
('wacosta','333','',3,2),
('ecayllahua','444','',4,2);

-- tiene campos de auditoria
CREATE TABLE Prestamo
(
codigo int IDENTITY(1,1) NOT NULL,
usuario_codigo int NOT NULL,
libro_codigo int NOT NULL,
fecha_prestamo date NOT NULL,
fecha_devolucion date NOT NULL,
devuelto bit NOT NULL,
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

INSERT INTO Prestamo (usuario_codigo, libro_codigo, fecha_prestamo, fecha_devolucion,
devuelto, observacion, usuario_creacion_codigo, fecha_creacion, 
usuario_ultima_actualizacion_codigo, fecha_ultima_actualizacion) VALUES
(1,3,'2014-01-01','2014-01-05',1,'OBSERVACION',1,'2014-01-01',1,'2014-01-05'),
(2,3,'2014-01-01','2014-01-04',1,'OBSERVACION',1,'2014-01-01',1,'2014-01-04'),
(3,3,'2014-01-01','2014-01-05',1,'OBSERVACION',1,'2014-01-01',1,'2014-01-05'),
(4,3,'2014-01-01','2014-01-03',1,'OBSERVACION',1,'2014-01-01',1,'2014-01-03');
