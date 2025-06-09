/*1. Listar los nombres de
los proveedores de la ciudad de 
La Plata.*/

SELECT Nombre FROM Proveedor
WHERE Ciudad = 'La Plata';

/* 2. Listar los números de 
artículos cuyo precio sea 
inferior a $10. */

SELECT CodArt FROM Articulo
WHERE Precio < 10;

/* 3. Listar los responsables 
de los almacenes. */

SELECT Responsable FROM Almacen;

/* 4. Listar los códigos de 
los materiales que provea el proveedor
 3 y no los provea el proveedor 5. */

SELECT CodMat
FROM Provisto_Por
WHERE CodProv = 3

EXCEPT

SELECT CodMat
FROM Provisto_Por
WHERE CodProv = 5

-- or

SELECT CodMat
FROM Provisto_Por
WHERE CodProv = 3
AND CodMat NOT IN (
    SELECT CodMat
    FROM Provisto_Por
    WHERE CodProv = 5
);

/*5. Listar los números
 de almacenes que almacenan 
 el artículo 1.*/

SELECT Nro
FROM Tiene
WHERE CodArt = 1;

/* 6. Listar los proveedores 
de Pergamino que se llamen Pérez. */

SELECT *
FROM Proveedor
WHERE Ciudad = 'Pergamino'
AND Nombre LIKE '%Perez'

/* 7. Listar los almacenes
que contienen los 
artículos 1 y los
artículos 2 (ambos). */

SELECT Nro FROM Tiene WHERE CodArt = 1
INTERSECT
SELECT Nro FROM Tiene WHERE CodArt = 2

SELECT Nro
FROM Tiene
WHERE CodArt = 2
AND CodArt IN (
    SELECT Nro
    FROM Tiene
    WHERE CodArt = 1
); -- investigar

/* 8. Listar los artículos que 
cuesten más de $100 o que estén 
compuestos por el material 1. */

SELECT CodArt FROM Articulo WHERE Precio > 100
UNION
SELECT CodArt FROM Compuesto_Por WHERE CodMat = 1

-- or

SELECT A.CodArt
FROM Articulo AS A
JOIN
Compuesto_Por AS C
ON A.CodArt = C.CodArt
WHERE Precio > 100 OR CodMat = 1

/* 9. Listar los materiales, código
y descripción,provistos por proveedores
de la ciudad de La Plata. */

SELECT m.CodMat, m.Descripcion FROM Material m
JOIN Provisto_Por pp ON pp.CodMat = m.CodMat
JOIN Proveedor p ON p.CodProv = pp.CodProv
WHERE p.Ciudad = 'La Plata';

/*10. Listar el código, descripción y
precio de los artículos que se almacenan
en A1.*/

SELECT m.CodMat, m.Descripcion FROM Material m
JOIN Provisto_Por pp ON pp.CodMat = m.CodMat
WHERE pp.CodProv=1;

/* 11. Listar la descripción de los
materiales que componen el artículo B. */

SELECT m.Descripcion FROM Material m
JOIN Compuesto_Por comP ON m.CodMat = comP.CodMat
WHERE comP.CodArt = 2;
GO

/* 12. Listar los nombres de los
proveedores que proveen los materiales
al almacén que Juan Perez tiene a su cargo. */

SELECT p.Nombre FROM Proveedor p
JOIN Provisto_Por pp    ON p.CodProv = pp.CodProv
JOIN Compuesto_Por comP ON comP.CodMat = pp.CodMat
JOIN Tiene t            ON t.CodArt = comP.CodArt
JOIN Almacen a          ON a.Nro = t.Nro
WHERE a.Responsable = 'Juan Perez'
GO

/* 13. Listar códigos y descripciones
de los artículos compuestos por al
menos un material provisto por el
proveedor Plantense. */

SELECT distinct a.CodArt, a.Descripcion FROM Articulo a
JOIN Compuesto_Por comP ON comP.CodArt = a.CodArt
JOIN Provisto_Por  pp   ON pp.CodMat = comP.CodMat
JOIN Proveedor p        ON p.CodProv = pp.CodProv
WHERE p.Nombre = 'Verdulería Platense'

/* 14. Hallar los códigos y nombres
de los proveedores que proveen al
menos un material que se usa en algún
artículo cuyo precio es mayor a $100. */

SELECT distinct p.CodProv, p.Nombre FROM Proveedor p
JOIN   Provisto_Por pp    ON pp.CodProv = p.CodProv
JOIN   Compuesto_Por comP ON comP.CodMat= pp.CodMat
JOIN   Articulo a         ON a.CodArt = comP.CodArt
WHERE a.Precio > 10

