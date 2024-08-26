-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema WIWork
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema WIWork
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WIWork` DEFAULT CHARACTER SET utf8 ;
USE `WIWork` ;

-- -----------------------------------------------------
-- Table `WIWork`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `tipo_autonomo` VARCHAR(45) NOT NULL,
  `tipo_professor` VARCHAR(45) NOT NULL,
  `tipo_adm` VARCHAR(45) NOT NULL,
  `tipo_comum` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`cursos` (
  `Id Cursos` INT NOT NULL,
  `descricao_cursos` TEXT NOT NULL,
  `nome_curso` VARCHAR(70) NOT NULL,
  `categoria_curso` VARCHAR(70) NOT NULL,
  `duracao_curso` DATETIME(12) NOT NULL,
  `preco_curso` REAL NOT NULL,
  PRIMARY KEY (`Id Cursos`),
  UNIQUE INDEX `Id Cursos_UNIQUE` (`Id Cursos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`usuario` (
  `Id usuario` INT NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Email` VARCHAR(35) NOT NULL,
  `Celular` CHAR(11) NOT NULL,
  `Senha` VARCHAR(7) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `CEP` CHAR(8) NOT NULL,
  `Nome` VARCHAR(70) NOT NULL,
  `N°  da casa` CHAR(4) NOT NULL,
  `Complemento` VARCHAR(40) NOT NULL,
  `tipo_usuario_idtipo_usuario` INT NOT NULL,
  `Cursos_Id Cursos` INT NOT NULL,
  PRIMARY KEY (`Id usuario`),
  UNIQUE INDEX `CPF Professor_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `Email Professor_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Id Usuário_UNIQUE` (`Id usuario` ASC) VISIBLE,
  UNIQUE INDEX `Senha_UNIQUE` (`Senha` ASC) VISIBLE,
  INDEX `fk_Usuário_tipo_usuario1_idx` (`tipo_usuario_idtipo_usuario` ASC) VISIBLE,
  INDEX `fk_Usuário_Cursos1_idx` (`Cursos_Id Cursos` ASC) VISIBLE,
  CONSTRAINT `fk_Usuário_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_idtipo_usuario`)
    REFERENCES `WIWork`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuário_Cursos1`
    FOREIGN KEY (`Cursos_Id Cursos`)
    REFERENCES `WIWork`.`cursos` (`Id Cursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`forma de pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`forma de pagamento` (
  `Id forma pagamento` INT NOT NULL,
  PRIMARY KEY (`Id forma pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`pagamento` (
  `Id pagamento` INT NOT NULL,
  `pagamento_concluido` VARCHAR(45) NOT NULL,
  `pagamento_pendente` VARCHAR(45) NOT NULL,
  `pagamento_data` DATE NOT NULL,
  `valor_pagamento` REAL NOT NULL,
  `Forma de Pagamento_Id forma pagamento` INT NOT NULL,
  PRIMARY KEY (`Id pagamento`),
  UNIQUE INDEX `Id pagamento_UNIQUE` (`Id pagamento` ASC) VISIBLE,
  INDEX `fk_pagamento_Forma de Pagamento1_idx` (`Forma de Pagamento_Id forma pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_Forma de Pagamento1`
    FOREIGN KEY (`Forma de Pagamento_Id forma pagamento`)
    REFERENCES `WIWork`.`forma de pagamento` (`Id forma pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`chat` (
  `mensagem` TEXT NOT NULL,
  `remetente_Id usuario` INT NOT NULL,
  `destinatario_id_usuario` INT NULL,
  INDEX `fk_Chat_Usuário1_idx` (`remetente_Id usuario` ASC, `destinatario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Chat_Usuário1`
    FOREIGN KEY (`remetente_Id usuario` , `destinatario_id_usuario`)
    REFERENCES `WIWork`.`usuario` (`Id usuario` , `Id usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`aluno_tem_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`aluno_tem_cursos` (
  `Usuário_Id usuario` INT NOT NULL,
  `cursos_Id cursos` INT NOT NULL,
  `pagamento_Id pagamento` INT NOT NULL,
  PRIMARY KEY (`Usuário_Id usuario`, `cursos_Id cursos`),
  INDEX `fk_Usuário_has_Cursos_Cursos1_idx` (`cursos_Id cursos` ASC) VISIBLE,
  INDEX `fk_Usuário_has_Cursos_Usuário1_idx` (`Usuário_Id usuario` ASC) VISIBLE,
  INDEX `fk_aluno_tem_Cursos_pagamento1_idx` (`pagamento_Id pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Usuário_has_Cursos_Usuário1`
    FOREIGN KEY (`Usuário_Id usuario`)
    REFERENCES `WIWork`.`usuario` (`Id usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuário_has_Cursos_Cursos1`
    FOREIGN KEY (`cursos_Id cursos`)
    REFERENCES `WIWork`.`cursos` (`Id Cursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_tem_Cursos_pagamento1`
    FOREIGN KEY (`pagamento_Id pagamento`)
    REFERENCES `WIWork`.`pagamento` (`Id pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WIWork`.`usuario_avalia_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WIWork`.`usuario_avalia_cursos` (
  `Usuário_Id Usuário` INT NOT NULL,
  `Cursos_Id Cursos` INT NOT NULL,
  PRIMARY KEY (`Usuário_Id Usuário`, `Cursos_Id Cursos`),
  INDEX `fk_Usuário_has_Cursos_Cursos2_idx` (`Cursos_Id Cursos` ASC) VISIBLE,
  INDEX `fk_Usuário_has_Cursos_Usuário2_idx` (`Usuário_Id Usuário` ASC) VISIBLE,
  CONSTRAINT `fk_Usuário_has_Cursos_Usuário2`
    FOREIGN KEY (`Usuário_Id Usuário`)
    REFERENCES `WIWork`.`usuario` (`Id usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuário_has_Cursos_Cursos2`
    FOREIGN KEY (`Cursos_Id Cursos`)
    REFERENCES `WIWork`.`cursos` (`Id Cursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
