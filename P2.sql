DROP DATABASE p2;
CREATE DATABASE p2;
USE p2;

CREATE TABLE Setor (
	Setor_id INT AUTO_INCREMENT PRIMARY KEY,
    Setor_status BOOLEAN,
	Setor_nome VARCHAR(100)
);
CREATE TABLE Local_Armazenamento (
	LocAr_id INT AUTO_INCREMENT PRIMARY KEY,
    locAr_status BOOLEAN,
    Setor_id INT,
    CONSTRAINT FK_LocAr_Setor_id FOREIGN KEY (Setor_id)
    REFERENCES Setor(Setor_id),
    LocAr_nome VARCHAR(30)
);

--
CREATE TABLE Cargo (
	Cargo_id INT AUTO_INCREMENT PRIMARY KEY,
    Cargo_acesso VARCHAR(100)
);
CREATE TABLE Usuario (
	Usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    Usuario_status BOOLEAN,
    Usuario_dataCriacao DATE,
    Cargo_id INT,
    CONSTRAINT FK_Usu_Cargo_id FOREIGN KEY (Cargo_id)
    REFERENCES Cargo(Cargo_id),
    Usuario_email VARCHAR(30),
    Usuario_senha VARCHAR(60),
    Usuario_nome VARCHAR(60)
);
CREATE TABLE Saida (
	Sai_id INT AUTO_INCREMENT PRIMARY KEY,
    Sai_dataCriacao DATE,
    Usuario_id INT,
    CONSTRAINT FK_Sai_Usuario_id FOREIGN KEY (Usuario_id)
    REFERENCES Usuario(Usuario_id),
    Sai_valorTot DECIMAL(8, 2)
);
CREATE TABLE Entrada (
	Ent_id INT AUTO_INCREMENT PRIMARY KEY,
    Ent_dataCriacao DATE,
    Usuario_id INT,
    CONSTRAINT FK_Ent_Usuario_id FOREIGN KEY (Usuario_id)
    REFERENCES Usuario(Usuario_id),
    Ent_valorTot DECIMAL(8, 2)
);

-- 
CREATE TABLE Unidade_Medida (
	UnidadeMedida_id INT PRIMARY KEY AUTO_INCREMENT,
    UnidadeMedida_nome VARCHAR(50)
);
CREATE TABLE Notificacoes (
	Not_id INT PRIMARY KEY AUTO_INCREMENT,
    Not_data DATE,
    Prod_cod INT,
    Lote_id INT,
    Not_tipo VARCHAR(30)
);
CREATE TABLE Categoria (
	Categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    Categoria_status BOOLEAN,
    Categoria_pai INT,
    Categoria_nome VARCHAR(50)
);
CREATE TABLE Produto (
	Prod_cod INT AUTO_INCREMENT PRIMARY KEY,
    Prod_descricao LONGTEXT,
    Prod_imagem LONGBLOB,
    Prod_validade BOOLEAN,
    Prod_status BOOLEAN,
    Prod_estoqueMinimo INT,
    Categoria_id INT,
    CONSTRAINT FK_Prod_Categoria_id FOREIGN KEY (Categoria_id)
    REFERENCES Categoria(Categoria_id),
    UnidadeMedida_id INT,
    CONSTRAINT FK_Prod_UnidadeMedida_id FOREIGN KEY (UnidadeMedida_id)
    REFERENCES Unidade_Medida(UnidadeMedida_id),
    Prod_nome VARCHAR(50),
    Prod_preco DECIMAL(8,2),
    Prod_custo DECIMAL(8,2),
    Prod_peso DECIMAL(8,2),
    Prod_altura DECIMAL(8,2),
    Prod_largura DECIMAL(8,2),
    Prod_comprimento DECIMAL(8,2),
    Prod_marca VARCHAR(50),
    Prod_modelo VARCHAR(50)
);

--
CREATE TABLE Fornecedor (
	Forn_id INT AUTO_INCREMENT PRIMARY KEY,
    Forn_status BOOLEAN,
    Forn_nome VARCHAR(50),
    Forn_razaoSocial VARCHAR(30),
    Forn_cnpj VARCHAR(19)
);
CREATE TABLE Fornecedor_Produto (
	FornProd_id INT AUTO_INCREMENT PRIMARY KEY,
    Forn_id INT,
    CONSTRAINT FK_FornProd_Forn_id FOREIGN KEY (Forn_id)
    REFERENCES Fornecedor(Forn_id),
    Prod_cod INT,
    CONSTRAINT FK_FornProd_Prod_cod FOREIGN KEY (Prod_cod)
    REFERENCES Produto(Prod_cod)
);

--
CREATE TABLE Lote (
	Lote_id INT AUTO_INCREMENT PRIMARY KEY,
	Lote_validade DATE,
    Lote_quantidade INT,
    Prod_cod INT,
    CONSTRAINT FK_Lote_Prod_cod FOREIGN KEY (Prod_cod)
    REFERENCES Produto(Prod_cod),
    Lote_cod VARCHAR(30)
);
CREATE TABLE Lote_Entrada (
    Lote_id INT,
    CONSTRAINT FK_LoteEnt_Lote_id FOREIGN KEY (Lote_id)
    REFERENCES Lote(Lote_id),
    Ent_id INT,
    CONSTRAINT FK_LoteEnt_Ent_id FOREIGN KEY (Ent_id)
    REFERENCES Entrada(Ent_id),
    LoteEnt_quantidade INT,
	LoteEnt_valor DECIMAL(8,2)
);
CREATE TABLE Lote_Saida (
    Lote_id INT,
    CONSTRAINT FK_LoteSai_Lote_id FOREIGN KEY (Lote_id)
    REFERENCES Lote(Lote_id),
    Sai_id INT,
    CONSTRAINT FK_LoteSaiSai_id FOREIGN KEY (Sai_id)
    REFERENCES Saida(Sai_id),
    LoteSai_quantidade INT,
	LoteSai_valor DECIMAL(8,2)
);