DROP DATABASE IF EXISTS ibd015_p2_arthur_peres;
CREATE DATABASE IF NOT EXISTS ibd015_p2_arthur_peres;
USE ibd015_p2_arthur_peres;


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-06-24 21:14:58.798

-- tables
-- Table: Cargo
CREATE TABLE Cargo (
    Cargo_id int  NOT NULL AUTO_INCREMENT,
    Cargo_acesso varchar(100)  NOT NULL,
    CONSTRAINT Cargo_pk PRIMARY KEY (Cargo_id)
);

-- Table: Categoria
CREATE TABLE Categoria (
    Categoria_id int  NOT NULL AUTO_INCREMENT,
    Categoria_status boolean  NULL,
    Categoria_pai int  NULL,
    Categoria_nome varchar(50)  NOT NULL,
    CONSTRAINT Categoria_pk PRIMARY KEY (Categoria_id)
);

-- Table: Entrada
CREATE TABLE Entrada (
    Ent_id int  NOT NULL AUTO_INCREMENT,
    Ent_dataCriacao date  NOT NULL,
    Usuario_id int  NOT NULL,
    Ent_valorTot decimal(8,2)  NOT NULL,
    CONSTRAINT Entrada_pk PRIMARY KEY (Ent_id)
);

-- Table: Fornecedor
CREATE TABLE Fornecedor (
    Forn_id int  NOT NULL AUTO_INCREMENT,
    Forn_status boolean  NULL,
    Forn_nome varchar(50)  NOT NULL,
    Forn_razaoSocial varchar(30)  NOT NULL,
    Forn_cnpj varchar(19)  NOT NULL,
    CONSTRAINT Fornecedor_pk PRIMARY KEY (Forn_id)
);

-- Table: Fornecedor_Produto
CREATE TABLE Fornecedor_Produto (
    FornProd_id int  NOT NULL AUTO_INCREMENT,
    Forn_id int  NOT NULL,
    Prod_cod int  NOT NULL,
    CONSTRAINT Fornecedor_Produto_pk PRIMARY KEY (FornProd_id)
);

-- Table: Local_Armazenamento
CREATE TABLE Local_Armazenamento (
    LocAr_id int  NOT NULL AUTO_INCREMENT,
    LocAr_status boolean  NULL,
    Setor_id int  NOT NULL,
    LocAr_nome varchar(30)  NOT NULL,
    CONSTRAINT Local_Armazenamento_pk PRIMARY KEY (LocAr_id)
);

-- Table: Lote
CREATE TABLE Lote (
    Lote_id int  NOT NULL AUTO_INCREMENT,
    Lote_validade date  NULL,
    Lote_quantidade int  NOT NULL,
    Prod_cod int  NOT NULL,
    Forn_id int  NOT NULL,
    LocAr_id int  NOT NULL,
    Lote_cod varchar(30)  NOT NULL,
    CONSTRAINT Lote_pk PRIMARY KEY (Lote_id)
);

-- Table: Lote_Entrada
CREATE TABLE Lote_Entrada (
    Lote_id int  NOT NULL,
    Ent_id int  NOT NULL,
    LoteEnt_quantidade int  NOT NULL,
    LoteEnt_valor decimal(8,2)  NOT NULL
);

-- Table: Lote_Saida
CREATE TABLE Lote_Saida (
    Lote_id int  NOT NULL,
    Sai_id int  NOT NULL,
    LoteSai_quantidade int  NOT NULL,
    LoteSai_valor decimal(8,2)  NOT NULL
);

-- Table: Notificacoes
CREATE TABLE Notificacoes (
    Noti_id int  NOT NULL AUTO_INCREMENT,
    Noti_data date  NOT NULL,
    Prod_cod int  NOT NULL,
    Lote_id int  NOT NULL,
    Noti_tipo varchar(30)  NOT NULL,
    CONSTRAINT Notificacoes_pk PRIMARY KEY (Noti_id)
);

-- Table: Produto
CREATE TABLE Produto (
    Prod_cod int  NOT NULL AUTO_INCREMENT,
    Prod_descricao longtext  NOT NULL,
    Prod_imagem longblob  NULL,
    Prod_validade boolean  NULL,
    Prod_status boolean  NULL,
    Prod_estoqueMinimo int  NOT NULL,
    Categoria_id int  NOT NULL,
    UnidadeMedida_id int  NOT NULL,
    Prod_nome varchar(50)  NOT NULL,
    Prod_preco decimal(8,2)  NOT NULL,
    Prod_peso decimal(8,2)  NOT NULL,
    Prod_altura decimal(8,2)  NOT NULL,
    Prod_largura decimal(8,2)  NOT NULL,
    Prod_comprimento decimal(8,2)  NOT NULL,
    Prod_marca varchar(50)  NOT NULL,
    Prod_modelo varchar(50)  NOT NULL,
    CONSTRAINT Produto_pk PRIMARY KEY (Prod_cod)
);

-- Table: Saida
CREATE TABLE Saida (
    Sai_id int  NOT NULL AUTO_INCREMENT,
    Sai_dataCriacao date  NOT NULL,
    Usuario_id int  NOT NULL,
    Sai_valorTot decimal(8,2)  NOT NULL,
    CONSTRAINT Saida_pk PRIMARY KEY (Sai_id)
);

