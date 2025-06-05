CREATE DATABASE ejercicio1;

USE ejercicio1;

CREATE TABLE Almacen (
    Nro INT PRIMARY KEY,
    Responsable VARCHAR(50)
);

create table Articulo (
    CodArt int primary key,
    Descripcion varchar(50),
    Precio decimal(12, 3)
);

CREATE TABLE Material (
    CodMat INT PRIMARY KEY,
    Descripcion VARCHAR(50)
);

CREATE TABLE Proveedor (
    CodProv INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Domicilio VARCHAR(50),
    Ciudad VARCHAR(50)
);

CREATE TABLE Tiene (
    Nro INT,
    CodArt INT
    CONSTRAINT PKTiene PRIMARY KEY (Nro, CodArt),
    CONSTRAINT FKTiene FOREIGN KEY (Nro) REFERENCES Almacen(Nro),
    CONSTRAINT FK1Tiene FOREIGN KEY (CodArt) REFERENCES Articulo(CodArt)
);

CREATE TABLE Compuesto_Por (
    CodArt INT,
    CodMat INT,
    CONSTRAINT PKCompuesto_Por PRIMARY KEY (CodArt, CodMat),
    CONSTRAINT FKCompuesto_Por FOREIGN KEY (CodArt) REFERENCES Articulo(CodArt),
    CONSTRAINT FK1Compuesto_Por FOREIGN KEY (CodMat) REFERENCES Material(CodMat)
);

CREATE TABLE Provisto_Por (
    CodMat INT,
    CodProv INT
    CONSTRAINT PKProvisto_Por PRIMARY KEY (CodMat, CodProv),
    CONSTRAINT FKProvisto_Por FOREIGN KEY (CodMat) REFERENCES Material(CodMat),
    CONSTRAINT FK1Provisto_Por FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
);


