CREATE DATABASE Biblioteca;
GO

USE Biblioteca;
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

CREATE TABLE Editorial
(
codigo int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL,
direccion varchar(100) NULL,
telefono varchar(20) NULL
);

alter table Editorial add constraint PK_EDITORIAL
primary key (codigo);

CREATE TABLE GeneroLibro
(
codigo int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL
);

alter table GeneroLibro add constraint PK_ESPECIALIDADLIBRO
primary key (codigo);

CREATE TABLE Libro
(
codigo int identity(1,1) NOT NULL,
titulo varchar(50) NOT NULL,
registro date NULL,
cantidad_paginas int NULL,
editorial_codigo int NOT NULL,
genero_libro_codigo int NOT NULL
);

alter table Libro add constraint PK_LIBRO
primary key (codigo);

alter table Libro add constraint FK_EDITORIAL
foreign key (editorial_codigo) references Editorial;

alter table Libro add constraint FK_GENEROLIBRO
foreign key (genero_libro_codigo) references GeneroLibro;


CREATE TABLE LibroAutor
(
codigo int identity(1,1) NOT NULL,
autor_codigo int NOT NULL,
libro_codigo int NOT NULL
);

alter table LibroAutor add constraint PK_LIBRO_AUTOR
primary key (codigo);

alter table LibroAutor add constraint FK_AUTOR
foreign key (autor_codigo) references Autor;

alter table LibroAutor add constraint FK_LIBRO_LIBRO_AUTOR
foreign key (libro_codigo) references Libro;


CREATE TABLE TipoUsuario
(
codigo int IDENTITY(1,1) NOT NULL,
descripcion varchar(50) NOT NULL
)

alter table TipoUsuario add constraint PK_TIPOUSUARIO
primary key (codigo);

CREATE TABLE Usuario
(
codigo int IDENTITY(1,1) NOT NULL,
usuario varchar(45) NOT NULL,
clave varchar(45) NOT NULL,
nombre_completo varchar(100) NULL,
foto varchar(100) NULL,
tipo_usuario_codigo int NULL
);

alter table Usuario add constraint PK_USUARIO
primary key (codigo);

alter table Usuario add constraint FK_TIPO_USUARIO
foreign key (tipo_usuario_codigo) references TipoUsuario;

CREATE TABLE Prestamo
(
codigo int IDENTITY(1,1) NOT NULL,
usuario_codigo int NOT NULL,
libro_codigo int NOT NULL,
fecha_prestamo date NOT NULL,
fecha_devolucion date NOT NULL,
devuelto bit NOT NULL,
observacion varchar(100) NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
);

alter table Prestamo add constraint PK_PRESTAMO
primary key (codigo);

alter table Prestamo add constraint FK_USUARIO
foreign key (usuario_codigo) references Usuario;

alter table Prestamo add constraint FK_LIBRO_PRESTAMO
foreign key (libro_codigo) references Libro;

CREATE TABLE DetalleAutor
(
codigo int IDENTITY(1,1) NOT NULL,
nacionalidad varchar(20) NULL,
cantidad_libros int NULL,
libro_codigo int NULL
)

alter table DetalleAutor add constraint PK_DETALLE_AUTOR
primary key (codigo);

alter table DetalleAutor add constraint FK_DETALLE_AUTOR_LIBRO
foreign key (libro_codigo) references Libro;

-- nivel de demanda cuantitativa A(Alta), M(Media), B(Baja)
CREATE TABLE NivelDemandaLibro
(
codigo int IDENTITY(1,1) NOT NULL,
nivel_demanda char(1) NULL,
cantidad_veces int NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table NivelDemandaLibro add constraint PK_NIVEL_DEMANDA_LIBRO
primary key (codigo);

-- [Tarea]
-- 1
-- trigger para calcular el numero de veces que pidio el libro y
-- de acuerdo se pone una letra
-- A(Alta), M(Media), B(Baja)
-- el crear un nuevo registro en nivel demanda libro
-- 2
-- crear un procemiento almacenado para hacer la actualizacion automatica

CREATE TABLE EspacioLectura
(
codigo varchar(10) NOT NULL,
capacidad char(1) NULL,
estado bit NULL, -- activo o no, es decir, si no esta en repación
observacion varchar(100) NULL
)

alter table EspacioLectura add constraint PK_ESPACIO_LECTURA
primary key (codigo);

CREATE TABLE EspacioLecturaDetalle
(
codigo int IDENTITY(1,1) NOT NULL,
espacio_lectura_codigo varchar(10) NOT NULL,
usuario_codigo int NOT NULL,
disponible bit NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table EspacioLecturaDetalle add constraint PK_ESPACIO_LECTURA_DETALLE
primary key (codigo);

alter table EspacioLecturaDetalle add constraint FK_ESPACIO_LECTURA_DETALLE_ESPACIO_LECTURA
foreign key (espacio_lectura_codigo) references EspacioLectura;

alter table EspacioLecturaDetalle add constraint FK_ESPACIO_LECTURA_DETALLE_USUARIO
foreign key (usuario_codigo) references Usuario;

CREATE TABLE Carnet
(
codigo varchar(10) NOT NULL,
usuario_codigo int NOT NULL,
fecha_creacion datetime NULL
);

alter table Carnet add constraint PK_CARNET
primary key (codigo);

alter table Carnet add constraint FK_CARNET_USUARIO
foreign key (usuario_codigo) references Usuario;

-- Columna estado, H(Habilitado), R(Robo), S(Suspendido), P(Perdida)
-- Agregar el check respectivo
CREATE TABLE DetalleCarnet
(
codigo int identity(1,1) NOT NULL,
codigo_carnet varchar(10) NOT NULL,
estado char(1) NOT NULL,
bloquear bit NOT NULL, -- si no es esta Habilitado
observacion varchar(100) NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table DetalleCarnet add constraint PK_DETALLE_CARNET
primary key (codigo);

alter table DetalleCarnet add constraint FK_DETALLE_CARNET_CARNET
foreign key (codigo_carnet) references Carnet;
