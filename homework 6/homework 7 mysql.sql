USE henry;



-- 1 cuantas carreras tiene henry?

SELECT count(idCarrera)
FROM carrera;

-- 2 Cuantos alumnos posee en total henry

select count(idAlumno)
from alumno;

-- 3 cuantos alumnos posee cada cohorte?

SELECT idCohorte, count(*) as cantidad_alumnos
FROM alumno
GROUP BY idCohorte;
 
-- 4 Confecciona un listado de los alumnos ordenado
-- por los últimos alumnos que ingresaron, 
-- con nombre y apellido en un solo campo.

SELECT concat(nombre, ' ', apellido) AS nombre_apellido, fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC;


-- 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?

SELECT nombre, fechaIngreso
FROM alumno
order by fechaIngreso
limit 3;

-- 6. ¿En que fecha ingreso?
SELECT date_format(fechaIngreso, '%d/%m/%Y') as fecha_ingreso
FROM alumno
ORDER BY fechaIngreso
LIMIT 1;

-- 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

SELECT concat(nombre, ' ', apellido) as nombre_ultimo_ing, fechaIngreso
FROM alumno
order by fechaIngreso DESC
limit 3;




-- 8. La función YEAR le permite extraer el año de un campo date,
-- utilice esta función y especifique cuantos alumnos ingresaron
-- a Henry por año.

SELECT YEAR(fechaIngreso) AS año_ingreso, count(*) AS cantidad
FROM alumno
GROUP BY YEAR(fechaIngreso)
ORDER BY año_ingreso;

-- 9. ¿Cuantos alumnos ingresaron por semana a henry?
-- , indique también el año. WEEKOFYEAR()


SELECT YEAR(fechaIngreso) AS año, WEEKOFYEAR(fechaIngreso) as semana, count(*) as cantidad
FROM alumno
GROUP BY YEAR(fechaIngreso), WEEKOFYEAR(fechaIngreso)
-- ORDER BY 1,2;
ORDER BY 1, 3;


-- 10. ¿En que años ingresaron más de 20 alumnos?
select year(fechaIngreso) as año_ing, count(*) as cantidad
from alumno
group by (año_ing)
having cantidad > 20
order by 1;


-- 11. Investigue las funciones TIMESTAMPDIFF() y CURDATE().
-- ¿Podría utilizarlas para saber cual es la edad de los instructores?.
-- ¿Como podrías verificar si la función cálcula años completos? 
-- Utiliza DATE_ADD().




/* TIMESTAMPDIFF CURDATE

TIMESTAMPDIFF es una función en MySQL que permite calcular 
la diferencia entre dos fechas o timestamp y
devuelve el resultado en una unidad especificada
(años, meses, días, horas, minutos, segundos).
Por ejemplo, podemos usar TIMESTAMPDIFF(DAY, '2022-01-01', '2022-01-05')
para calcular la diferencia en días entre '2022-01-01' y '2022-01-05'. 
El resultado sería 4.



CURDATE() es una función en MySQL que devuelve la fecha actual en formato 'YYYY-MM-DD'.
Se utiliza para insertar la fecha actual en una columna de tipo
fecha/timestamp en una tabla de la base de datos,
o para realizar comparaciones y cálculos con fechas en consultas SQL.

Por ejemplo, podemos utilizar CURDATE()
en una consulta para obtener todos los registros de una tabla
con fecha de creación igual a la fecha actual:

sql EJ:
SELECT * FROM table_name WHERE date_created = CURDATE();


TIMESTAMP es un tipo de datos en MySQL que almacena una fecha y hora con precisión de segundos. También se puede usar como una función para convertir una cadena de texto o una expresión en un valor de tipo TIMESTAMP.

Por ejemplo, podemos usar TIMESTAMP en una consulta
para insertar una fecha y hora específicas 
en una columna de tipo TIMESTAMP en una tabla de la base de datos:

INSERT INTO table_name (timestamp_column) VALUES (TIMESTAMP('2022-01-01 10:00:00'));
También podemos usar TIMESTAMP en una consulta para convertir una cadena de texto en un valor de tipo TIMESTAMP y realizar cálculos o comparaciones con fechas y horas:

sql
SELECT * FROM table_name WHERE timestamp_column < TIMESTAMP('2022-01-01 10:00:00');

*/



-- ¿Podría utilizarlas para saber cual es la edad de los instructores?.
 SELECT (idInstructor) as id_Ins,  nombre, apellido, fechaNacimiento, TIMESTAMPDIFF(YEAR,fechaNacimiento,curdate()) as edad_Ins
	 FROM instructor
     ORDER BY 4;

-- ¿Como podrías verificar si la función cálcula años completos? 


SELECT (idInstructor) as id_Ins, nombre, apellido, fechaNacimiento, 
	TIMESTAMPDIFF(MONTH,fechaNacimiento,curdate()) as edad_Ins_en_meses,
    (TIMESTAMPDIFF(day,fechaNacimiento,curdate()) / 12) AS edad_Ins_en_dias_div_12
FROM instructor
ORDER BY 4;

-- Utiliza DATE_ADD().
SELECT (idInstructor) as id_Ins, nombre, apellido, fechaNacimiento, 
	TIMESTAMPDIFF(MONTH,fechaNacimiento,curdate()) as edad_Ins_en_meses,
    (TIMESTAMPDIFF(MONTH,fechaNacimiento,curdate()) / 12) AS edad_Ins_en_meses_div_12,
    date_add(fechaNacimiento, interval timestampdiff(YEAR, fechaNacimiento, curdate()) year) AS ultimo_cumple
FROM instructor
ORDER BY 4;



-- 12. Cálcula:
--            - La edad de cada alumno.<br>

SELECT (TIMESTAMPDIFF(YEAR, fechaNacimiento,curdate())) as edad_al, 
       count(idAlumno) as cantidad_alumnos
FROM alumno
GROUP BY edad_al
ORDER BY cantidad_alumnos DESC;



--            - La edad promedio de los alumnos de henry.<br>

SELECT avg((TIMESTAMPDIFF(YEAR, fechaNacimiento,curdate()))) as promedio_edad_al
from alumno;



--           - La edad promedio de los alumnos de cada cohorte.<br>


SELECT idCohorte, avg(timestampdiff(YEAR, fechaNacimiento, curdate())) as edad_promedio
FROM alumno
GROUP BY idCohorte;




-- 13. Elabora un listado de los alumnos 
-- que superan la edad promedio de Henry.

SELECT idAlumno, concat(nombre, ' ', apellido) AS nombre_apellido
FROM alumno
WHERE timestampdiff(YEAR, fechaNacimiento, curdate()) >
	(SELECT avg(timestampdiff(YEAR, fechaNacimiento, curdate())) as edad_promedio
	FROM alumno);