-- Table: Setor
CREATE TABLE Setor (
    Setor_id int  NOT NULL AUTO_INCREMENT,
    Setor_status boolean  NULL,
    Setor_nome varchar(100)  NOT NULL,
    CONSTRAINT Setor_pk PRIMARY KEY (Setor_id)
);

-- Table: Unidade_Medida
CREATE TABLE Unidade_Medida (
    UnidadeMedida_id int  NOT NULL AUTO_INCREMENT,
    UnidadeMedida_nome varchar(50)  NOT NULL,
    CONSTRAINT Unidade_Medida_pk PRIMARY KEY (UnidadeMedida_id)
);

-- Table: Usuario
CREATE TABLE Usuario (
    Usuario_id int  NOT NULL AUTO_INCREMENT,
    Usuario_status boolean  NULL,
    Usuario_dataCriacao date  NULL,
    Cargo_id int  NOT NULL,
    Usuario_email varchar(30)  NOT NULL,
    Usuario_senha varchar(60)  NOT NULL,
    Usuario_nome varchar(60)  NOT NULL,
    CONSTRAINT Usuario_pk PRIMARY KEY (Usuario_id)
);

-- foreign keys
-- Reference: Categoria_Categoria (table: Categoria)
ALTER TABLE Categoria ADD CONSTRAINT Categoria_Categoria FOREIGN KEY Categoria_Categoria (Categoria_pai)
    REFERENCES Categoria (Categoria_id);

-- Reference: FK_Ent_Usuario_id (table: Entrada)
ALTER TABLE Entrada ADD CONSTRAINT FK_Ent_Usuario_id FOREIGN KEY FK_Ent_Usuario_id (Usuario_id)
    REFERENCES Usuario (Usuario_id);

-- Reference: FK_FornProd_Forn_id (table: Fornecedor_Produto)
ALTER TABLE Fornecedor_Produto ADD CONSTRAINT FK_FornProd_Forn_id FOREIGN KEY FK_FornProd_Forn_id (Forn_id)
    REFERENCES Fornecedor (Forn_id);

-- Reference: FK_FornProd_Prod_cod (table: Fornecedor_Produto)
ALTER TABLE Fornecedor_Produto ADD CONSTRAINT FK_FornProd_Prod_cod FOREIGN KEY FK_FornProd_Prod_cod (Prod_cod)
    REFERENCES Produto (Prod_cod);

-- Reference: FK_LocAr_Setor_id (table: Local_Armazenamento)
ALTER TABLE Local_Armazenamento ADD CONSTRAINT FK_LocAr_Setor_id FOREIGN KEY FK_LocAr_Setor_id (Setor_id)
    REFERENCES Setor (Setor_id);

-- Reference: FK_LoteEnt_Ent_id (table: Lote_Entrada)
ALTER TABLE Lote_Entrada ADD CONSTRAINT FK_LoteEnt_Ent_id FOREIGN KEY FK_LoteEnt_Ent_id (Ent_id)
    REFERENCES Entrada (Ent_id);

-- Reference: FK_LoteEnt_Lote_id (table: Lote_Entrada)
ALTER TABLE Lote_Entrada ADD CONSTRAINT FK_LoteEnt_Lote_id FOREIGN KEY FK_LoteEnt_Lote_id (Lote_id)
    REFERENCES Lote (Lote_id);

-- Reference: FK_LoteSaiSai_id (table: Lote_Saida)
ALTER TABLE Lote_Saida ADD CONSTRAINT FK_LoteSaiSai_id FOREIGN KEY FK_LoteSaiSai_id (Sai_id)
    REFERENCES Saida (Sai_id);

-- Reference: FK_LoteSai_Lote_id (table: Lote_Saida)
ALTER TABLE Lote_Saida ADD CONSTRAINT FK_LoteSai_Lote_id FOREIGN KEY FK_LoteSai_Lote_id (Lote_id)
    REFERENCES Lote (Lote_id);

-- Reference: FK_Lote_Forn_id (table: Lote)
ALTER TABLE Lote ADD CONSTRAINT FK_Lote_Forn_id FOREIGN KEY FK_Lote_Forn_id (Forn_id)
    REFERENCES Fornecedor (Forn_id);

-- Reference: FK_Lote_LocAr_id (table: Lote)
ALTER TABLE Lote ADD CONSTRAINT FK_Lote_LocAr_id FOREIGN KEY FK_Lote_LocAr_id (LocAr_id)
    REFERENCES Local_Armazenamento (LocAr_id);

-- Reference: FK_Lote_Prod_cod (table: Lote)
ALTER TABLE Lote ADD CONSTRAINT FK_Lote_Prod_cod FOREIGN KEY FK_Lote_Prod_cod (Prod_cod)
    REFERENCES Produto (Prod_cod);

-- Reference: FK_Noti_Lote_id (table: Notificacoes)
ALTER TABLE Notificacoes ADD CONSTRAINT FK_Noti_Lote_id FOREIGN KEY FK_Noti_Lote_id (Lote_id)
    REFERENCES Lote (Lote_id);

