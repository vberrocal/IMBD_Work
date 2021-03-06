CREATE DATABASE PC1
GO

USE PC1
GO

------ Parte 1 - DDL
------ Pregunta 1

CREATE TABLE Estudiante (
    id_estudiante [nvarchar](10) NOT NULL,
    nombres [nvarchar](35) NOT NULL,
    ap_paterno [nvarchar](35) NOT NULL,
    ap_materno [nvarchar](35) NOT NULL,
    sexo [char](1) NOT NULL,
    fecha_nacimiento [date] NOT NULL)   
   
ALTER TABLE Estudiante ADD CONSTRAINT PK_Estudiante PRIMARY KEY( id_estudiante );   
-- validaciones
ALTER TABLE Estudiante ADD CONSTRAINT CK_Nombre CHECK ( SUBSTRING(nombres,1,1) = UPPER(SUBSTRING(nombres,1,1)) );  
ALTER TABLE Estudiante ADD CONSTRAINT CK_Ap_Paterno CHECK (substring(ap_paterno,1,1) = UPPER(substring(ap_paterno,1,1)));
ALTER TABLE Estudiante ADD CONSTRAINT CK_Ap_Materno CHECK (substring(ap_materno,1,1) = UPPER(substring(ap_materno,1,1)));
ALTER TABLE Estudiante ADD CONSTRAINT CK_Sexo CHECK (sexo = 'M' or sexo = 'F'); 

CREATE TABLE Curso (
    id_curso [nvarchar](6) NOT NULL,
    nombre [nvarchar](50) NOT NULL,
    cant_creditos int NOT NULL);
   
ALTER TABLE Curso ADD CONSTRAINT PK_Curso PRIMARY KEY ( id_curso );   

CREATE TABLE Estudiante_Curso (
    id_curso [nvarchar](6) NOT NULL,
    id_estudiante [nvarchar](10) NOT NULL,
    ciclo int NOT NULL,
    nota_final [decimal](4,2) NULL);

ALTER TABLE Estudiante_Curso add constraint FK_Estudiante_Curso_Curso
FOREIGN KEY (id_curso) references Curso;

ALTER TABLE Estudiante_Curso add constraint FK__Estudiante_Curso_Estudiante
FOREIGN KEY (id_estudiante) references Estudiante;

-- validaciones
ALTER TABLE Estudiante_Curso ADD CONSTRAINT CK_nota_final CHECK (nota_final >= 0 and nota_final <= 20);

CREATE TABLE Evaluacion (
	id_evaluacion int IDENTITY(1,1) NOT NULL,
    id_curso [nvarchar](6) NOT NULL,
    id_estudiante [nvarchar](10) NULL,
    tipo [char](2) NOT NULL,   
    fecha_evaluacion [datetime] NOT NULL,
    nota [decimal](4,2) NOT NULL)

ALTER TABLE Evaluacion add constraint FK_Evaluacion_Curso
FOREIGN KEY (id_curso) references Curso;

ALTER TABLE Evaluacion add constraint FK__Evaluacion_Estudiante
FOREIGN KEY (id_estudiante) references Estudiante;

-- validaciones
ALTER TABLE Evaluacion ADD CONSTRAINT CK_tipo CHECK (tipo = 'PC' or tipo = 'TF' or tipo = 'EB');
ALTER TABLE Evaluacion ADD CONSTRAINT CK_nota CHECK (nota >= 0 and nota <= 20);

-- campos de auditoria para la tabla Evaluacion
ALTER TABLE Evaluacion ADD fecha_registro date
ALTER TABLE Evaluacion ADD fecha_modificacion date

-- triggers de insert y update
CREATE TRIGGER InsertarFechaRegistro
ON dbo.Evaluacion
AFTER INSERT AS
BEGIN
SET NOCOUNT ON;
update dbo.Evaluacion set fecha_registro = GETDATE() where id_evaluacion = @@IDENTITY
END
GO

