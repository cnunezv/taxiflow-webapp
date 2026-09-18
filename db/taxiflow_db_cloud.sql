-- =====================================================================
--  TaxiFlow - Script para la base de datos EN LA NUBE (Aiven MySQL)
--  Autor      : Carlos Andres Nunez Vargas
--
--  Diferencia con db/taxiflow_db.sql:
--  aqui NO se ejecuta CREATE DATABASE ni USE, porque en Aiven la base
--  de datos ya viene creada (se llama 'defaultdb') y el usuario del plan
--  gratuito no tiene permiso para crear otras.
--
--  Como ejecutarlo:
--    1) Consola de Aiven -> tu servicio MySQL -> pestana "Query editor",
--       pegar este contenido y ejecutar.
--    2) O desde tu PC:
--       mysql --host=<HOST> --port=<PUERTO> --user=avnadmin --password \
--             --ssl-mode=REQUIRED defaultdb < db/taxiflow_db_cloud.sql
--
--  El script es NO DESTRUCTIVO: usa IF NOT EXISTS e INSERT IGNORE.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Tabla usuarios (entidad comun exigida por la actividad)
--    id = identificador escrito por la persona (no autogenerado)
--    password = "clave"   |   tipo = "rol"
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id        VARCHAR(12)  NOT NULL,
    password  VARCHAR(20)  NOT NULL,
    nombre    VARCHAR(50)  NOT NULL,
    apellido  VARCHAR(70)  NOT NULL,
    email     VARCHAR(100) NOT NULL,
    tipo      VARCHAR(20)  NOT NULL DEFAULT 'Cliente',
    PRIMARY KEY (id),
    UNIQUE KEY uk_usuarios_email (email),
    KEY idx_usuarios_tipo (tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 2. Tabla carreras_taxi (entidad del ejercicio N.o 19)
--    Atributos exactos del enunciado: cliente, taxi, kilometros,
--    barrioInicio, barrioLlegada, cantidadPasajeros, taxista, precio,
--    duracionMinutos.
--    Los indices apoyan los dos reportes parametrizados.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS carreras_taxi (
    id                INT           NOT NULL AUTO_INCREMENT,
    cliente           VARCHAR(100)  NOT NULL,
    taxi              VARCHAR(20)   NOT NULL,
    kilometros        DECIMAL(6,2)  NOT NULL,
    barrioInicio      VARCHAR(60)   NOT NULL,
    barrioLlegada     VARCHAR(60)   NOT NULL,
    cantidadPasajeros INT           NOT NULL,
    taxista           VARCHAR(100)  NOT NULL,
    precio            DECIMAL(10,2) NOT NULL,
    duracionMinutos   INT           NOT NULL,
    PRIMARY KEY (id),
    KEY idx_carreras_barrio_inicio (barrioInicio),
    KEY idx_carreras_precio (precio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3. Datos iniciales - usuarios
--    IMPORTANTE: para demostrar la recuperacion de clave por correo,
--    cambia el email del usuario 'admin' por un correo real tuyo.
-- ---------------------------------------------------------------------
INSERT IGNORE INTO usuarios (id, password, nombre, apellido, email, tipo) VALUES
    ('admin',   'admin123', 'Carlos Andres', 'Nunez Vargas', 'admin@taxiflow.com',    'Administrador'),
    ('ldiaz',   'ldiaz123', 'Laura',         'Diaz Mendoza', 'laura.diaz@taxiflow.com',   'Cliente'),
    ('jperez',  'jperez12', 'Julio',         'Perez Romero', 'julio.perez@taxiflow.com',  'Taxista'),
    ('mgomez',  'mgomez12', 'Maritza',       'Gomez Torres', 'maritza.gomez@correo.com',  'Cliente'),
    ('rcastro', 'rcastro1', 'Ronaldo',       'Castro Silva', 'ronaldo.castro@correo.com', 'Taxista'),
    ('svega',   'svega123', 'Sandra',        'Vega Ortega',  'sandra.vega@taxiflow.com',  'Administrador');

-- ---------------------------------------------------------------------
-- 4. Datos iniciales - carreras de taxi
--    Se usan ids explicitos para que el script sea re-ejecutable
--    sin duplicar filas.
-- ---------------------------------------------------------------------
INSERT IGNORE INTO carreras_taxi
    (id, cliente, taxi, kilometros, barrioInicio, barrioLlegada, cantidadPasajeros, taxista, precio, duracionMinutos) VALUES
    ( 1, 'Laura Diaz',      'TAX-101',  6.50, 'El Recreo',    'Bocagrande',   2, 'Julio Perez',   18000.00, 22),
    ( 2, 'Maritza Gomez',   'TAX-102',  3.20, 'El Recreo',    'Manga',        1, 'Ronaldo Castro', 9500.00, 12),
    ( 3, 'Andres Molina',   'TAX-103', 12.80, 'El Recreo',    'La Boquilla',  4, 'Julio Perez',   32000.00, 35),
    ( 4, 'Diana Pacheco',   'TAX-104',  4.10, 'Bocagrande',   'Getsemani',    2, 'Ronaldo Castro',11000.00, 15),
    ( 5, 'Hernan Salgado',  'TAX-105',  9.40, 'Bocagrande',   'Crespo',       3, 'Julio Perez',   25000.00, 28),
    ( 6, 'Paola Restrepo',  'TAX-106',  2.70, 'Getsemani',    'Manga',        1, 'Ronaldo Castro', 8000.00, 10),
    ( 7, 'Camilo Ospina',   'TAX-107', 15.30, 'Crespo',       'El Laguito',   4, 'Julio Perez',   40000.00, 45),
    ( 8, 'Yulieth Barrios', 'TAX-108',  5.60, 'Manga',        'Pie de la Popa',2,'Ronaldo Castro',15000.00, 18),
    ( 9, 'Oscar Arrieta',   'TAX-109',  7.90, 'La Boquilla',  'Bocagrande',   3, 'Julio Perez',   21000.00, 26),
    (10, 'Kelly Montero',   'TAX-110',  1.80, 'Manga',        'Getsemani',    1, 'Ronaldo Castro', 6500.00,  8);

-- ---------------------------------------------------------------------
-- 5. Verificacion rapida (opcional)
-- ---------------------------------------------------------------------
-- SELECT COUNT(*) AS total_usuarios FROM usuarios;
-- SELECT COUNT(*) AS total_carreras FROM carreras_taxi;
