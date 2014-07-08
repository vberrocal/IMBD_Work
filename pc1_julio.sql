-- Parte 1

-- Generar DDL de tablas y restricciones

CREATE TABLE Ubigeo
(
cod_ubigeo varchar(6) not null,
cod_departamento varchar(2) null,
cod_provincia varchar(4) null,
cod_distrito varchar(6) null
)

CREATE TABLE Persona
(
dni varchar(8) not null,
nombres varchar(12) null,
ap_paterno varchar(12) null,
ap_materno varchar(12) null,
sexo char(1) null,  
fecha_nacimiento datetime null,
cod_ubigeo varchar(6) null,
direccion varchar(30) null
)

CREATE TABLE Opcion
(
cod_opcion char(6) not null,
desc_larg varchar(20) null,
desc_corta varchar(10) null,
url_imagen varchar(40) null,
estado bit null -- booleano 1 o 0
)

CREATE TABLE Sufragio
(
dni varchar(8) null, -- relacion con la tabla persona
cod_opcion char(6) null,
fecha datetime null
)

-- Tabla Ubigeo
ALTER TABLE Ubigeo ADD CONSTRAINT PK_Ubigeo PRIMARY KEY( cod_ubigeo );


-- Tabla Persona
ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY( dni );

ALTER TABLE Persona add constraint FK_Persona_Ubigeo
FOREIGN KEY (cod_ubigeo) references Ubigeo;

-- Validacion
ALTER TABLE Persona ADD CONSTRAINT CK_Sexo CHECK (sexo = 'M' or sexo = 'F');


-- Tabla Opcion
ALTER TABLE Opcion ADD CONSTRAINT PK_Opcion PRIMARY KEY( cod_opcion );


-- Tabla Sufragio
ALTER TABLE Sufragio add constraint FK_Sufragio_Persona
FOREIGN KEY (dni) references Persona;

ALTER TABLE Sufragio add constraint FK_Sufragio_Opcion
FOREIGN KEY (cod_opcion) references Opcion;

-- Se permite voto en blanco
ALTER TABLE Sufragio ADD CONSTRAINT DF_Opcion DEFAULT N'-' FOR cod_opcion;



-- Drop tabla Ubigeo
ALTER TABLE Persona drop constraint FK_Persona_Ubigeo;

ALTER TABLE Ubigeo DROP CONSTRAINT PK_Ubigeo;

DROP TABLE UBIGEO;

-- Vuelvo a crear la tabla Ubigeo y sus relaciones
CREATE TABLE Ubigeo
(
cod_ubigeo varchar(6) not null,
cod_departamento varchar(2) null,
cod_provincia varchar(4) null,
cod_distrito varchar(6) null
)

ALTER TABLE Ubigeo ADD CONSTRAINT PK_Ubigeo PRIMARY KEY( cod_ubigeo );

ALTER TABLE Persona add constraint FK_Persona_Ubigeo
FOREIGN KEY (cod_ubigeo) references Ubigeo;


-- Crear procedimiento almacenado verificarSufragioPersona
CREATE PROCEDURE verificarSufragioPersona
@dni varchar(8),
@resultado char(1) OUTPUT
AS
if exists ( select * from Sufragio where dni = @dni )
Begin
set @resultado = 'S'
end
else
Begin
set @resultado = 'N'
end
GO

-- probar el procedimiento almacenado
declare @dni varchar(8),
@resultado char(1)
execute verificarSufragioPersona '47415778',
@resultado OUTPUT
select @resultado as '¿Sufrago?'
go

-- Parte 2 DML
-- Generar el DML para obtener un listado de ubigeos, mostrando la cantidad de votos por
-- opción, sin contar los votos en blanco.
select u.cod_ubigeo, u.cod_departamento, u.cod_provincia,
u.cod_distrito, o.cod_opcion, o.desc_larg, COUNT(o.cod_opcion) as 'cantidad'
from
Opcion o
inner join Sufragio s
on o.cod_opcion = s.cod_opcion
inner join Persona p
on p.dni = s.dni
inner join Ubigeo u
on u.cod_ubigeo = p.cod_ubigeo
where s.cod_opcion <> '-'
group by u.cod_ubigeo, u.cod_departamento, u.cod_provincia,
u.cod_distrito, o.cod_opcion, o.desc_larg

-- Generar el DML para obtener un listado de ubigeos mostrando el porcentaje de personas
-- distintas que han sufragado
select
((Count(p.cod_ubigeo) * 100) / (select count(u.cod_ubigeo) from Ubigeo u
inner join Persona p
on u.cod_ubigeo = p.cod_ubigeo
))
as 'porcentaje', u.cod_ubigeo
from
Persona p
inner join Ubigeo u
on u.cod_ubigeo = p.cod_ubigeo
group by p.cod_ubigeo,  u.cod_ubigeo


-- Parte 3 DCL
-- permisos para los usuarios appuser y appadmin
USE PC1
GRANT SELECT ON Ubigeo TO appuser
GRANT SELECT ON Persona TO appuser
GRANT SELECT ON Opcion TO appuser
GRANT SELECT ON Sufragio TO appuser
GO

USE PC1
GRANT SELECT, UPDATE, INSERT, DELETE ON Ubigeo TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Persona TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Opcion TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Sufragio TO appadmin
GO
