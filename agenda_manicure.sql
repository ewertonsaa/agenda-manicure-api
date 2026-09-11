-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: agenda_manicure
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agendamentos`
--

DROP TABLE IF EXISTS `agendamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint NOT NULL,
  `profissional_id` bigint NOT NULL,
  `servico_id` bigint NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'AGENDADO',
  `data` date NOT NULL,
  `horario` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agendamento_cliente` (`cliente_id`),
  KEY `fk_agendamento_profissional` (`profissional_id`),
  KEY `fk_agendamento_servico` (`servico_id`),
  CONSTRAINT `fk_agendamento_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_agendamento_profissional` FOREIGN KEY (`profissional_id`) REFERENCES `profissionais` (`id`),
  CONSTRAINT `fk_agendamento_servico` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos`
--

LOCK TABLES `agendamentos` WRITE;
/*!40000 ALTER TABLE `agendamentos` DISABLE KEYS */;
INSERT INTO `agendamentos` VALUES (1,1,1,1,'AGENDADO','2026-10-15','15:00:00'),(2,2,2,3,'CANCELADO','2026-09-07','00:00:00'),(3,3,1,4,'CANCELADO','2026-09-07','00:00:00'),(4,3,1,1,'CANCELADO','2026-09-07','00:00:00'),(5,1,1,1,'CANCELADO','2026-09-07','00:00:00'),(6,1,1,1,'CONCLUIDO','2026-09-07','00:00:00'),(7,1,1,1,'AGENDADO','2026-09-07','00:00:00'),(8,1,2,1,'AGENDADO','2026-09-07','00:00:00'),(9,1,2,1,'AGENDADO','2026-09-07','00:00:00'),(10,1,1,1,'CANCELADO','2026-09-08','14:00:00'),(12,1,1,1,'AGENDADO','2026-09-25','10:00:00'),(13,1,1,1,'CANCELADO','2026-10-01','10:00:00'),(14,1,1,1,'AGENDADO','2026-10-10','10:00:00'),(15,1,1,1,'AGENDADO','2026-09-01','10:00:00'),(16,1,1,1,'AGENDADO','2026-10-06','11:00:00'),(17,1,1,1,'AGENDADO','2026-10-10','14:00:00'),(18,1,1,1,'AGENDADO','2026-10-25','19:00:00'),(19,1,1,1,'AGENDADO','2026-10-25','10:00:00');
/*!40000 ALTER TABLE `agendamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Teste','11999999999'),(2,'Ana Souza','1988888888'),(3,'Juliana Oliveira','11977777777'),(5,'Cliente DTO','11988887777');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios_profissional`
--

DROP TABLE IF EXISTS `horarios_profissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios_profissional` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `profissional_id` bigint NOT NULL,
  `dia_semana` tinyint NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_horario_profissional` (`profissional_id`),
  CONSTRAINT `fk_horario_profissional` FOREIGN KEY (`profissional_id`) REFERENCES `profissionais` (`id`),
  CONSTRAINT `chk_dia_semana` CHECK ((`dia_semana` between 1 and 7))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios_profissional`
--

LOCK TABLES `horarios_profissional` WRITE;
/*!40000 ALTER TABLE `horarios_profissional` DISABLE KEYS */;
INSERT INTO `horarios_profissional` VALUES (1,1,2,'08:00:00','18:00:00'),(2,1,3,'08:00:00','18:00:00'),(3,1,4,'08:00:00','18:00:00'),(4,1,5,'08:00:00','18:00:00'),(5,1,6,'08:00:00','18:00:00'),(6,2,2,'08:00:00','18:00:00'),(7,2,3,'08:00:00','18:00:00'),(8,2,4,'08:00:00','18:00:00'),(9,2,5,'08:00:00','18:00:00'),(10,2,6,'08:00:00','18:00:00');
/*!40000 ALTER TABLE `horarios_profissional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profissionais`
--

DROP TABLE IF EXISTS `profissionais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profissionais` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profissionais`
--

LOCK TABLES `profissionais` WRITE;
/*!40000 ALTER TABLE `profissionais` DISABLE KEYS */;
INSERT INTO `profissionais` VALUES (1,'Nicelia Atualizada','11966666667'),(2,'Fernanda','11955555555'),(3,'Profissional DTO','11977776666');
/*!40000 ALTER TABLE `profissionais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicos`
--

DROP TABLE IF EXISTS `servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `duracao_minutos` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicos`
--

LOCK TABLES `servicos` WRITE;
/*!40000 ALTER TABLE `servicos` DISABLE KEYS */;
INSERT INTO `servicos` VALUES (1,'Manicure Premium','Cutilagem e esmaltação',40.00,75),(3,'Alongamento de unhas','Alongamento em gel',100.00,120),(4,'Manicure + Pedicure','Serviço completo de mãos e pés',60.00,120),(5,'Serviço DTO',NULL,55.00,90);
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agenda`
--

DROP TABLE IF EXISTS `vw_agenda`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agenda` AS SELECT 
 1 AS `id`,
 1 AS `cliente`,
 1 AS `profissional`,
 1 AS `servico`,
 1 AS `data`,
 1 AS `horario`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_agenda_completa`
--

DROP TABLE IF EXISTS `vw_agenda_completa`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda_completa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agenda_completa` AS SELECT 
 1 AS `id`,
 1 AS `cliente`,
 1 AS `profissional`,
 1 AS `servico`,
 1 AS `data`,
 1 AS `horario`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento`
--

DROP TABLE IF EXISTS `vw_faturamento`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento` AS SELECT 
 1 AS `servico`,
 1 AS `quantidade`,
 1 AS `faturamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento_cliente`
