
-- Tabla: Clientes
CREATE TABLE Clientes (
    idCliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL,
    saldo INTEGER,
    estado SMALLINT
);

-- Tabla: Administradores
CREATE TABLE Administradores (
    idAdmin SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL
);

-- Tabla: Categorias
CREATE TABLE Categorias (
    idCategoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    idCategoriaPadre INTEGER REFERENCES Categorias(idCategoria)
);

-- Tabla: Promociones
CREATE TABLE Promociones (
    idPromocion SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    descuento INTEGER NOT NULL
);

-- Tabla: Contenidos
CREATE TABLE Contenidos (
    idContenido SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    precio INTEGER NOT NULL,
    calificacionPromedio DECIMAL(3,2) NOT NULL,
    formato VARCHAR(10) NOT NULL,
    archivo BYTEA NOT NULL,
    mimeType VARCHAR(50) NOT NULL,
    extension_archivo VARCHAR(50) NOT NULL,
    tamaño DECIMAL(10,2) NOT NULL,
    idCategoria INTEGER NOT NULL REFERENCES Categorias(idCategoria),
    idPromocion INTEGER REFERENCES Promociones(idPromocion)
);

-- Tabla: Compras
CREATE TABLE Compras (
    idCompra SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    idCliente INTEGER NOT NULL REFERENCES Clientes(idCliente)
);

-- Tabla: Contenidos_Clientes 
CREATE TABLE Contenidos_Clientes (
    idCliente INTEGER NOT NULL,
    idContenido INTEGER NOT NULL,
    idCompra INTEGER NOT NULL,
    puntaje SMALLINT,
    PRIMARY KEY (idCliente, idContenido, idCompra),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idContenido) REFERENCES Contenidos(idContenido),
    FOREIGN KEY (idCompra) REFERENCES Compras(idCompra)
);

-- Tabla: Carrito_compras
CREATE TABLE Carrito_compras (
    idCliente INTEGER NOT NULL,
    idContenido INTEGER NOT NULL,
    descuentoAplicado SMALLINT,
    PRIMARY KEY (idCliente, idContenido),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idContenido) REFERENCES Contenidos(idContenido)
);

-- Tabla: Descargas
CREATE TABLE Descargas (
    idCliente INTEGER NOT NULL,
    idContenido INTEGER NOT NULL,
    fecha TIMESTAMP NOT NULL,
    PRIMARY KEY (idCliente, idContenido),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idContenido) REFERENCES Contenidos(idContenido)
);

-- Tabla: Notificaciones
CREATE TABLE Notificaciones (
    idCliente INTEGER NOT NULL,
    idContenido INTEGER NOT NULL,
    PRIMARY KEY (idCliente, idContenido),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idContenido) REFERENCES Contenidos(idContenido)
);

-- Tabla: Ranking
CREATE TABLE Ranking (
    idRanking SERIAL PRIMARY KEY,
    tipoRanking VARCHAR(30) NOT NULL,
    periodo VARCHAR(20) NOT NULL,
    posicionActual INTEGER NOT NULL,
    posicionAnterior INTEGER,
    valorRanking DECIMAL(5,2) NOT NULL,
    idCliente INTEGER REFERENCES Clientes(idCliente),
    idContenido INTEGER REFERENCES Contenidos(idContenido)
);