-- Reference: FK_Noti_Prod_cod (table: Notificacoes)
ALTER TABLE Notificacoes ADD CONSTRAINT FK_Noti_Prod_cod FOREIGN KEY FK_Noti_Prod_cod (Prod_cod)
    REFERENCES Produto (Prod_cod);

-- Reference: FK_Prod_Categoria_id (table: Produto)
ALTER TABLE Produto ADD CONSTRAINT FK_Prod_Categoria_id FOREIGN KEY FK_Prod_Categoria_id (Categoria_id)
    REFERENCES Categoria (Categoria_id);

-- Reference: FK_Prod_UnidadeMedida_id (table: Produto)
ALTER TABLE Produto ADD CONSTRAINT FK_Prod_UnidadeMedida_id FOREIGN KEY FK_Prod_UnidadeMedida_id (UnidadeMedida_id)
    REFERENCES Unidade_Medida (UnidadeMedida_id);

-- Reference: FK_Sai_Usuario_id (table: Saida)
ALTER TABLE Saida ADD CONSTRAINT FK_Sai_Usuario_id FOREIGN KEY FK_Sai_Usuario_id (Usuario_id)
    REFERENCES Usuario (Usuario_id);

-- Reference: FK_Usu_Cargo_id (table: Usuario)
ALTER TABLE Usuario ADD CONSTRAINT FK_Usu_Cargo_id FOREIGN KEY FK_Usu_Cargo_id (Cargo_id)
    REFERENCES Cargo (Cargo_id);

-- End of Vertabelo Script


-- Start of Functions
DELIMITER $$