CREATE TRIGGER InsertarFechaModificacion
ON dbo.Evaluacion
AFTER UPDATE AS
IF (UPDATE(id_curso) or UPDATE(id_estudiante)
or UPDATE(tipo)or UPDATE(fecha_evaluacion) or UPDATE(nota))
BEGIN
SET NOCOUNT ON;
update dbo.Evaluacion set fecha_modificacion = GETDATE() where id_evaluacion = @@IDENTITY
END
GO

-- Procedimiento almacenado para obtener el promedio final de un curso
drop PROCEDURE uspObtenerPromedioCurso
GO

CREATE PROCEDURE uspObtenerPromedioCurso 
@idCurso int,
@idEstudiante int,
@promedio_pc float OUTPUT,
@trabajo_final float OUTPUT,
@eveluacion_final float OUTPUT,
@promedio float OUTPUT
AS

select @promedio_pc = avg(nota) from Evaluacion
where tipo = 'PC' and id_estudiante = @idEstudiante
and id_curso = @idCurso

select @trabajo_final = nota from Evaluacion
where tipo = 'TF' and id_estudiante = @idEstudiante
and id_curso = @idCurso

select @eveluacion_final = nota from Evaluacion
where tipo = 'EB' and id_estudiante = @idEstudiante
and id_curso = @idCurso

set @promedio = (@promedio_pc * 0.4) + (@trabajo_final * 0.3) + (@eveluacion_final * 0.3)

GO

declare @promedio float,
@promedio_pc float,
@trabajo_final float,
@eveluacion_final float

execute uspObtenerPromedioCurso 1,1,
@promedio_pc  OUTPUT,
@trabajo_final  OUTPUT,
@eveluacion_final OUTPUT, 
@promedio OUTPUT
select @promedio as 'Promedio Final'
go

-- Parte 2
SELECT (es.nombres+' '+es.ap_paterno+' '+es.ap_materno) as 'Nombre Completo',
c.nombre as 'Curso', ev.tipo as 'Tipo', ev.nota as 'Nota'
FROM Evaluacion ev
LEFT JOIN Estudiante es
ON ev.id_estudiante = es.id_estudiante
LEFT JOIN Curso c
on ev.id_curso = c.id_curso;

-- cantidad de alumnos por ciclo que NO tienen registrada nota de la evaluación del trabajo final
-- tipo = 'TF'

select COUNT(*) as 'N° Estudiantes',
esc.ciclo as 'Ciclo'
from Estudiante_Curso esc
join Estudiante e
on esc.id_estudiante = e.id_estudiante
join Evaluacion ev
on esc.id_estudiante = ev.id_estudiante
where not exists (select * from Evaluacion eva where tipo = 'TF'
and eva.id_estudiante = esc.id_estudiante)
group by esc.ciclo

-- creacion de los usuarios
USE [master]
GO
CREATE LOGIN [appuser] WITH PASSWORD=N'123456' 
MUST_CHANGE, DEFAULT_DATABASE=[PC1],
 CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [PC1]
GO
CREATE USER [appuser] FOR LOGIN [appuser]
GO

USE [master]
GO
CREATE LOGIN [appadmin] WITH PASSWORD=N'123456' 
MUST_CHANGE, DEFAULT_DATABASE=[PC1],
 CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [PC1]
GO
CREATE USER [appadmin] FOR LOGIN [appadmin]
GO

-- permisos de solo lectura
USE PC1
GRANT SELECT ON Curso TO appuser
GRANT SELECT ON Estudiante TO appuser
GRANT SELECT ON Estudiante_Curso TO appuser
GRANT SELECT ON Evaluacion TO appuser
GO

USE PC1
GRANT SELECT, UPDATE, INSERT, DELETE ON Curso TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Estudiante TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Estudiante_Curso TO appadmin
GRANT SELECT, UPDATE, INSERT, DELETE ON Evaluacion TO appadmin
GO
