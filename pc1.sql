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
ALTER TABLE Estudiante ADD CONSTRAINT CK_Nombre CHECK (substring(nombres,1,1) = UPPER(substring(nombres,1,1)));
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
ALTER TABLE Estudiante_Curso ADD CONSTRAINT CK_nota_final CHECK (nota_final > 0 and nota_final < 20);

-- el correlativo es porque hay dos registros con PC
CREATE TABLE Evaluacion (
    id_curso [nvarchar](6) NOT NULL,
    id_estudiante [nvarchar](10) NOT NULL,
    tipo [char](2) NOT NULL,   
    fecha_evaluacion [datetime] NOT NULL,
    nota [decimal](4,2) NOT NULL)

ALTER TABLE Evaluacion add constraint FK_Evaluacion_Curso
FOREIGN KEY (id_curso) references Curso;

ALTER TABLE Evaluacion add constraint FK__Evaluacion_Estudiante
FOREIGN KEY (id_estudiante) references Estudiante;

-- validaciones
ALTER TABLE Evaluacion ADD CONSTRAINT CK_tipo CHECK (tipo = 'PC' or tipo = 'TF' or tipo = 'EB');
ALTER TABLE Evaluacion ADD CONSTRAINT CK_nota CHECK (nota > 0 and nota < 20);