CREATE FUNCTION TotalQuantidadeProduto(Prod_cod INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd INT;
    --
    SELECT SUM(L.Lote_quantidade) INTO qtd
    FROM Lote L
    WHERE L.Prod_cod = Prod_cod;
    --
    RETURN qtd;
END;

CREATE FUNCTION TotalQuantidadeEntrada(Lote_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd INT;
    --
    SELECT SUM(L.LoteEnt_quantidade) INTO qtd
    FROM Lote_Entrada L
    WHERE L.Lote_id = Lote_id;
    --
    RETURN qtd;
END;

CREATE FUNCTION TotalQuantidadeSaida(Lote_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd INT;
    --
    SELECT SUM(L.LoteSai_quantidade) INTO qtd
    FROM Lote_Saida L
    WHERE L.Lote_id = Lote_id;
    --
    RETURN qtd;
END;

CREATE FUNCTION ValorTotalSaida(Lote_id INT)
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE valortot DECIMAL(8,2);
    --
    SELECT SUM(L.LoteSai_quantidade * L.LoteSai_valor) INTO valortot
    FROM Lote_Saida L
    WHERE L.Lote_id = Lote_id;
    --
    RETURN valortot;
END;

CREATE FUNCTION ValorTotalEntrada(Lote_id INT)
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE valortot DECIMAL(8,2);
    --
    SELECT SUM(L.LoteEnt_quantidade * L.LoteEnt_valor) INTO valortot
    FROM Lote_Entrada L
    WHERE L.Lote_id = Lote_id;
    --
    RETURN valortot;
END;

$$ DELIMITER ;
-- End of Functions


-- Start of Triggers
DELIMITER $$

-- Categoria
CREATE TRIGGER status_categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
BEGIN
    SET NEW.Categoria_status = true;
END;

-- Fornecedor
CREATE TRIGGER status_fornecedor
BEFORE INSERT ON Fornecedor
FOR EACH ROW
BEGIN
    SET NEW.Forn_status = true;
END;

-- Local_Armazenamento
CREATE TRIGGER status_local_armazenamento
BEFORE INSERT ON Local_Armazenamento
FOR EACH ROW
BEGIN
    SET NEW.LocAr_status = true;
END;

-- Produto
CREATE TRIGGER status_produto
BEFORE INSERT ON Produto
FOR EACH ROW
BEGIN
    SET NEW.Prod_status = true;
END;

-- Setor
CREATE TRIGGER status_setor
BEFORE INSERT ON Setor
FOR EACH ROW
BEGIN
    SET NEW.Setor_status = true;
END;

-- Usuario
CREATE TRIGGER status_usuario
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    SET
		NEW.Usuario_status = true,
        NEW.Usuario_dataCriacao = CURDATE();
END;

-- Lote
/*CREATE TRIGGER qtd_lote
BEFORE INSERT ON Lote
FOR EACH ROW
BEGIN
	SET NEW.Lote_quantidade = 0;
END;*/
--
CREATE TRIGGER minqtd_lote_insert
AFTER INSERT ON Lote
FOR EACH ROW
BEGIN
	DECLARE qtdmin INT;
	DECLARE qtd INT;
	DECLARE nome VARCHAR(50);
    --
	SELECT P.Prod_estoqueMinimo, P.Prod_nome
	INTO qtdmin, nome
    FROM Produto P
    WHERE P.Prod_cod = NEW.Prod_cod;
    --
    SELECT L.Lote_quantidade INTO qtd
    FROM Lote L
    WHERE L.Lote_id = NEW.Lote_id;
    
	IF (qtd < qtdmin) THEN
		INSERT INTO Notificacoes(
				Noti_data,
				Prod_cod,
				Lote_id,
				Noti_tipo
            )
		VALUES
			(
				CURDATE(),
                NEW.Prod_cod,
                NEW.Lote_id,
                CONCAT(NEW.Prod_cod," tem (", qtd,"), mínimo: (", qtdmin,").")
            );
	END IF;
END;
--

CREATE TRIGGER minqtd_lote_update
AFTER UPDATE ON Lote
FOR EACH ROW
BEGIN
	DECLARE qtdmin INT;
	DECLARE qtd INT;
	DECLARE nome VARCHAR(50);
    --
	SELECT P.Prod_estoqueMinimo, P.Prod_nome
	INTO qtdmin, nome
    FROM Produto P
    WHERE P.Prod_cod = NEW.Prod_cod;
    --
    SELECT L.Lote_quantidade INTO qtd
    FROM Lote L
    WHERE L.Lote_id = NEW.Lote_id;
    
	IF (qtd < qtdmin) THEN
		INSERT INTO Notificacoes(
				Noti_data,
				Prod_cod,
				Lote_id,
				Noti_tipo
            )
		VALUES
			(
				CURDATE(),
                NEW.Prod_cod,
                NEW.Lote_id,
                CONCAT(NEW.Prod_cod," tem (", qtd,"), mínimo: (", qtdmin,").")
            );
	END IF;
END;

-- Lote_Saida
/*CREATE TRIGGER sub_lote
AFTER INSERT ON Lote_Saida
FOR EACH ROW
BEGIN
  UPDATE Lote
  SET Lote_quantidade = Lote_quantidade - NEW.LoteSai_quantidade
  WHERE Lote_id = NEW.Lote_id;
END;*/

-- Lote_Entrada
/*CREATE TRIGGER sum_lote
AFTER INSERT ON Lote_Entrada
FOR EACH ROW
BEGIN
  UPDATE Lote
  SET Lote_quantidade = Lote_quantidade + NEW.LoteEnt_quantidade
  WHERE Lote_id = NEW.Lote_id;
END;*/


$$ DELIMITER ;
-- End of Triggers



-- Start of Stored Procedures
DELIMITER $$

CREATE PROCEDURE Insert_Lote(
	IN Usuario_id INT,
    IN Lote_data JSON,
    IN Tipo VARCHAR(8)
	)
BEGIN
	DECLARE i INT DEFAULT 0;
    DECLARE total INT;
    DECLARE valorTot DECIMAL(8,2) DEFAULT 0.00;
    --
    DECLARE Tipo_id INT DEFAULT 0;
    DECLARE Lote_id INT;
    --
    DECLARE Lote_qtd INT;
    DECLARE Lote_valor DECIMAL(8,2);
    DECLARE Prod_cod INT;
    DECLARE Forn_id INT;
    DECLARE LocAr_id INT;
    DECLARE Lote_cod VARCHAR(30);
    --
    SET total = JSON_LENGTH(Lote_data);
    
    IF (Tipo = "Entrada") THEN
    BEGIN
		INSERT INTO Entrada(Usuario_id, Ent_dataCriacao, Ent_valorTot)
		VALUES
			(Usuario_id, CURDATE(), 0);
		SET Tipo_id = LAST_INSERT_ID();
	END;
	ELSEIF (Tipo = "Saida") THEN
    BEGIN
		INSERT INTO Saida(Usuario_id, Sai_dataCriacao, Sai_valorTot)
		VALUES
			(Usuario_id, CURDATE(), 0);
		SET Tipo_id = LAST_INSERT_ID();
	END;
    END IF;
        
	WHILE i < total DO
		SET Lote_qtd = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].Lote_quantidade')));
		SET Lote_valor = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].Lote_valor')));
		SET Prod_cod = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].Prod_cod')));
		SET Forn_id = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].Forn_id')));
		SET LocAr_id = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].LocAr_id')));
		SET Lote_cod = JSON_UNQUOTE(JSON_EXTRACT(Lote_data, CONCAT('$[', i, '].Lote_cod')));
        --
        
        IF NOT EXISTS (SELECT * FROM Lote L WHERE L.Lote_cod = Lote_cod) THEN
        BEGIN
			INSERT INTO Lote(Lote_quantidade, Prod_cod, Forn_id, LocAr_id, Lote_cod)
            VALUES
				(Lote_qtd, Prod_cod, Forn_id, LocAr_id, Lote_cod);
			SET Lote_id = LAST_INSERT_ID();
		END;
        ELSE
		BEGIN
			SELECT L.Lote_id INTO Lote_id
			FROM Lote L
			WHERE L.Lote_cod = Lote_cod;
            --
			UPDATE Lote L
			SET L.Lote_quantidade = IF (Tipo = "Entrada",
										L.Lote_quantidade + Lote_qtd, 
                                        IF(Tipo = "Saida", L.Lote_quantidade - Lote_qtd, 0)
									)
			WHERE L.Lote_id = Lote_id;
		END;
        END IF;
        
        IF NOT (Tipo_id = 0) THEN
		BEGIN
			IF (Tipo = "Entrada") THEN
				INSERT INTO Lote_Entrada(Lote_id, Ent_id, LoteEnt_quantidade, LoteEnt_valor)
				VALUES
					(Lote_id, Tipo_id, Lote_qtd, Lote_valor);
			ELSEIF (Tipo = "Saida") THEN
				INSERT INTO Lote_Saida(Lote_id, Sai_id, LoteSai_quantidade, LoteSai_valor)
				VALUES
					(Lote_id, Tipo_id, Lote_qtd, Lote_valor);
			END IF;
        END;
        END IF;
		
		SET valorTot = valorTot + (Lote_qtd * Lote_valor);
        SET i = i + 1;
    END WHILE;
    
    IF (Tipo = "Entrada") THEN
		UPDATE Entrada
		SET Ent_valorTot = valorTot
		WHERE Ent_id = Tipo_id;
	ELSEIF (Tipo = "Saida") THEN
		UPDATE Saida
		SET Sai_valorTot = valorTot
		WHERE Sai_id = Tipo_id;
    END IF;
	
