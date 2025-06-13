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
WHERE CodArt = 1
AND Nro IN (
    SELECT Nro
    FROM Tiene
    WHERE CodArt = 2
); -- investigar

/* 8. Listar los artículos que 
cuesten más de $100 o que estén 
compuestos por el material 1. */

SELECT CodArt FROM Articulo WHERE Precio > 100
UNION
SELECT CodArt FROM Compuesto_Por WHERE CodMat = 1

-- or

SELECT A.CodArt FROM Articulo AS A
JOIN Compuesto_Por AS C ON A.CodArt = C.CodArt
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

/* 15. Listar los números de
almacenes que tienen todos
los artículos que incluyen el
material con código 7. */

SELECT a.Nro FROM Almacen a
JOIN Tiene t            ON t.Nro = a.Nro
JOIN Compuesto_Por comP ON comP.CodArt = t.CodArt
WHERE comP.CodMat = 7

/* 16. Listar los proveedores de
Capital Federal que sean únicos
proveedores de algún material. */

WITH cantProv AS (
SELECT codMat, COUNT(*) AS conteo FROM Provisto_Por
GROUP BY CodMat
)

SELECT pp.CodMat, p.Nombre FROM Proveedor p
JOIN Provisto_Por pp ON pp.CodProv = p.CodProv
JOIN cantProv cantP ON cantP.CodMat = pp.CodMat
WHERE cantP.conteo = 1

/* 17. Listar el/los artículo/s de mayor precio. */

SELECT CodArt, Descripcion FROM Articulo
WHERE Precio = (SELECT MAX(Precio) FROM Articulo)

-- or

WITH NOTPrecios AS (
    SELECT a.Precio AS menor FROM Articulo a
    CROSS JOIN Articulo n
    WHERE a.precio < n.Precio
)
SELECT * FROM Articulo
WHERE Precio NOT IN (SELECT * FROM NOTPrecios)

/* 18. Listar el/los artículo/s de menor precio. */

SELECT CodArt, Descripcion From Articulo
WHERE Articulo.Precio = (SELECT MIN(Articulo.Precio) FROM Articulo)

-- or

WITH notPrecio AS (
    SELECT distinct a.Precio FROM Articulo a
    CROSS JOIN Articulo b
    WHERE a.Precio > b.Precio
)
SELECT CodArt, Descripcion FROM Articulo a
WHERE Precio NOT IN (SELECT * FROM notPrecio)

/* 19. Listar el promedio de precios
de los artículos en cada almacén. */

SELECT 
    AVG(art.Precio) AS Promedio,
    a.Nro
FROM Almacen a
JOIN Tiene t ON a.Nro = t.Nro
JOIN Articulo art ON t.CodArt = art.CodArt
GROUP BY a.Nro

/* 20. Listar los almacenes que almacenan
la mayor cantidad de artículos. */

SELECT a.Nro, COUNT(CodArt) as CantArts FROM Almacen a
JOIN Tiene t ON t.Nro = a.Nro
GROUP BY a.Nro
ORDER BY CantArts DESC

-- or

SELECT a.Nro, COUNT(CodArt) AS CantArts FROM Almacen a
JOIN Tiene t ON t.Nro = a.Nro
GROUP BY a.Nro
HAVING COUNT(CodArt) = (
    SELECT MAX(art_count)
    FROM (
        SELECT COUNT(CodArt) AS art_count
        FROM Tiene
        GROUP BY Nro
    ) AS conteos
)

/* 21. Listar los artículos
compuestos por al menos 2 materiales. */

SELECT comP.CodArt from Compuesto_Por comP
GROUP BY comP.CodArt
HAVING COUNT(comP.CodMat) >= 2

/* 22. Listar los artículos compuestos
por exactamente 2 materiales */

SELECT comP.CodArt from Compuesto_Por comP
GROUP BY comP.CodArt
HAVING COUNT(comP.CodMat) = 2

/* 23. Listar los artículos que estén
compuestos con hasta 2 materiales. */

SELECT comP.CodArt from Compuesto_Por comP
GROUP BY comP.CodArt
HAVING COUNT(comP.CodMat) <= 2

/* 24. Listar los artículos compuestos
por todos los materiales. */

SELECT CodArt FROM Compuesto_Por