-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema loja_motos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema loja_motos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `loja_motos` DEFAULT CHARACTER SET utf8 ;
USE `loja_motos` ;

-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_usuario` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_usuario` (
  `usu_id` BIGINT NOT NULL AUTO_INCREMENT,
  `usu_nome` VARCHAR(255) NOT NULL,
  `usu_sexo` CHAR(1) NOT NULL,
  `usu_cpf` CHAR(14) NOT NULL,
  `usu_email` VARCHAR(120) NOT NULL,
  `usu_login` VARCHAR(30) NOT NULL,
  `usu_senha` VARCHAR(32) NOT NULL,
  `usu_data_cadastro` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `usu_adm` TINYINT(1) NOT NULL DEFAULT 0,
  `usu_status` TINYINT(1) NOT NULL DEFAULT 1,
  `usu_tel1` VARCHAR(15) NOT NULL,
  `usu_tel2` VARCHAR(15) NULL,
  `usu_cep` VARCHAR(9) NOT NULL,
  `usu_estado` CHAR(2) NOT NULL,
  `usu_cidade` VARCHAR(60) NOT NULL,
  `usu_bairro` VARCHAR(30) NOT NULL,
  `usu_rua` VARCHAR(60) NOT NULL,
  `usu_numero` MEDIUMINT UNSIGNED NULL,
  `usu_complemento` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE INDEX `usu_login_UNIQUE` (`usu_login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_cliente` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_cliente` (
  `cli_id` BIGINT NOT NULL AUTO_INCREMENT,
  `cli_nome` VARCHAR(255) NOT NULL,
  `cli_cpf` CHAR(15) NULL,
  `cli_cnpj` CHAR(18) NULL,
  `cli_email` VARCHAR(120) NOT NULL,
  `cli_sexo` CHAR(1) NOT NULL,
  `cli_tel1` VARCHAR(15) NOT NULL,
  `cli_tel2` VARCHAR(15) NULL,
  `cli_cep` VARCHAR(9) NOT NULL,
  `cli_estado` CHAR(2) NOT NULL,
  `cli_cidade` VARCHAR(60) NOT NULL,
  `cli_bairro` VARCHAR(30) NOT NULL,
  `cli_rua` VARCHAR(60) NOT NULL,
  `cli_numero` MEDIUMINT UNSIGNED NULL,
  `cli_complemento` VARCHAR(20) NOT NULL,
  `cli_inadimplente` TINYINT(1) NOT NULL DEFAULT 0,
  `cli_fun_id` BIGINT NOT NULL,
  PRIMARY KEY (`cli_id`, `cli_fun_id`),
  INDEX `fk_tbl_cliente_tbl_usuario1_idx` (`cli_fun_id` ASC),
  CONSTRAINT `fk_tbl_cliente_tbl_usuario1`
    FOREIGN KEY (`cli_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_produto` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_produto` (
  `pro_id` BIGINT NOT NULL AUTO_INCREMENT,
  `pro_nome` VARCHAR(255) NOT NULL,
  `pro_descricao` TEXT NULL,
  `pro_img` VARCHAR(255) NULL,
  `pro_minimo_unidades` INT NOT NULL DEFAULT 0,
  `pro_qnt` INT ZEROFILL NOT NULL,
  `pro_preco_venda` DOUBLE(9,2) NOT NULL DEFAULT 0,
  `pro_fun_id` BIGINT NOT NULL,
  PRIMARY KEY (`pro_id`, `pro_fun_id`),
  INDEX `fk_tbl_produto_tbl_usuario1_idx` (`pro_fun_id` ASC),
  CONSTRAINT `fk_tbl_produto_tbl_usuario1`
    FOREIGN KEY (`pro_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_venda` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_venda` (
  `ven_id` BIGINT NOT NULL AUTO_INCREMENT,
  `ven_data` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `ven_valor_acrescimo` DOUBLE(9,2) NOT NULL,
  `ven_total_sem_acrescimo` DOUBLE(9,2) NOT NULL,
  `ven_total` DOUBLE(9,2) NOT NULL DEFAULT 0,
  `ven_parcelas` INT NULL,
  `ven_forma_pag` INT NOT NULL DEFAULT 0,
  `ven_cli_id` BIGINT NOT NULL,
  `ven_fun_id` BIGINT NOT NULL,
  INDEX `fk_tbl_venda_tbl_cliente1_idx` (`ven_cli_id` ASC),
  INDEX `fk_tbl_venda_tbl_usuario1_idx` (`ven_fun_id` ASC),
  PRIMARY KEY (`ven_id`),
  CONSTRAINT `fk_tbl_venda_tbl_cliente1`
    FOREIGN KEY (`ven_cli_id`)
    REFERENCES `loja_motos`.`tbl_cliente` (`cli_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_venda_tbl_usuario1`
    FOREIGN KEY (`ven_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	\n		';


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_saida_estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_saida_estoque` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_saida_estoque` (
  `sai_ven_id` BIGINT NOT NULL,
  `sai_qnt` INT NOT NULL DEFAULT 1,
  `sai_preco_unidade` DOUBLE(9,2) NOT NULL,
  `sai_preco_total` DOUBLE(9,2) NOT NULL DEFAULT 0,
  `sai_pro_id` BIGINT NOT NULL,
  INDEX `fk_tbl_produto_has_tbl_venda_tbl_venda1_idx` (`sai_ven_id` ASC),
  INDEX `fk_tbl_saida_estoque_tbl_produto1_idx` (`sai_pro_id` ASC),
  CONSTRAINT `fk_tbl_produto_has_tbl_venda_tbl_venda1`
    FOREIGN KEY (`sai_ven_id`)
    REFERENCES `loja_motos`.`tbl_venda` (`ven_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbl_saida_estoque_tbl_produto1`
    FOREIGN KEY (`sai_pro_id`)
    REFERENCES `loja_motos`.`tbl_produto` (`pro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_fornecedor` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_fornecedor` (
  `for_id` BIGINT NOT NULL AUTO_INCREMENT,
  `for_nome` VARCHAR(100) NOT NULL,
  `for_cnpj` CHAR(18) NOT NULL,
  `for_email` VARCHAR(120) NOT NULL,
  `for_tel1` VARCHAR(15) NOT NULL,
  `for_tel2` VARCHAR(15) NULL,
  `for_cep` VARCHAR(9) NULL,
  `for_estado` CHAR(2) NULL,
  `for_cidade` VARCHAR(60) NULL,
  `for_bairro` VARCHAR(30) NULL,
  `for_rua` VARCHAR(60) NULL,
  `for_numero` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
  `for_complemento` VARCHAR(20) NULL,
  `for_fun_id` BIGINT NOT NULL,
  PRIMARY KEY (`for_id`, `for_fun_id`),
  INDEX `fk_tbl_fornecedor_tbl_usuario1_idx` (`for_fun_id` ASC),
  UNIQUE INDEX `for_cnpj_UNIQUE` (`for_cnpj` ASC),
  CONSTRAINT `fk_tbl_fornecedor_tbl_usuario1`
    FOREIGN KEY (`for_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_nota_fiscal_resumida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_nota_fiscal_resumida` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_nota_fiscal_resumida` (
  `nota_id` BIGINT NOT NULL AUTO_INCREMENT,
  `nota_num` INT UNSIGNED NULL,
  `nota_data` DATE NULL,
  PRIMARY KEY (`nota_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_entrada_estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_entrada_estoque` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_entrada_estoque` (
  `ent_id` BIGINT NOT NULL AUTO_INCREMENT,
  `ent_pro_id` BIGINT NOT NULL,
  `ent_qnt` INT NOT NULL DEFAULT 1,
  `ent_preco_compra` DOUBLE(9,2) NOT NULL,
  `ent_data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ent_for_id` BIGINT NOT NULL,
  `ent_fun_id` BIGINT NOT NULL,
  `ent_nota_id` BIGINT NULL,
  PRIMARY KEY (`ent_id`, `ent_fun_id`),
  INDEX `fk_tbl_entrada_estoque_tbl_fornecedor1_idx` (`ent_for_id` ASC),
  INDEX `fk_tbl_entrada_estoque_tbl_produto1_idx` (`ent_pro_id` ASC),
  INDEX `fk_tbl_entrada_estoque_tbl_usuario1_idx` (`ent_fun_id` ASC),
  INDEX `fk_tbl_entrada_estoque_tbl_nota_fiscal_resumida1_idx` (`ent_nota_id` ASC),
  CONSTRAINT `fk_tbl_entrada_estoque_tbl_fornecedor1`
    FOREIGN KEY (`ent_for_id`)
    REFERENCES `loja_motos`.`tbl_fornecedor` (`for_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_entrada_estoque_tbl_produto1`
    FOREIGN KEY (`ent_pro_id`)
    REFERENCES `loja_motos`.`tbl_produto` (`pro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_entrada_estoque_tbl_usuario1`
    FOREIGN KEY (`ent_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_entrada_estoque_tbl_nota_fiscal_resumida1`
    FOREIGN KEY (`ent_nota_id`)
    REFERENCES `loja_motos`.`tbl_nota_fiscal_resumida` (`nota_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_estoque` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_estoque` (
  `est_id` BIGINT NOT NULL,
  `est_qnt` INT NOT NULL,
  `est_pro_id` BIGINT NOT NULL,
  PRIMARY KEY (`est_id`, `est_pro_id`),
  INDEX `fk_tbl_estoque_tbl_produto1_idx` (`est_pro_id` ASC),
  CONSTRAINT `fk_tbl_estoque_tbl_produto1`
    FOREIGN KEY (`est_pro_id`)
    REFERENCES `loja_motos`.`tbl_produto` (`pro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja_motos`.`tbl_aviso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `loja_motos`.`tbl_aviso` ;

CREATE TABLE IF NOT EXISTS `loja_motos`.`tbl_aviso` (
  `avi_id` BIGINT NOT NULL AUTO_INCREMENT,
  `avi_ven_id` BIGINT NOT NULL,
  `avi_fun_id` BIGINT NOT NULL,
  PRIMARY KEY (`avi_id`, `avi_fun_id`),
  INDEX `fk_tbl_aviso_tbl_usuario1_idx` (`avi_fun_id` ASC),
  CONSTRAINT `fk_tbl_aviso_tbl_usuario1`
    FOREIGN KEY (`avi_fun_id`)
    REFERENCES `loja_motos`.`tbl_usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `loja_motos` ;

-- -----------------------------------------------------
-- procedure str_update_pro_qnt
-- -----------------------------------------------------

USE `loja_motos`;
DROP procedure IF EXISTS `loja_motos`.`str_update_pro_qnt`;

DELIMITER $$
USE `loja_motos`$$
CREATE PROCEDURE `str_update_pro_qnt` (IN id INT(6))
BEGIN
	DECLARE entrada_total INT(6);
    DECLARE saida_total INT(6);
    DECLARE quantidade INT(6);
    
SELECT 
    SUM(ent_qnt)
INTO entrada_total FROM
    tbl_entrada_estoque
WHERE
    ent_pro_id = id;
SELECT 
    SUM(sai_qnt)
INTO saida_total FROM
    tbl_saida_estoque
WHERE
    sai_pro_id = id;
    SET entrada_total = COALESCE(entrada_total, 0);
    SET saida_total = COALESCE(saida_total, 0);
    SET quantidade = entrada_total - saida_total;
    IF saida_total <= entrada_total THEN
		UPDATE tbl_produto SET pro_qnt = quantidade WHERE pro_id = id;
	END IF;
END$$

DELIMITER ;
USE `loja_motos`;

DELIMITER $$

USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_venda_BEFORE_INSERT` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_venda_BEFORE_INSERT` BEFORE INSERT ON `tbl_venda` FOR EACH ROW
BEGIN
SET NEW.ven_total = NEW.ven_total_sem_acrescimo + NEW.ven_valor_acrescimo;
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_saida_estoque_AFTER_INSERT` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_saida_estoque_AFTER_INSERT` AFTER INSERT ON `tbl_saida_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(NEW.sai_pro_id);
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_saida_estoque_AFTER_UPDATE` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_saida_estoque_AFTER_UPDATE` AFTER UPDATE ON `tbl_saida_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(OLD.sai_pro_id);
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_saida_estoque_AFTER_DELETE` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_saida_estoque_AFTER_DELETE` AFTER DELETE ON `tbl_saida_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(OLD.sai_pro_id);
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_saida_estoque_BEFORE_INSERT` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_saida_estoque_BEFORE_INSERT` BEFORE INSERT ON `tbl_saida_estoque` FOR EACH ROW
BEGIN
SET NEW.sai_preco_total = NEW.sai_preco_unidade * NEW.sai_qnt;
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_entrada_estoque_AFTER_INSERT` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_entrada_estoque_AFTER_INSERT` AFTER INSERT ON `tbl_entrada_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(NEW.ent_pro_id);
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_entrada_estoque_AFTER_UPDATE` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_entrada_estoque_AFTER_UPDATE` AFTER UPDATE ON `tbl_entrada_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(NEW.ent_pro_id);
END$$


USE `loja_motos`$$
DROP TRIGGER IF EXISTS `loja_motos`.`tbl_entrada_estoque_AFTER_DELETE` $$
USE `loja_motos`$$
CREATE DEFINER = CURRENT_USER TRIGGER `loja_motos`.`tbl_entrada_estoque_AFTER_DELETE` AFTER DELETE ON `tbl_entrada_estoque` FOR EACH ROW
BEGIN
	CALL str_update_pro_qnt(OLD.ent_pro_id);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