--

DROP TABLE IF EXISTS `vw_faturamento_cliente`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento_cliente` AS SELECT 
 1 AS `cliente`,
 1 AS `quantidade_agendamentos`,
 1 AS `total_gasto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento_profissional`
--

DROP TABLE IF EXISTS `vw_faturamento_profissional`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_profissional`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento_profissional` AS SELECT 
 1 AS `profissional`,
 1 AS `quantidade_atendimentos`,
 1 AS `faturamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'agenda_manicure'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_cadastrar_agendamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cadastrar_agendamento`(
    IN p_cliente_id BIGINT,
    IN p_profissional_id BIGINT,
    IN p_servico_id BIGINT,
    IN p_data_hora DATETIME
)
BEGIN

    DECLARE v_duracao INT;
    DECLARE v_hora_fim TIME;

    -- Cliente existe?
    IF NOT EXISTS (
        SELECT 1
        FROM clientes
        WHERE id = p_cliente_id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cliente nao encontrado';

    -- Profissional existe?
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM profissionais
        WHERE id = p_profissional_id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Profissional nao encontrada';

    -- Serviço existe?
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM servicos
        WHERE id = p_servico_id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Servico nao encontrado';

    -- Data/hora passada?
    ELSEIF p_data_hora <= NOW() THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nao e possivel agendar para uma data ou horario passado';

    ELSE

        -- Busca a duração do serviço
        SELECT duracao_minutos
        INTO v_duracao
        FROM servicos
        WHERE id = p_servico_id;

        -- Verifica se existe horário de trabalho para o profissional
        IF NOT EXISTS (
            SELECT 1
            FROM horarios_profissional
            WHERE profissional_id = p_profissional_id
              AND dia_semana = DAYOFWEEK(p_data_hora)
        ) THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Profissional nao trabalha neste dia';

        ELSE

            -- Busca o horário final do expediente
            SELECT hora_fim
            INTO v_hora_fim
            FROM horarios_profissional
            WHERE profissional_id = p_profissional_id
              AND dia_semana = DAYOFWEEK(p_data_hora)
              AND TIME(p_data_hora) >= hora_inicio
              AND TIME(p_data_hora) < hora_fim
            LIMIT 1;

            -- Horário está fora do expediente?
            IF v_hora_fim IS NULL THEN

                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Horario fora do expediente da profissional';

            -- O serviço termina depois do expediente?
            ELSEIF TIME(ADDTIME(
                p_data_hora,
                SEC_TO_TIME(v_duracao * 60)
            )) > v_hora_fim THEN

                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'O servico termina depois do expediente';

            -- Existe conflito?
            ELSEIF EXISTS (
                SELECT 1
                FROM agendamentos
                WHERE profissional_id = p_profissional_id
                  AND data_hora = p_data_hora
                  AND status = 'AGENDADO'
            ) THEN

                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Horario ja ocupado para esta profissional';

            ELSE

                INSERT INTO agendamentos (
                    cliente_id,
                    profissional_id,
                    servico_id,
                    data_hora,
                    status
                )
                VALUES (
                    p_cliente_id,
                    p_profissional_id,
                    p_servico_id,
                    p_data_hora,
                    'AGENDADO'
                );

            END IF;

        END IF;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cadastrar_agendamento_seguro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cadastrar_agendamento_seguro`(
    IN p_cliente_id INT,
    IN p_profissional_id INT,
    IN p_servico_id INT,
    IN p_data_hora DATETIME
)
BEGIN

    IF EXISTS (
        SELECT 1
        FROM agendamentos
        WHERE profissional_id = p_profissional_id
          AND data_hora = p_data_hora
          AND status = 'AGENDADO'
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Profissional já possui agendamento neste horário';

    ELSE

        INSERT INTO agendamentos (
            cliente_id,
            profissional_id,
            servico_id,
            data_hora,
            status
        )
        VALUES (
            p_cliente_id,
            p_profissional_id,
            p_servico_id,
            p_data_hora,
            'AGENDADO'
        );

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cancelar_agendamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cancelar_agendamento`(
	IN p_agendamento_id INT
)
BEGIN

	DECLARE v_status VARCHAR(20);
    
    SELECT status
    INTO v_status
    FROM agendamentos
    WHERE id = p_agendamento_id;
    
    IF v_status IS NULL THEN
    
		SELECT 'Agendamento não encontrado' AS mensagem;
        
	ELSEIF v_status = 'CANCELADO' THEN 
		
        SELECT 'Agendamento já está cancelado' AS mensagem;
        
	ELSE
    
		UPDATE agendamentos
        SET status = 'CANCELADO'
        WHERE id = p_agendamento_id;
        
        SELECT 'Agendamento cancelado com sucesso' AS mensagem;
        
	END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_concluir_agendamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_concluir_agendamento`(
    IN p_agendamento_id INT
)
BEGIN
    UPDATE agendamentos
    SET status = 'CONCLUIDO'
    WHERE id = p_agendamento_id
      AND status = 'AGENDADO';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consultar_agenda_dia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_agenda_dia`(
    IN p_data DATE
)
BEGIN

    SELECT
        a.id,
        c.nome AS cliente,
        p.nome AS profissional,
        s.nome AS servico,
        a.data_hora,
        a.status
    FROM agendamentos a
    JOIN clientes c
        ON a.cliente_id = c.id
    JOIN profissionais p
        ON a.profissional_id = p.id
    JOIN servicos s
        ON a.servico_id = s.id
    WHERE DATE(a.data_hora) = p_data
    ORDER BY a.data_hora;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consultar_horarios_disponiveis` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_horarios_disponiveis`(
    IN p_profissional_id BIGINT,
    IN p_data DATE
)
BEGIN

    WITH RECURSIVE horarios AS (
        SELECT
            profissional_id,
            hora_inicio AS horario,
            hora_fim
        FROM horarios_profissional
        WHERE profissional_id = p_profissional_id
          AND dia_semana = DAYOFWEEK(p_data)

        UNION ALL

        SELECT
            profissional_id,
            ADDTIME(horario, '00:30:00'),
            hora_fim
        FROM horarios
        WHERE ADDTIME(horario, '00:30:00') < hora_fim
    )

    SELECT
        horario,
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM agendamentos a
                WHERE a.profissional_id = p_profissional_id
                  AND DATE(a.data_hora) = p_data
                  AND TIME(a.data_hora) = horario
                  AND a.status = 'AGENDADO'
            )
            THEN 'OCUPADO'
            ELSE 'DISPONIVEL'
        END AS status
    FROM horarios
    ORDER BY horario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consulta_agenda_dia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_agenda_dia`(
	IN p_data DATE
)
BEGIN

	SELECT 
		id,
        cliente,
        profissional,
        servico,
        data_hora,
        status
	FROM vw_agenda
    WHERE DATE(data_hota_) = p_data
    ORDER BY data_hora;
    
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reagendar_agendamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reagendar_agendamento`(
    IN p_agendamento_id INT,
    IN p_nova_data_hora DATETIME
)
BEGIN

    UPDATE agendamentos
    SET data_hora = p_nova_data_hora
    WHERE id = p_agendamento_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_verificar_disponibilidade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verificar_disponibilidade`(
    IN p_profissional_id BIGINT,
    IN p_data_hora DATETIME
)
BEGIN

    SELECT
        a.id,
        c.nome AS cliente,
        p.nome AS profissional,
        s.nome AS servico,
        a.data_hora,
        a.status
    FROM agendamentos a
    JOIN clientes c
        ON a.cliente_id = c.id
    JOIN profissionais p
        ON a.profissional_id = p.id
    JOIN servicos s
        ON a.servico_id = s.id
    WHERE a.profissional_id = p_profissional_id
      AND a.data_hora = p_data_hora
      AND a.status = 'AGENDADO';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_agenda`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda` AS select `a`.`id` AS `id`,`c`.`nome` AS `cliente`,`p`.`nome` AS `profissional`,`s`.`nome` AS `servico`,`a`.`data` AS `data`,`a`.`horario` AS `horario`,`a`.`status` AS `status` from (((`agendamentos` `a` join `clientes` `c` on((`a`.`cliente_id` = `c`.`id`))) join `profissionais` `p` on((`a`.`profissional_id` = `p`.`id`))) join `servicos` `s` on((`a`.`servico_id` = `s`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_agenda_completa`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda_completa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda_completa` AS select `a`.`id` AS `id`,`c`.`nome` AS `cliente`,`p`.`nome` AS `profissional`,`s`.`nome` AS `servico`,`a`.`data` AS `data`,`a`.`horario` AS `horario`,`a`.`status` AS `status` from (((`agendamentos` `a` join `clientes` `c` on((`a`.`cliente_id` = `c`.`id`))) join `profissionais` `p` on((`a`.`profissional_id` = `p`.`id`))) join `servicos` `s` on((`a`.`servico_id` = `s`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento` AS select `s`.`nome` AS `servico`,count(`a`.`id`) AS `quantidade`,sum(`s`.`preco`) AS `faturamento` from (`agendamentos` `a` join `servicos` `s` on((`a`.`servico_id` = `s`.`id`))) where (`a`.`status` = 'AGENDADO') group by `s`.`id`,`s`.`nome` order by `faturamento` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_cliente`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_cliente` AS select `c`.`nome` AS `cliente`,count(`a`.`id`) AS `quantidade_agendamentos`,sum(`s`.`preco`) AS `total_gasto` from ((`agendamentos` `a` join `clientes` `c` on((`a`.`cliente_id` = `c`.`id`))) join `servicos` `s` on((`a`.`servico_id` = `s`.`id`))) where (`a`.`status` = 'AGENDADO') group by `c`.`id`,`c`.`nome` order by `total_gasto` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_profissional`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_profissional`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_profissional` AS select `p`.`nome` AS `profissional`,count(`a`.`id`) AS `quantidade_atendimentos`,sum(`s`.`preco`) AS `faturamento` from ((`agendamentos` `a` join `profissionais` `p` on((`a`.`profissional_id` = `p`.`id`))) join `servicos` `s` on((`a`.`servico_id` = `s`.`id`))) where (`a`.`status` = 'AGENDADO') group by `p`.`id`,`p`.`nome` order by `faturamento` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-10 21:47:51
