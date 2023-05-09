DROP DATABASE henry;
CREATE DATABASE henry;
/* Comentario
multilínea*/

USE henry;

-- Creo las tablas

CREATE TABLE carrera (
	idCarrera INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL,
    PRIMARY KEY (idCarrera)
    );
    
-- Query para ver la estructura de la tabla
DESC carrera;

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT,
    cedulaIdentidad VARCHAR (30) NOT NULL,
    nombre VARCHAR (40) NOT NULL,
    apellido VARCHAR (40) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fechaIncorporacion DATE,
    PRIMARY KEY (idInstructor)
    );
    
CREATE TABLE cohorte(
	idCohorte INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR (30) NOT NULL,
    idCarrera INT NOT NULL,
    idInstructor INT NOT NULL,
    fechaInicio DATE,
    fechaFinalizacion DATE,
    PRIMARY KEY (idCohorte),
    FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera),
    FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor)
    );

CREATE TABLE alumno(
	idAlumno INT NOT NULL,
    nombre VARCHAR (40) NOT NULL,
    apellido VARCHAR (40) NOT NULL,
	fechaNacimiento DATE NOT NULL,
    fechaIngreso DATE,
    idCohorte INT,
    cedulaIdentidad VARCHAR(50) NOT NULL, 
    PRIMARY KEY (idAlumno),
    FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte)
    );

