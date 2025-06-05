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
UNION
SELECT Nro FROM Tiene WHERE CodArt = 2

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
de la ciudad de Rosario. */