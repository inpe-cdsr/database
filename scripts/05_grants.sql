--
-- Database: `catalog`
--
USE `catalog`;


-- --------------------------------------------------------

--
-- Grants for 'gerente'@'150.163.134.7' user
--

CREATE USER 'gerente'@'150.163.134.7' IDENTIFIED BY 'password';

GRANT SELECT, UPDATE ON catalog.Scene TO 'gerente'@'150.163.134.7';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.User TO 'gerente'@'150.163.134.7';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.Address TO 'gerente'@'150.163.134.7';

FLUSH PRIVILEGES;


--
-- Grants for 'gerente'@'150.163.134.104' user
--

CREATE USER 'gerente'@'150.163.134.104' IDENTIFIED BY 'password';

GRANT SELECT, UPDATE ON catalog.Scene TO 'gerente'@'150.163.134.104';

GRANT SELECT ON catalog._stac_collection  TO 'gerente'@'150.163.134.104';
GRANT SELECT ON catalog._stac_item   TO 'gerente'@'150.163.134.104';

GRANT CREATE, DROP, SELECT ON catalog.stac_collection TO 'gerente'@'150.163.134.104';
GRANT CREATE, DROP, SELECT ON catalog.stac_item TO 'gerente'@'150.163.134.104';

GRANT EXECUTE ON PROCEDURE catalog.update_stac_tables TO 'gerente'@'150.163.134.104';

FLUSH PRIVILEGES;


--
-- Grants for 'gerente'@'150.163.134.106' user
--

CREATE USER 'gerente'@'150.163.134.106' IDENTIFIED BY 'password';

GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.Scene TO 'gerente'@'150.163.134.106';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.SceneDataset TO 'gerente'@'150.163.134.106';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.Asset TO 'gerente'@'150.163.134.106';

FLUSH PRIVILEGES;


--
-- Grants for 'gerente'@'150.163.134.119' user
--

CREATE USER 'gerente'@'150.163.134.119' IDENTIFIED BY 'password';

GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.Scene TO 'gerente'@'150.163.134.119';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.SceneDataset TO 'gerente'@'150.163.134.119';
GRANT SELECT, INSERT, UPDATE, DELETE ON catalog.Asset TO 'gerente'@'150.163.134.119';

FLUSH PRIVILEGES;