END;

CREATE PROCEDURE ProdutosDisp(
	)
BEGIN
	/*
	SELECT
		P.Prod_nome AS 'Produto',
        SUM(L.Lote_quantidade) AS 'Quantidade',
        P.Prod_estoqueMinimo AS 'Mínimo',
        IF(P.Prod_estoqueMinimo > SUM(L.Lote_quantidade), "ABAIXO", "NORMAL") AS 'Alerta'
    FROM Produto P, Lote L
    WHERE P.Prod_cod = L.Prod_cod
    GROUP BY P.Prod_cod;
    */
    
	SELECT
		P.Prod_nome AS 'Produto',
        TotalQuantidadeProduto(P.Prod_cod) AS 'Quantidade',
        P.Prod_estoqueMinimo AS 'Mínimo',
        IF(P.Prod_estoqueMinimo > TotalQuantidadeProduto(P.Prod_cod) , "ABAIXO", "NORMAL") AS 'Alerta'
    FROM Produto P, Lote L
    WHERE P.Prod_cod = L.Prod_cod
    ORDER BY P.Categoria_id, P.Prod_nome;
END;

$$ DELIMITER ;
-- End of Stored Procedures



-- Start of Manual population
--
-- Table: Unidade_Medida
INSERT INTO Unidade_Medida(UnidadeMedida_nome)
VALUES
	("un"),					-- 1
	("caixa"),				-- 2
	("pct"),				-- 3
	("fardo"),				-- 4
	("palete"),				-- 5
	("kg"),					-- 6
	("g"),					-- 7
	("ton"),				-- 8
	("l"),					-- 9
	("ml"),					-- 10
	("m"),					-- 11
	("cm"),					-- 12
	("par"),				-- 13
	("rolo"),				-- 14
	("dz");					-- 15


-- Table: Cargo
INSERT INTO Cargo(Cargo_acesso)
VALUES
	("funcionario"),
    ("gerente"),
    ("administrador");


-- Table: Setor
INSERT INTO Setor(Setor_nome)
VALUES
	("Corredores"),
    ("Armazem"),
    ("Expo");
    

-- Table: Local_Armazenamento
INSERT INTO Local_Armazenamento(Setor_id, LocAr_nome)
VALUES
	(1, "Corredor A"),
    (1, "Corredor B"),
    (1, "Corredor C"),
    (1, "Corredor D"),
    (1, "Corredor E"),
    (2, "Galpão Leste"),
    (2, "Galpão Centro"),
    (2, "Galpão Oeste"),
    (3, "Vitrine Esquerda"),
    (3, "Vitrine Direita");


-- Table: Categoria
INSERT INTO Categoria(Categoria_pai, Categoria_nome)
VALUES
	(NULL, "Hardware"),		--	1
	(NULL, "Periférico"),	--	2
	(1, "CPU"),				--	3
	(1, "GPU"),				--	4
	(1, "Case"),			--	5
	(1, "Heatsink"),		--	6
	(1, "Armazenamento"),	--	7
	(1, "RAM"),				--	8
	(2, "Mouse"),			--	9
	(2, "Teclado"),			--	10
	(2, "Som");				--	11


-- Table: Produto
INSERT INTO Produto
	(
		Prod_descricao,
		Prod_estoqueMinimo,
		Categoria_id,
		UnidadeMedida_id,
		Prod_nome,
		Prod_preco,
		Prod_peso,
		Prod_altura,
		Prod_largura,
		Prod_comprimento,
		Prod_marca,
		Prod_modelo
	)
