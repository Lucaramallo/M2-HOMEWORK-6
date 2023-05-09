USE henry;
 -- Insertar valores en las tablas
INSERT INTO carrera (nombre)
VALUES ('Data Science');

-- Varios valores
INSERT INTO instructor
VALUES (NULL, 'A2536', 'Claudia', 'Cantoni', '1987-02-05', '2023-01-01'),
       (NULL, 'A2006', 'Carlos', 'Nadie', '1995-02-06', '2023-02-01');
       
INSERT INTO cohorte
VALUES (NULL, 'DATA01', 1, 1, '2023-03-01', '2023-05-01'),
		(NULL, 'DATA02', 1, 2, '2023-02-01', '2023-06-01');
        
INSERT INTO alumno
VALUES (NULL, 'Jorge', 'Jiménez', '1998-05-05', curdate(), 1),
		(NULL, 'Ana', 'Fernandez', '2000-07-05', curdate(), 2);
        
-- Actualizar datos
UPDATE cohorte
SET fechaFinalizacion = '2023-06-02'
WHERE idCohorte = 2;

-- Traer información
SELECT nombre, fechaNacimiento
FROM alumno;

SELECT nombre as nombre_alumno, idAlumno * 1.21 as multiplicado
FROM alumno;

SELECT *
FROM alumno
-- WHERE idCohorte != 1;
WHERE fechaNacimiento > '1999-01-01';

SELECT *
FROM alumno
WHERE fechaNacimiento > '1999-01-01' AND nombre = 'Roberto';

SELECT *
FROM alumno
WHERE fechaNacimiento BETWEEN '1995-01-01' AND '2000-01-01';

SELECT *
FROM alumno
WHERE nombre LIKE '%or%';

SELECT *
FROM alumno
-- WHERE nombre = 'Ana' or nombre = 'Jorge'
WHERE nombre IN ('Ana', 'Roberto', 'Jorge');