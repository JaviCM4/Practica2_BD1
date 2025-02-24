CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(50),
    codigo_postal INT
);

CREATE TABLE Municipio (
    id_municipio INT PRIMARY KEY,
    id_departamento INT,
    nombre VARCHAR(25),
    codigo_postal INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Persona (
    cui INT PRIMARY KEY,
    id_municipio INT,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    genero INT,
    direccion VARCHAR(50),
    fecha_nacimiento DATE,
    FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio)
);

CREATE TABLE Licencia (
    no_licencia INT PRIMARY KEY,
    cui INT,
    tipo VARCHAR(1),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Transporte (
    placa VARCHAR(9) PRIMARY KEY,
    cui INT,
    tipo VARCHAR(20),
    marca VARCHAR(20),
    modelo VARCHAR(20),
    motor VARCHAR(20),
    color VARCHAR(15),
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Impuesto (
    id_impuesto INT PRIMARY KEY,
    placa VARCHAR(9),
    tipo_pago VARCHAR(15),
    monto INT,
    fecha_vencimiento DATE,
    fecha_pago DATE,
    mora INT,
    estado BOOLEAN,
    FOREIGN KEY (placa) REFERENCES Transporte(placa)
);

CREATE TABLE Utilidad (
    id_utilidad INT PRIMARY KEY,
    placa VARCHAR(9),
    tipo VARCHAR(20),
    licencia_requerida VARCHAR(1),
    FOREIGN KEY (placa) REFERENCES Transporte(placa)
);

CREATE TABLE Empresa (
    id_empresa INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono INT,
    direccion VARCHAR(50)
);

CREATE TABLE Aseguradora (
    id_aseguradora INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono INT,
    direccion VARCHAR(50)
);

CREATE TABLE Seguro (
    id_seguro INT PRIMARY KEY,
    id_aseguradora INT,
    placa VARCHAR(9),
    tipo_poliza VARCHAR(20),
    monto_maximo INT,
    fecha_vencimiento DATE,
    FOREIGN KEY (id_aseguradora) REFERENCES Aseguradora(id_aseguradora),
    FOREIGN KEY (placa) REFERENCES Transporte(placa)
);

CREATE TABLE Juzgado (
    id_juzgado INT PRIMARY KEY,
    id_municipio INT,
    tipo_juzgado VARCHAR(25),
    jurisdiccion VARCHAR(50),
    direccion VARCHAR(75),
    telefono INT,
    horario VARCHAR(30),
    FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio)
);

CREATE TABLE Condicion (
    id_condicion INT PRIMARY KEY,
    id_accidente INT,
    tipo VARCHAR(25),
    FOREIGN KEY (id_accidente) REFERENCES Accidente(id_accidente)
);

CREATE TABLE Hospital (
    id_hospital INT PRIMARY KEY,
    id_municipio INT,
    nombre VARCHAR(50),
    direccion VARCHAR(75),
    telefono INT,
    FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio)
);

CREATE TABLE Accidente (
    id_accidente INT PRIMARY KEY,
    id_juzgado INT,
    ubicacion VARCHAR(75),
    detalles VARCHAR(250),
    fecha DATE,
    hora TIME,
    gravedad VARCHAR(25),
    FOREIGN KEY (id_juzgado) REFERENCES Juzgado(id_juzgado)
);

CREATE TABLE Servidores_Primarios (
    id_servidor INT PRIMARY KEY,
    id_accidente INT,
    cui INT,
    oficio VARCHAR(25),
    reporte VARCHAR(100),
    telefono INT,
    direccion VARCHAR(50),
    FOREIGN KEY (id_accidente) REFERENCES Accidente(id_accidente),
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Doctor (
    colegiado INT PRIMARY KEY,
    cui INT,
    telefono INT,
    cargo VARCHAR(35),
    especialidad VARCHAR(25),
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Registro (
    id_registro INT PRIMARY KEY,
    id_herido INT,
    cuadro VARCHAR(50),
    descripcion VARCHAR(100),
    tratamiento VARCHAR(100),
    estado VARCHAR(30),
    FOREIGN KEY (id_herido) REFERENCES Herido(id_herido)
);

CREATE TABLE Herido (
    id_herido INT PRIMARY KEY,
    id_accidente INT,
    id_hospital INT,
    colegiado_doctor INT,
    id_involucrado INT,
    cui INT,
    estado VARCHAR(30),
    FOREIGN KEY (id_accidente) REFERENCES Accidente(id_accidente),
    FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital),
    FOREIGN KEY (colegiado_doctor) REFERENCES Doctor(colegiado),
    FOREIGN KEY (id_involucrado) REFERENCES Transporte(id_involucrado),
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Transporte_Involucrado (
    id_involucrado INT PRIMARY KEY,
    id_accidente INT,
    placa VARCHAR(9),
    cui_piloto INT,
    FOREIGN KEY (id_accidente) REFERENCES Accidente(id_accidente),
    FOREIGN KEY (placa) REFERENCES Transporte(placa),
    FOREIGN KEY (cui_piloto) REFERENCES Persona(cui)
);

CREATE TABLE Falla_Mecanica (
    id_falla INT PRIMARY KEY,
    id_involucrado INT,
    falla VARCHAR(50),
    descripcion VARCHAR(100),
    FOREIGN KEY (id_involucrado) REFERENCES Transporte_Involucrado(id_involucrado)
);

CREATE TABLE Imprudencia (
    id_imprudencia INT PRIMARY KEY,
    id_involucrado INT,
    tipo VARCHAR(50),
    descripcion VARCHAR(100),
    FOREIGN KEY (id_involucrado) REFERENCES Transporte_Involucrado(id_involucrado)
);

CREATE TABLE Fallecido (
    id_fallecido INT PRIMARY KEY,
    id_accidente INT,
    id_involucrado INT,
    cui INT,
    fecha_muerte DATE,
    hora_muerte TIME,
    FOREIGN KEY (id_accidente) REFERENCES Accidente(id_accidente),
    FOREIGN KEY (id_involucrado) REFERENCES Transporte_Involucrado(id_involucrado),
    FOREIGN KEY (cui) REFERENCES Persona(cui)
);

CREATE TABLE Causa (
    id_causa INT PRIMARY KEY,
    id_fallecido INT,
    cuadro VARCHAR(50),
    descripcion VARCHAR(100),
    FOREIGN KEY (id_fallecido) REFERENCES Fallecido(id_fallecido)
);