VALUES
	-- CPU [3] 6
	(
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "Intel i5 12400F",
        600.00,	-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "Intel",-- Marca
        "i5"	-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "Intel i7 12700F",
        1200.00,-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "Intel",-- Marca
        "i7"	-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "Intel i3 12100F",
        400.00,-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "Intel",-- Marca
        "i3"	-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "AMD Ryzen 5 5600",
        800.00,-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "Ryzen 5"	-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "AMD Ryzen 7 5800",
        1400.00,-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "Ryzen 7"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        3,					-- CPU
        12, 				-- cm
        "AMD Ryzen 7 7800",
        2200.00,-- Preco
        250.00,	-- Peso
        10.00,	-- Altura
        10.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "Ryzen 7"-- Modelo
    ),
    -- GPU [4] 6
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "Nvidia RTX 3060",
        1400.00,-- Preco
        500.00,	-- Peso
        25.00,	-- Altura
		40.00,	-- Largura
        10.00,	-- Comprimento
        "Nvidia",	-- Marca
        "RTX 3060"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "Nvidia RTX 4060",
        1600.00,-- Preco
        500.00,	-- Peso
        25.00,	-- Altura
		40.00,	-- Largura
        10.00,	-- Comprimento
        "Nvidia",	-- Marca
        "RTX 4060"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "Nvidia RTX 4080",
        3000.00,-- Preco
        700.00,	-- Peso
        25.00,	-- Altura
		50.00,	-- Largura
        10.00,	-- Comprimento
        "Nvidia",	-- Marca
        "RTX 4080"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "AMD RX 6600",
        1300.00,-- Preco
        500.00,	-- Peso
        25.00,	-- Altura
		40.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "RX 6600"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "AMD RX 7800",
        2700.00,-- Preco
        700.00,	-- Peso
        25.00,	-- Altura
		50.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "RX 7800"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        4,					-- GPU
        12, 				-- cm
        "AMD RX 7600",
        1700.00,-- Preco
        500.00,	-- Peso
        25.00,	-- Altura
		45.00,	-- Largura
        10.00,	-- Comprimento
        "AMD",	-- Marca
        "RX 6600"-- Modelo
    ),
    -- Case [5] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        5,					-- Case
        12, 				-- cm
        "Corsair Obisidian 900D",
        1000.00,-- Preco
        400.00,	-- Peso
        75.00,	-- Altura
		90.00,	-- Largura
        20.00,	-- Comprimento
        "Corsair",	-- Marca
        "Obisidian 900D"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        5,					-- Case
        12, 				-- cm
        "Thermaltake Versa H18",
        800.00,-- Preco
        400.00,	-- Peso
        70.00,	-- Altura
		90.00,	-- Largura
        30.00,	-- Comprimento
        "Thermaltake",	-- Marca
        "Versa H18"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        5,					-- Case
        12, 				-- cm
        "Lian Li Lancool 217",
        750.00,-- Preco
        400.00,	-- Peso
        75.00,	-- Altura
		90.00,	-- Largura
        20.00,	-- Comprimento
        "Lian Li",	-- Marca
        "Lancool 217"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        5,					-- Case
        12, 				-- cm
        "CoolerMaster Q300L V2",
        700.00,-- Preco
        400.00,	-- Peso
        60.00,	-- Altura
		60.00,	-- Largura
        40.00,	-- Comprimento
        "CoolerMaster",	-- Marca
        "Q300L V2"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        5,					-- GPU
        12, 				-- cm
        "Fractal North",
        900.00,-- Preco
        400.00,	-- Peso
        70.00,	-- Altura
		80.00,	-- Largura
        20.00,	-- Comprimento
        "Fractal",	-- Marca
        "North"-- Modelo
    ),
    -- Heatsink [6] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "Thermalright Frozen Prism",
        200.00,-- Preco
        200.00,	-- Peso
        30.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Thermalright",	-- Marca
        "Frozen Prism"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "ID-Cooling SE-214-XT",
        300.00,-- Preco
        300.00,	-- Peso
        30.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "ID-Cooling",	-- Marca
        "SE-214-XT"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "Liquid Freezer III",
        450.00,-- Preco
        400.00,	-- Peso
        20.00,	-- Altura
		10.00,	-- Largura
        50.00,	-- Comprimento
        "Liquid",	-- Marca
        "Freezer III"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "Noctua NH-D15 G2",
        900.00,-- Preco
        400.00,	-- Peso
        40.00,	-- Altura
		30.00,	-- Largura
        30.00,	-- Comprimento
        "Noctua",	-- Marca
        "NH-D15 G2"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "Arctic Freezer 36",
        200.00,-- Preco
        200.00,	-- Peso
        60.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Arctic",	-- Marca
        "Freezer 36"-- Modelo
    ),
    -- Armazenamento [7] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        7,					-- Heatsink
        12, 				-- cm
        "Samsung 980 Pro 1TB",
        1200.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		10.00,	-- Largura
        10.00,	-- Comprimento
        "Samsung",	-- Marca
        "980 Pro 1TB"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        7,					-- Heatsink
        12, 				-- cm
        "Lexar SU850X 1TB",
        1000.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		10.00,	-- Largura
        10.00,	-- Comprimento
        "Lexar",	-- Marca
        "SU850X 1TB"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        7,					-- Heatsink
        12, 				-- cm
        "WD Red 4TB",
        600.00,-- Preco
        400.00,	-- Peso
        5.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "WD",	-- Marca
        "Red 4TB"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        7,					-- Heatsink
        12, 				-- cm
        "Seagate Barracuda 6TB",
        500.00,-- Preco
        400.00,	-- Peso
        5.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Seagate",	-- Marca
        "Barracuda 6TB"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        7,					-- Heatsink
        12, 				-- cm
        "WD Black HDD 2TB",
        800.00,-- Preco
        400.00,	-- Peso
        5.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "WD",	-- Marca
        "Black HDD 2TB"-- Modelo
    ),
    -- RAM [8] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        8,					-- Heatsink
        12, 				-- cm
        "G.Skill Ripjaws S5",
        600.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		5.00,	-- Largura
        10.00,	-- Comprimento
        "G.Skill",	-- Marca
        "Ripjaws S5"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        8,					-- Heatsink
        12, 				-- cm
        "HyperX Predator",
        500.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		5.00,	-- Largura
        10.00,	-- Comprimento
        "HyperX",	-- Marca
        "Predator"-- Modelo
    ),
	(
		"",		-- Descrição
        5,		-- Minimo	
        8,					-- Heatsink
        12, 				-- cm
        "Crucial Pro",
        550.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		5.00,	-- Largura
        10.00,	-- Comprimento
        "Crucial",	-- Marca
        "Pro"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        8,					-- Heatsink
        12, 				-- cm
        "Patriot Viper Extreme 5",
        550.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		5.00,	-- Largura
        10.00,	-- Comprimento
        "Patriot",	-- Marca
        "Viper Xtreme 5"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        6,					-- Heatsink
        12, 				-- cm
        "Corsair Vengeance",
        500.00,-- Preco
        50.00,	-- Peso
        5.00,	-- Altura
		5.00,	-- Largura
        10.00,	-- Comprimento
        "Corsair",	-- Marca
        "Vengeance"-- Modelo
    ),
    -- Mouse [9] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        9,					-- Heatsink
        12, 				-- cm
        "Razer Viper V3 Pro",
        600.00,-- Preco
        200.00,	-- Peso
        20.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Razer",	-- Marca
        "Viper V3 Pro"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        9,					-- Heatsink
        12, 				-- cm
        "Razer DeathAdder V3 Pro",
        500.00,-- Preco
        200.00,	-- Peso
        20.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Razer",	-- Marca
        "DeathAdder V3 Pro"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        9,					-- Heatsink
        12, 				-- cm
        "Logitech G PRO X Superlight 2",
        600.00,-- Preco
        200.00,	-- Peso
        20.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Logitech",	-- Marca
        "G PRO X Superlight 2"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        9,					-- Heatsink
        12, 				-- cm
        "Logitech G203",
        300.00,-- Preco
        200.00,	-- Peso
        20.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Logitech",	-- Marca
        "G203"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        9,					-- Heatsink
        12, 				-- cm
        "Roccat Kone Pro",
        600.00,-- Preco
        200.00,	-- Peso
        20.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Roccat",	-- Marca
        "Kone Pro"-- Modelo
    ),
    -- Teclado [10] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        10,					-- Heatsink
        12, 				-- cm
        "Corsair K100",
        300.00,-- Preco
        200.00,	-- Peso
        10.00,	-- Altura
		60.00,	-- Largura
        20.00,	-- Comprimento
        "Corsair",	-- Marca
        "K100"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        10,					-- Heatsink
        12, 				-- cm
        "Logitech G515",
        400.00,-- Preco
        200.00,	-- Peso
        10.00,	-- Altura
		60.00,	-- Largura
        20.00,	-- Comprimento
        "Logitech",	-- Marca
        "G515"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        10,					-- Heatsink
        12, 				-- cm
        "Wooting 80HE",
        500.00,-- Preco
        200.00,	-- Peso
        10.00,	-- Altura
		60.00,	-- Largura
        20.00,	-- Comprimento
        "Wooting",	-- Marca
        "80HE"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        10,					-- Heatsink
        12, 				-- cm
        "Razer BlackWidow",
        700.00,-- Preco
        200.00,	-- Peso
        10.00,	-- Altura
		60.00,	-- Largura
        20.00,	-- Comprimento
        "Razer",	-- Marca
        "lackWidow"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        10,					-- Heatsink
        12, 				-- cm
        "GMMK 3",
        400.00,-- Preco
        200.00,	-- Peso
        10.00,	-- Altura
		60.00,	-- Largura
        20.00,	-- Comprimento
        "GMMK",	-- Marca
        "3"-- Modelo
    ),
    -- Som [11] 5
    (
		"",		-- Descrição
        5,		-- Minimo	
        11,					-- Heatsink
        12, 				-- cm
        "Edifier G2000 PC",
        200.00,-- Preco
        200.00,	-- Peso
        60.00,	-- Altura
		20.00,	-- Largura
        20.00,	-- Comprimento
        "Edifier",	-- Marca
        "G2000 PC"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        11,					-- Heatsink
        12, 				-- cm
        "Fluance Ai41",
        400.00,-- Preco
        400.00,	-- Peso
        60.00,	-- Altura
		20.00,	-- Largura
        40.00,	-- Comprimento
        "Fluance",	-- Marca
        "Ai41"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        11,					-- Heatsink
        12, 				-- cm
        "Cyber Acoustics CA-2014RB",
        500.00,-- Preco
        200.00,	-- Peso
        40.00,	-- Altura
		20.00,	-- Largura
        40.00,	-- Comprimento
        "Cyber Acoustics",	-- Marca
        "CA-2014RB"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        11,					-- Heatsink
        12, 				-- cm
        "Harman Kardon SoundSticks",
        700.00,-- Preco
        200.00,	-- Peso
        80.00,	-- Altura
		20.00,	-- Largura
        40.00,	-- Comprimento
        "Harman",	-- Marca
        "Kardon SoundSticks"-- Modelo
    ),
    (
		"",		-- Descrição
        5,		-- Minimo	
        11,					-- Heatsink
        12, 				-- cm
        "Audioengine A5+ Classic",
        500.00,-- Preco
        400.00,	-- Peso
        60.00,	-- Altura
		40.00,	-- Largura
        40.00,	-- Comprimento
        "Audioengine",	-- Marca
        "A5+ Classic"-- Modelo
    )
    ;


