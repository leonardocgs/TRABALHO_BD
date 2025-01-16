CREATE TABLE tbl_usuario (
    id_usuario SERIAL PRIMARY KEY,
    nm_usuario VARCHAR(200) NOT NULL,
    cpf_usuario CHAR(11) NOT NULL UNIQUE,
    email_usuario VARCHAR(200) NOT NULL UNIQUE,
    senha_usuario VARCHAR(255) NOT NULL,
    dt_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tbl_empresa (
    id_empresa SERIAL PRIMARY KEY,
    nm_fantasia_empresa VARCHAR(60) NOT NULL,
    razao_social_empresa VARCHAR(100) NOT NULL,
    cnpj_empresa CHAR(14) NOT NULL UNIQUE,
    rua_empresa VARCHAR(100) NOT NULL,
    numero_empresa VARCHAR(10) NOT NULL,
    bairro_empresa VARCHAR(50) NOT NULL,
    cidade_empresa VARCHAR(50) NOT NULL,
    estado_empresa CHAR(2) NOT NULL,
    cep_empresa CHAR(8) NOT NULL,
    dt_cadastro_empresa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_estado_empresa CHECK (estado_empresa ~ '^[A-Z]{2}$')
);

CREATE TABLE tbl_senioridade (
    id_senioridade SERIAL PRIMARY KEY,
    ds_senioridade VARCHAR(20) NOT NULL
);

CREATE TABLE tbl_cargo_especialidade (
    id_cargo_especialidade SERIAL PRIMARY KEY,
    ds_cargo_especialidade VARCHAR(60) NOT NULL
);

CREATE TABLE tbl_vinculo_usuario_empresa (
    id_vinculo SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_empresa INTEGER NOT NULL,
    id_cargo_especialidade INTEGER NOT NULL,
    id_senioridade INTEGER NOT NULL,
    salario_vinculo DECIMAL(10,2) NOT NULL,
    cod_regime_contratacao INTEGER NOT NULL,
    cod_modelo_trabalho INTEGER NOT NULL,
    carga_horaria_vinculo INTEGER NOT NULL,
    cod_turno INTEGER NOT NULL,
    dt_inicio_vinculo TIMESTAMP NOT NULL,
    emprego_atual BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario (id_usuario),
    FOREIGN KEY (id_empresa) REFERENCES tbl_empresa (id_empresa),
    FOREIGN KEY (id_cargo_especialidade) REFERENCES tbl_cargo_especialidade (id_cargo_especialidade),
    FOREIGN KEY (id_senioridade) REFERENCES tbl_senioridade (id_senioridade),
    CONSTRAINT chk_regime_contratacao CHECK (cod_regime_contratacao IN (1, 2)),
    CONSTRAINT chk_modelo_trabalho CHECK (cod_modelo_trabalho IN (1, 2, 3)),
    CONSTRAINT chk_turno CHECK (cod_turno IN (1, 2, 3)),
    CONSTRAINT chk_carga_horaria CHECK (carga_horaria_vinculo > 0 AND carga_horaria_vinculo <= 44)
);

CREATE TABLE tbl_avaliacao (
    id_avaliacao SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_empresa INTEGER NOT NULL,
    cargo_mais_requisitado INTEGER,
    faz_hora_extra BOOLEAN NOT NULL,
    hora_extra_remunerada BOOLEAN,
    tempo_primeira_promocao INTEGER,
    percent_promocao DECIMAL(5,2),
    tempo_primeiro_aumento INTEGER,
    percent_aumento DECIMAL(5,2),
    cod_problema_pj INTEGER,
    cod_assedio INTEGER,
    depoimento_geral TEXT NOT NULL,
    nota_geral INTEGER NOT NULL,
    dt_avaliacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES tbl_usuario (id_usuario),
    FOREIGN KEY (id_empresa) REFERENCES tbl_empresa (id_empresa),
    FOREIGN KEY (cargo_mais_requisitado) REFERENCES tbl_cargo_especialidade (id_cargo_especialidade),
    CONSTRAINT chk_nota CHECK (nota_geral BETWEEN 1 AND 5),
    CONSTRAINT chk_problema_pj CHECK (cod_problema_pj IN (1, 2, 3, 4)),
    CONSTRAINT chk_assedio CHECK (cod_assedio IN (1, 2)),
    CONSTRAINT chk_hora_extra_remunerada CHECK (
        (faz_hora_extra = false AND hora_extra_remunerada IS NULL) OR
        (faz_hora_extra = true AND hora_extra_remunerada IS NOT NULL)
    )
);

CREATE TABLE tbl_beneficio (
    id_beneficio SERIAL PRIMARY KEY,
    ds_beneficio VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE tbl_avaliacao_beneficio (
    id_avaliacao_beneficio SERIAL PRIMARY KEY,
    id_avaliacao INTEGER NOT NULL,
    id_beneficio INTEGER NOT NULL,
    FOREIGN KEY (id_avaliacao) REFERENCES tbl_avaliacao (id_avaliacao),
    FOREIGN KEY (id_beneficio) REFERENCES tbl_beneficio (id_beneficio),
    UNIQUE (id_avaliacao, id_beneficio)
);

CREATE OR REPLACE PROCEDURE sp_inserir_usuario(
    p_nm_usuario     VARCHAR(200),
    p_cpf_usuario    CHAR(11),
    p_email_usuario  VARCHAR(200),
    p_senha_usuario  VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN


    INSERT INTO tbl_usuario (
        nm_usuario,
        cpf_usuario,
        email_usuario,
        senha_usuario
    ) VALUES (
        p_nm_usuario,
        p_cpf_usuario,
        p_email_usuario,
        p_senha_usuario
    );
END;
$$;

CREATE OR REPLACE PROCEDURE sp_inserir_empresa(
    p_nm_fantasia    VARCHAR(60),
    p_razao_social   VARCHAR(100),
    p_cnpj_empresa   CHAR(14),
    p_rua_empresa    VARCHAR(100),
    p_numero_empresa VARCHAR(10),
    p_bairro_empresa VARCHAR(50),
    p_cidade_empresa VARCHAR(50),
    p_estado_empresa CHAR(2),
    p_cep_empresa    CHAR(8)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tbl_empresa (
        nm_fantasia_empresa,
        razao_social_empresa,
        cnpj_empresa,
        rua_empresa,
        numero_empresa,
        bairro_empresa,
        cidade_empresa,
        estado_empresa,
        cep_empresa
    ) VALUES (
        p_nm_fantasia,
        p_razao_social,
        p_cnpj_empresa,
        p_rua_empresa,
        p_numero_empresa,
        p_bairro_empresa,
        p_cidade_empresa,
        p_estado_empresa,
        p_cep_empresa
    );
END;
$$;

CREATE MATERIALIZED VIEW mv_usuario_empresa_atual AS
SELECT u.id_usuario,
       u.nm_usuario,
       e.id_empresa,
       e.nm_fantasia_empresa,
       v.dt_inicio_vinculo,
       v.salario_vinculo
FROM tbl_vinculo_usuario_empresa v
JOIN tbl_usuario u ON v.id_usuario = u.id_usuario
JOIN tbl_empresa e ON v.id_empresa = e.id_empresa
WHERE v.emprego_atual = TRUE;

CREATE MATERIALIZED VIEW mv_empresa_resumo_avaliacao AS  
SELECT a.id_avaliacao,  
       a.id_empresa,  
       u.id_usuario,  
       u.nm_usuario usuario,  
       e.nm_fantasia_empresa,  
       a.depoimento_geral,  
       a.nota_geral,  
       a.dt_avaliacao  
FROM tbl_avaliacao a  
JOIN tbl_empresa e ON a.id_empresa = e.id_empresa  
JOIN tbl_usuario u on u.id_usuario = a.id_usuario;

CREATE OR REPLACE VIEW vw_media_salario_cargo_senioridade AS
SELECT 
    ce.ds_cargo_especialidade AS cargo,
    s.ds_senioridade          AS senioridade,
    ROUND(AVG(vue.salario_vinculo)::numeric, 2) AS media_salarial
FROM tbl_vinculo_usuario_empresa vue
JOIN tbl_cargo_especialidade ce ON vue.id_cargo_especialidade = ce.id_cargo_especialidade
JOIN tbl_senioridade s         ON vue.id_senioridade = s.id_senioridade
GROUP BY ce.ds_cargo_especialidade, s.ds_senioridade;

CREATE OR REPLACE VIEW vw_problemas_pj AS
SELECT
    CASE a.cod_problema_pj
      WHEN 1 THEN 'Irregularidades contratuais'
      WHEN 2 THEN 'CLT mascarado de PJ'
      WHEN 3 THEN 'Não pagamento de férias ou 13°'
      WHEN 4 THEN 'Falta de garantia de direitos trabalhistas'
      ELSE 'Nenhum/Indefinido'
    END AS problema_pj,
    COUNT(*) AS qtd
FROM tbl_avaliacao a
WHERE a.cod_problema_pj IS NOT NULL
GROUP BY a.cod_problema_pj
ORDER BY qtd DESC;

CREATE OR REPLACE VIEW vw_distribuicao_clt_pj AS
SELECT 
    e.nm_fantasia_empresa AS empresa,
    SUM(CASE WHEN vue.cod_regime_contratacao = 1 THEN 1 ELSE 0 END) AS total_clt,
    SUM(CASE WHEN vue.cod_regime_contratacao = 2 THEN 1 ELSE 0 END) AS total_pj
FROM tbl_vinculo_usuario_empresa vue
JOIN tbl_empresa e ON vue.id_empresa = e.id_empresa
GROUP BY e.nm_fantasia_empresa
ORDER BY empresa;

CREATE OR REPLACE VIEW vw_tempo_medio_promocao_senioridade AS
SELECT
    s.ds_senioridade AS senioridade,
    ROUND(AVG(a.tempo_primeira_promocao)::numeric, 2) AS media_meses_promocao
FROM tbl_avaliacao a
JOIN tbl_usuario u ON a.id_usuario = u.id_usuario
JOIN tbl_vinculo_usuario_empresa vue 
  ON a.id_usuario = vue.id_usuario
 AND a.id_empresa = vue.id_empresa
JOIN tbl_senioridade s ON vue.id_senioridade = s.id_senioridade
WHERE a.tempo_primeira_promocao IS NOT NULL
GROUP BY s.ds_senioridade
ORDER BY media_meses_promocao;

CREATE OR REPLACE VIEW vw_empresas_clt_mascarado_pj AS
SELECT 
    e.nm_fantasia_empresa AS empresa,
    COUNT(*) AS qtd_clt_mascarado
FROM tbl_avaliacao a
JOIN tbl_empresa e ON a.id_empresa = e.id_empresa
WHERE a.cod_problema_pj = 2
GROUP BY e.nm_fantasia_empresa
ORDER BY qtd_clt_mascarado DESC;

CREATE OR REPLACE VIEW vw_empresas_satisfacao_alta AS
SELECT 
    e.nm_fantasia_empresa AS empresa,
    ROUND(AVG(a.nota_geral)::numeric, 2) AS media_nota
FROM tbl_avaliacao a
JOIN tbl_empresa e ON a.id_empresa = e.id_empresa
GROUP BY e.nm_fantasia_empresa
HAVING AVG(a.nota_geral) > 4
ORDER BY media_nota DESC;

CREATE OR REPLACE VIEW vw_tempo_primeiro_aumento_dev AS
SELECT
    s.ds_senioridade AS senioridade,
    ROUND(AVG(a.tempo_primeiro_aumento)::numeric, 2) AS media_meses_aumento
FROM tbl_avaliacao a
JOIN tbl_vinculo_usuario_empresa vue 
  ON a.id_usuario = vue.id_usuario 
 AND a.id_empresa = vue.id_empresa
JOIN tbl_cargo_especialidade ce ON vue.id_cargo_especialidade = ce.id_cargo_especialidade
JOIN tbl_senioridade s         ON vue.id_senioridade = s.id_senioridade
WHERE ce.ds_cargo_especialidade ILIKE '%desenvolvedor%'
  AND s.ds_senioridade IN ('Júnior', 'Pleno', 'Sênior')
  AND a.tempo_primeiro_aumento IS NOT NULL
GROUP BY s.ds_senioridade
ORDER BY s.ds_senioridade;

CREATE OR REPLACE VIEW vw_empresas_maior_retencao AS
SELECT 
    e.nm_fantasia_empresa AS empresa,
    COUNT(*) AS total_emprego_atual
FROM tbl_vinculo_usuario_empresa vue
JOIN tbl_empresa e ON vue.id_empresa = e.id_empresa
WHERE vue.emprego_atual = TRUE
GROUP BY e.nm_fantasia_empresa
ORDER BY total_emprego_atual DESC;
