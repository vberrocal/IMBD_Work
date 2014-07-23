CREATE DATABASE Biblioteca;
GO

USE Biblioteca;
GO

-- tablas principales

CREATE TABLE Autor
(
idAutor int IDENTITY(1,1) NOT NULL,
nombres varchar(50) NOT NULL,
email varchar(60) NULL,
);

alter table Autor add constraint PK_AUTOR
primary key (idAutor);

CREATE TABLE Editorial
(
idEditorial int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL,
direccion varchar(100) NULL,
telefono varchar(20) NULL
);

alter table Editorial add constraint PK_EDITORIAL
primary key (idEditorial);

CREATE TABLE GeneroLibro
(
idGeneroLibro int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL
);

alter table GeneroLibro add constraint PK_ESPECIALIDADLIBRO
primary key (idGeneroLibro);

CREATE TABLE Libro
(
idLibro int identity(1,1) NOT NULL,
titulo varchar(50) NOT NULL,
cantidad_paginas int NULL
);

alter table Libro add constraint PK_LIBRO
primary key (idLibro);

CREATE TABLE DetalleLibro
(
idDetalleLibro int identity(1,1) NOT NULL,
libro_id int NOT NULL,
editorial_id int NOT NULL,
generolibro_id int NOT NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table DetalleLibro add constraint PK_DETALLELIBRO
primary key (idDetalleLibro);

alter table DetalleLibro add constraint FK_LIBRO
foreign key (libro_id) references Libro;

alter table DetalleLibro add constraint FK_EDITORIAL
foreign key (editorial_id) references Editorial;

alter table DetalleLibro add constraint FK_GENEROLIBRO
foreign key (generolibro_id) references GeneroLibro;


CREATE TABLE LibroAutor
(
idLibroAutor int identity(1,1) NOT NULL,
autor_id int NOT NULL,
libro_id int NOT NULL
);

alter table LibroAutor add constraint PK_LIBRO_AUTOR
primary key (idLibroAutor);

alter table LibroAutor add constraint FK_AUTOR
foreign key (autor_id) references Autor;

alter table LibroAutor add constraint FK_LIBRO_LIBRO_AUTOR
foreign key (libro_id) references Libro;

CREATE TABLE TipoUsuario
(
idTipoUsuario int IDENTITY(1,1) NOT NULL,
descripcion varchar(50) NOT NULL
)

alter table TipoUsuario add constraint PK_TIPOUSUARIO
primary key (idTipoUsuario);

CREATE TABLE Usuario
(
idUsuario int IDENTITY(1,1) NOT NULL,
usuario varchar(45) NOT NULL,
clave varchar(45) NOT NULL,
nombre_completo varchar(100) NULL,
foto varchar(100) NULL,
tipousuario_id int NULL
);

alter table Usuario add constraint PK_USUARIO
primary key (idUsuario);

alter table Usuario add constraint FK_TIPO_USUARIO
foreign key (tipousuario_id) references TipoUsuario;

CREATE TABLE Universidad
(
idUniversidad int IDENTITY(1,1) NOT NULL,
nombre varchar(50) NOT NULL,
direccion varchar(50) NULL
)

alter table Universidad add constraint PK_UBICACION
primary key (idUniversidad);

CREATE TABLE CentroEstudioUsuario
(
idCentroEstudioUsuario int IDENTITY(1,1) NOT NULL,
usuario_id int NOT NULL,
universidad_id int NOT NULL
)

alter table CentroEstudioUsuario add constraint PK_CENTRO_ESTUDIO_USUARIO
primary key (idCentroEstudioUsuario);

alter table CentroEstudioUsuario add constraint FK_CENTRO_ESTUDIO_USUARIO_USUARIO
foreign key (usuario_id) references Usuario;

alter table CentroEstudioUsuario add constraint FK_CENTRO_ESTUDIO_USUARIO_UNIVERSIDAD
foreign key (universidad_id) references Universidad;

CREATE TABLE Prestamo
(
idPrestamo int IDENTITY(1,1) NOT NULL,
usuario_id int NOT NULL,
libro_id int NOT NULL,
fecha_prestamo date NOT NULL,
fecha_devolucion date NOT NULL,
devuelto bit NOT NULL,
observacion varchar(100) NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
);

alter table Prestamo add constraint PK_PRESTAMO
primary key (idPrestamo);

alter table Prestamo add constraint FK_USUARIO
foreign key (usuario_id) references Usuario;

alter table Prestamo add constraint FK_LIBRO_PRESTAMO
foreign key (libro_id) references Libro;

CREATE TABLE DetalleAutor
(
idDetalleAutor int IDENTITY(1,1) NOT NULL,
nacionalidad varchar(20) NULL,
cantidad_libros int NULL,
libro_id int NULL
)

alter table DetalleAutor add constraint PK_DETALLE_AUTOR
primary key (idDetalleAutor);

alter table DetalleAutor add constraint FK_DETALLE_AUTOR_LIBRO
foreign key (libro_id) references Libro;

-- nivel de demanda cuantitativa A(Alta), M(Media), B(Baja)
CREATE TABLE NivelDemandaLibro
(
idNivelDemandaLibro int IDENTITY(1,1) NOT NULL,
libro_id int NOT NULL,
nivel_demanda char(1) NULL,
cantidad_veces int NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table NivelDemandaLibro add constraint PK_NIVEL_DEMANDA_LIBRO
primary key (idNivelDemandaLibro);

alter table NivelDemandaLibro add constraint FK_NIVEL_DEMANDA_LIBRO_LIBRO
foreign key (libro_id) references Libro;

-- [Tarea]
-- 1
-- trigger para calcular el numero de veces que pidio el libro y
-- de acuerdo se pone una letra
-- A(Alta), M(Media), B(Baja)
-- el crear un nuevo registro en nivel demanda libro
-- 2
-- crear un procemiento almacenado para hacer la actualizacion automatica

-- Medir la cantidad de estudiantes por universidad (progreso....)
CREATE TABLE DemandaEstudiante
(
idDemandaEstudiante int IDENTITY(1,1) NOT NULL,
centroestudiousuario_id int NOT NULL,
cantidad int NULL, -- cantidad de estudiantes por universidad
)

alter table DemandaEstudiante add constraint PK_DEMANDA_ESTUDIANTE
primary key (idDemandaEstudiante);

alter table DemandaEstudiante add constraint FK_DEMANDA_CENTRO_ESTUDIO
foreign key (centroestudiousuario_id) references CentroEstudioUsuario;

CREATE TABLE EspacioLectura
(
idEspacioLectura varchar(10) NOT NULL,
capacidad char(1) NULL,
estado bit NULL, -- activo o no, es decir, si no esta en repación
observacion varchar(100) NULL
)

alter table EspacioLectura add constraint PK_ESPACIO_LECTURA
primary key (idEspacioLectura);

CREATE TABLE EspacioLecturaDetalle
(
idEspLectDetalle int IDENTITY(1,1) NOT NULL,
espaciolectura_id varchar(10) NOT NULL,
usuario_id int NOT NULL,
disponible bit NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table EspacioLecturaDetalle add constraint PK_ESPACIO_LECTURA_DETALLE
primary key (idEspLectDetalle);

alter table EspacioLecturaDetalle add constraint FK_ESPACIO_LECTURA_DETALLE_ESPACIO_LECTURA
foreign key (espaciolectura_id) references EspacioLectura;

alter table EspacioLecturaDetalle add constraint FK_ESPACIO_LECTURA_DETALLE_USUARIO
foreign key (usuario_id) references Usuario;

CREATE TABLE Carnet
(
idCarnet varchar(10) NOT NULL,
usuario_id int NOT NULL,
fecha_creacion datetime NULL
);

alter table Carnet add constraint PK_CARNET
primary key (idCarnet);

alter table Carnet add constraint FK_CARNET_USUARIO
foreign key (usuario_id) references Usuario;

-- Columna estado, H(Habilitado), R(Robo), S(Suspendido), P(Perdida)
-- Agregar el check respectivo
CREATE TABLE DetalleCarnet
(
idDetalleCarnet int identity(1,1) NOT NULL,
carnet_id varchar(10) NOT NULL,
estado char(1) NOT NULL,
bloquear bit NOT NULL, -- si no es esta Habilitado
observacion varchar(100) NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table DetalleCarnet add constraint PK_DETALLE_CARNET
primary key (idDetalleCarnet);

alter table DetalleCarnet add constraint FK_DETALLE_CARNET_CARNET
foreign key (carnet_id) references Carnet;

CREATE TABLE TipoRequerimiento
(
idTipReq int IDENTITY(1,1) NOT NULL,
descripcion varchar(20) NULL
)

alter table TipoRequerimiento add constraint PK_TIPO_REQUERIMIENTO
primary key (idTipReq);

CREATE TABLE HistorialRequerimiento
(
idHistReq int IDENTITY(1,1) NOT NULL,
tipreq_id int NOT NULL,
prestamo_id int NOT NULL,
detallelibro_id int NOT NULL,
espaciolecturadetalle_id int NOT NULL,
fecha_creacion datetime NULL,
fecha_ultima_actualizacion datetime NULL
)

alter table HistorialRequerimiento add constraint PK_HISTORIAL_REQUERIMIENTO
primary key (idHistReq);

alter table HistorialRequerimiento add constraint FK_HISTORIAL_REQUERIMIENTO_TIP_REQ
foreign key (tipreq_id) references TipoRequerimiento;

alter table HistorialRequerimiento add constraint FK_HISTORIAL_REQUERIMIENTO_PRESTAMO
foreign key (prestamo_id) references Prestamo;

alter table HistorialRequerimiento add constraint FK_HISTORIAL_REQUERIMIENTO_DETALLE_LIBRO
foreign key (detallelibro_id) references DetalleLibro;

alter table HistorialRequerimiento add constraint FK_HISTORIAL_REQUERIMIENTO_ESPACIO_LECTURA_DETALLE
foreign key (espaciolecturadetalle_id) references EspacioLecturaDetalle;