-- Table: Fornecedor
INSERT INTO Fornecedor(Forn_nome, Forn_razaoSocial, Forn_cnpj)
VALUES
	("MegaComputadores", "MegaComputadores", "111/1111-11"),
	("CompCenter", "CompCenter", "222/2222-22"),
	("PCparts", "PCparts", "333/3333-33");


-- Table: Fornecedor_Produto
INSERT INTO Fornecedor_Produto(Forn_id, Prod_cod)
VALUES
	-- MegaComputadores [1]
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	-- CompCenter [2]
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(2, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 15),
	(2, 15),
	(2, 16),
	(2, 17),
	(2, 18),
	(2, 19),
	(2, 20),
	(2, 21),
	(2, 22),
	(2, 23),
	(2, 24),
	(2, 25),
	(2, 25),
	(2, 26),
	(2, 27),
	(2, 28),
	(2, 29),
	(2, 30),
	(2, 31),
	(2, 32),
	(2, 33),
	(2, 34),
	(2, 35),
	(2, 35),
	(2, 36),
	(2, 37),
	(2, 38),
	(2, 39),
	(2, 40),
	(2, 41),
	(2, 42),
	(2, 43),
	(2, 44),
	(2, 45),
	(2, 45),
	(2, 46),
	(2, 47),
	-- PCparts [3]
    (3, 7),
	(3, 8),
	(3, 9),
	(3, 10),
	(3, 11),
	(3, 12),
	(3, 13),
	(3, 14),
	(3, 15),
	(3, 15),
	(3, 16),
	(3, 17),
	(3, 18),
	(3, 19),
	(3, 20),
	(3, 21),
	(3, 22),
	(3, 23),
	(3, 24),
	(3, 25);


