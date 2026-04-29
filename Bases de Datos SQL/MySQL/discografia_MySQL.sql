-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 18-04-2011 a las 23:28:14
-- Versión del servidor: 5.5.8
-- Versión de PHP: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `Discografia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `album`
--

CREATE TABLE IF NOT EXISTS `album` (
  `codigo` int(7) NOT NULL,
  `titulo` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `discografia` varchar(25) COLLATE latin1_spanish_ci NOT NULL,
  `formato` enum('cassette','vinilo','cd','dvd','mp3') COLLATE latin1_spanish_ci NOT NULL,
  `fechaLanzamiento` date DEFAULT NULL,
  `fechaCompra` date DEFAULT NULL,
  `precio` float(5,2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancion`
--

CREATE TABLE IF NOT EXISTS `cancion` (
  `titulo` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `album` int(7) NOT NULL,
  `posicion` int(2) DEFAULT NULL,
  `duracion` time DEFAULT NULL,
  `version` enum('S','N') COLLATE latin1_spanish_ci DEFAULT NULL,
  `genero` enum('Acustica','Banda sonora','Blues','Electronica','Folk','Jazz','New age','Pop','Rock') COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`titulo`,`album`),
  KEY `album` (`album`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD CONSTRAINT `cancion_ibfk_1` FOREIGN KEY (`album`) REFERENCES `album` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Volcar la base de datos para la tabla `album`
--

INSERT INTO `album` (`codigo`, `titulo`, `discografia`, `formato`, `fechaLanzamiento`, `fechaCompra`, `precio`) VALUES
(1, 'Agila', 'ExtremoDuro', 'cd', '2011-04-01', '2011-04-18', 15.50),
(2, 'A puerta cerrada', 'Fito', 'cd', '2011-04-01', '2011-04-18', 16.25);

--
-- Volcar la base de datos para la tabla `cancion`
--

INSERT INTO `cancion` (`titulo`, `album`, `posicion`, `duracion`, `version`, `genero`) VALUES
('Barra americana', 2, 3, '00:00:02', 'S', 'Rock'),
('Buscando la luna', 1, 2, '00:00:02', 'S', 'Rock'),
('Prometeo', 1, 1, '00:00:02', 'S', 'Rock'),
('Rojitas las orejas', 2, 1, '00:00:02', 'S', 'Rock'),
('Sucede', 1, 3, '00:00:03', 'S', 'Rock'),
('Trozos de cristal', 2, 2, '00:00:01', 'S', 'Rock');