-- Table: Usuario
INSERT INTO Usuario(Cargo_id, Usuario_email, Usuario_senha, Usuario_nome)
VALUES
	("1", "adm@fatec.com", "0", "ADM"),
	("2", "geronimo@fatec.com", "0", "Gerenice"),
	("2", "geremias@fatec.com", "0", "Geremias"),
	("3", "alice@fatec.com", "0", "Alice"),
	("3", "bruno@fatec.com", "0", "Bruno"),
	("3", "carla@fatec.com", "0", "Carla"),
	("3", "douglas@fatec.com", "0", "Douglas");


-- Table: Fornecedor_Produto
INSERT INTO Usuario(Cargo_id, Usuario_email, Usuario_senha, Usuario_nome)
VALUES
	("1", "adm@fatec.com", "0", "ADM"),				-- 1
	("2", "geronimo@fatec.com", "0", "Gerenice"),	-- 2
	("2", "geremias@fatec.com", "0", "Geremias"),	-- 3
	("3", "alice@fatec.com", "0", "Alice"),			-- 4
	("3", "bruno@fatec.com", "0", "Bruno"),			-- 5
	("3", "carla@fatec.com", "0", "Carla"),			-- 6
	("3", "douglas@fatec.com", "0", "Douglas");		-- 7


-- Table: Lote + Lote_Ent + Entrada
/*
	Estrutura dos dados:
    
	U_id,
	'[
		{
			"Lote_quantidade": , 
			"Lote_valor": , 
			"Prod_cod": , 
			"Forn_id": , 
			"LocAr_id": , 
			"Lote_cod": ""
		}
	]',
    "EntradaSaida"
*/
CALL Insert_Lote(
	4,
    '
    [
		{
			"Lote_quantidade": 7, 
			"Lote_valor": 300, 
			"Prod_cod": 4, 
			"Forn_id": 1, 
			"LocAr_id": 1, 
			"Lote_cod": "AMD_TESTE_01"
		},
		{
			"Lote_quantidade": 3, 
			"Lote_valor": 300, 
			"Prod_cod": 2, 
			"Forn_id": 1, 
			"LocAr_id": 1, 
			"Lote_cod": "INTEL_TESTE_01"
		}
    ]
    ',
    "Entrada"
)












-- End of file.