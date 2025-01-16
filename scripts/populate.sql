-- 3.1. SENIORIDADES
INSERT INTO tbl_senioridade (ds_senioridade) VALUES
('Júnior'),     -- id_senioridade = 1
('Pleno'),      -- id_senioridade = 2
('Sênior');     -- id_senioridade = 3

-- 3.2. CARGOS
INSERT INTO tbl_cargo_especialidade (ds_cargo_especialidade) VALUES
('Desenvolvedor'),       -- id_cargo_especialidade = 1
('Analista'),            -- 2
('Tech Lead'),           -- 3
('QA'),                  -- 4
('DevOps'),              -- 5
('Arquiteto de Software'); -- 6

-- 3.3. BENEFÍCIOS
INSERT INTO tbl_beneficio (ds_beneficio) VALUES
('Vale-Refeição'),       -- id_beneficio = 1
('Vale-Transporte'),     -- 2
('Plano de Saúde'),      -- 3
('Seguro de Vida'),      -- 4
('Auxílio Creche'),      -- 5
('Participação nos Lucros e Resultados (PLR)'),  -- 6
('Treinamento Pago'),    -- 7
('Academia'),            -- 8
('Cartão Alimentação');  -- 9

------------------------------------------------------------------------------
-- 4. INSERÇÃO DE USUÁRIOS (15 USUÁRIOS)
------------------------------------------------------------------------------

INSERT INTO tbl_usuario (nm_usuario, cpf_usuario, email_usuario, senha_usuario) VALUES
('Ana Silva',        '11111111111', 'ana.silva@example.com',        'senha111'),
('Bruno Souza',      '22222222222', 'bruno.souza@example.com',      'senha222'),
('Carla Mendes',     '33333333333', 'carla.mendes@example.com',     'senha333'),
('Daniel Oliveira',  '44444444444', 'daniel.oliveira@example.com',  'senha444'),
('Eva Pereira',      '55555555555', 'eva.pereira@example.com',      'senha555'),
('Felipe Costa',     '66666666666', 'felipe.costa@example.com',     'senha666'),
('Gabriela Lima',    '77777777777', 'gabriela.lima@example.com',    'senha777'),
('Henrique Rocha',   '88888888888', 'henrique.rocha@example.com',   'senha888'),
('Isabela Martins',  '99999999999', 'isabela.martins@example.com',  'senha999'),
('João Paulo',       '11122233344', 'joao.paulo@example.com',       'senhaabc'),
('Karina Alves',     '22233344455', 'karina.alves@example.com',     'senhaabcd'),
('Leonardo Dias',    '33344455566', 'leonardo.dias@example.com',    'senha1234'),
('Mariana Barbosa',  '44455566677', 'mariana.barbosa@example.com',  'senha5678'),
('Nathan Ferreira',  '55566677788', 'nathan.ferreira@example.com',  'senha9876'),
('Olivia Gomes',     '66677788899', 'olivia.gomes@example.com',     'senha6543');

------------------------------------------------------------------------------
-- 5. INSERÇÃO DE EMPRESAS (5 EMPRESAS)
------------------------------------------------------------------------------

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
) VALUES
('Tech Innovators', 'Tech Innovators Ltda.',     '10000000000001', 'Av. Paulista',  '1000', 'Bela Vista', 'São Paulo',    'SP', '01311000'),
('Data Solutions',  'Data Solutions S.A.',       '20000000000002', 'Rua das Flores','500',  'Centro',     'Rio de Janeiro','RJ', '20090000'),
('Cloud Services',  'Cloud Services ME',         '30000000000003', 'Av. Rio Branco','200',  'Centro',     'Rio de Janeiro','RJ', '20090001'),
('GreenTech',       'GreenTech Ltda.',           '40000000000004', 'Rua Acácias',   '750',  'Botafogo',   'Rio de Janeiro','RJ', '22270000'),
('Alpha Systems',   'Alpha Systems S.A.',        '50000000000005', 'Av. Atlântica', '3000', 'Copacabana', 'Rio de Janeiro','RJ', '22021000');

------------------------------------------------------------------------------
-- 6. INSERÇÃO DE VÍNCULOS (2 POR USUÁRIO = 30 INSERÇÕES)
------------------------------------------------------------------------------

-- Regras:
--  - cod_regime_contratacao: (1=CLT, 2=PJ)
--  - cod_modelo_trabalho: (1=Presencial, 2=Híbrido, 3=Remoto)
--  - cod_turno: (1=Diurno, 2=Noturno, 3=Outro)
--  - Apenas 1 vínculo atual (emprego_atual=TRUE) por usuário

-- Vincularemos cada usuário a 2 empresas diferentes.

INSERT INTO tbl_vinculo_usuario_empresa (
    id_usuario,
    id_empresa,
    id_cargo_especialidade,
    id_senioridade,
    salario_vinculo,
    cod_regime_contratacao,
    cod_modelo_trabalho,
    carga_horaria_vinculo,
    cod_turno,
    dt_inicio_vinculo,
    emprego_atual
) VALUES

-- Usuario 1 -> Empresa 1 (atual), Empresa 2 (passado)
(1, 1, 1, 1, 3000.00, 1, 1, 40, 1, '2022-01-10', TRUE),
(1, 2, 2, 1, 3100.00, 1, 2, 40, 1, '2021-01-10', FALSE),

-- Usuario 2 -> Empresa 1 (passado), Empresa 2 (atual)
(2, 1, 3, 2, 4000.00, 2, 2, 40, 2, '2020-05-01', FALSE),
(2, 2, 1, 2, 4200.00, 2, 1, 40, 2, '2021-05-01', TRUE),

-- Usuario 3 -> Empresa 2 (passado), Empresa 3 (atual)
(3, 2, 2, 3, 4500.00, 1, 3, 40, 1, '2020-03-15', FALSE),
(3, 3, 3, 3, 4600.00, 1, 2, 40, 1, '2021-03-15', TRUE),

-- Usuario 4 -> Empresa 3 (passado), Empresa 4 (atual)
(4, 3, 1, 1, 3200.00, 2, 1, 40, 2, '2022-02-20', FALSE),
(4, 4, 2, 1, 3300.00, 2, 3, 40, 2, '2023-02-20', TRUE),

-- Usuario 5 -> Empresa 4 (passado), Empresa 5 (atual)
(5, 4, 3, 2, 3800.00, 1, 2, 40, 1, '2022-01-01', FALSE),
(5, 5, 1, 2, 3900.00, 1, 1, 40, 1, '2023-01-01', TRUE),

-- Usuario 6 -> Empresa 1 (atual), Empresa 3 (passado)
(6, 1, 2, 3, 5000.00, 2, 1, 40, 2, '2021-07-01', TRUE),
(6, 3, 3, 3, 5200.00, 2, 3, 40, 2, '2020-07-01', FALSE),

-- Usuario 7 -> Empresa 2 (atual), Empresa 4 (passado)
(7, 2, 1, 1, 2800.00, 1, 2, 40, 1, '2023-03-10', TRUE),
(7, 4, 5, 1, 2900.00, 1, 1, 40, 1, '2022-03-10', FALSE),

-- Usuario 8 -> Empresa 3 (atual), Empresa 5 (passado)
(8, 3, 6, 2, 6000.00, 2, 3, 40, 2, '2023-06-05', TRUE),
(8, 5, 4, 2, 6100.00, 2, 2, 40, 2, '2022-06-05', FALSE),

-- Usuario 9 -> Empresa 1 (passado), Empresa 4 (atual)
(9, 1, 1, 3, 7000.00, 1, 2, 40, 1, '2021-08-12', FALSE),
(9, 4, 3, 3, 7300.00, 1, 1, 40, 1, '2022-08-12', TRUE),

-- Usuario 10 -> Empresa 2 (passado), Empresa 5 (atual)
(10, 2, 2, 1, 3500.00, 2, 2, 40, 2, '2020-10-01', FALSE),
(10, 5, 6, 1, 3800.00, 2, 1, 40, 2, '2021-10-01', TRUE),

-- Usuario 11 -> Empresa 3 (atual), Empresa 4 (passado)
(11, 3, 1, 2, 4100.00, 1, 3, 40, 1, '2022-04-01', TRUE),
(11, 4, 2, 2, 3900.00, 1, 2, 40, 1, '2021-04-01', FALSE),

-- Usuario 12 -> Empresa 1 (atual), Empresa 2 (passado)
(12, 1, 3, 3, 5500.00, 2, 1, 40, 2, '2022-09-10', TRUE),
(12, 2, 4, 3, 5600.00, 2, 2, 40, 2, '2021-09-10', FALSE),

-- Usuario 13 -> Empresa 4 (atual), Empresa 5 (passado)
(13, 4, 1, 1, 3200.00, 1, 3, 40, 1, '2023-11-01', TRUE),
(13, 5, 2, 1, 3300.00, 1, 1, 40, 1, '2022-11-01', FALSE),

-- Usuario 14 -> Empresa 3 (atual), Empresa 5 (passado)
(14, 3, 3, 2, 4700.00, 2, 3, 40, 2, '2023-02-15', TRUE),
(14, 5, 4, 2, 4800.00, 2, 2, 40, 2, '2022-02-15', FALSE),

-- Usuario 15 -> Empresa 1 (atual), Empresa 2 (passado)
(15, 1, 6, 3, 7500.00, 1, 1, 40, 1, '2023-12-20', TRUE),
(15, 2, 5, 3, 7600.00, 1, 2, 40, 1, '2022-12-20', FALSE);

------------------------------------------------------------------------------
-- 7. INSERÇÃO DE AVALIAÇÕES (2 POR USUÁRIO = 30 INSERÇÕES)
--
-- Regras:
--  - Cada avaliação deve corresponder a um vínculo existente entre (id_usuario, id_empresa).
--  - Se faz_hora_extra = FALSE => hora_extra_remunerada = NULL
--  - Se faz_hora_extra = TRUE => hora_extra_remunerada = TRUE ou FALSE (mas não NULL)
------------------------------------------------------------------------------

INSERT INTO tbl_avaliacao (
    id_usuario,
    id_empresa,
    cargo_mais_requisitado,
    faz_hora_extra,
    hora_extra_remunerada,
    tempo_primeira_promocao,
    percent_promocao,
    tempo_primeiro_aumento,
    percent_aumento,
    cod_problema_pj,
    cod_assedio,
    depoimento_geral,
    nota_geral
) VALUES

-- Usuario 1, Empresa 1 (FAZ hora extra)
(1, 1, 1, TRUE, TRUE, 12, 10.00, 6, 5.00, NULL, NULL, 'Ambiente excelente, grande aprendizado.', 5),
-- Usuario 1, Empresa 2 (NÃO FAZ hora extra)
(1, 2, 2, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Projeto interessante, mas poderia melhorar.', 4),

-- Usuario 2, Empresa 1
(2, 1, 3, FALSE, NULL, NULL, NULL, NULL, NULL, 2, 1, 'Tive problemas com PJ, mas liderança era boa.', 3),
-- Usuario 2, Empresa 2
(2, 2, 1, TRUE, TRUE, 8, 12.00, 4, 6.00, NULL, NULL, 'Boas oportunidades de crescimento.', 4),

-- Usuario 3, Empresa 2
(3, 2, 2, TRUE, TRUE, 10, 10.00, 8, 8.00, NULL, 2, 'Trabalho desafiador, mas horas extras existem.', 4),
-- Usuario 3, Empresa 3
(3, 3, 3, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ambiente equilibrado e suporte adequado.', 5),

-- Usuario 4, Empresa 3
(4, 3, 1, TRUE, FALSE, 18, 15.00, 12, 10.00, NULL, NULL, 'Fazemos hora extra, mas nem sempre é paga.', 3),
-- Usuario 4, Empresa 4
(4, 4, 2, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Empresa em crescimento, equipe unida.', 4),

-- Usuario 5, Empresa 4
(5, 4, 3, TRUE, TRUE, 6, 10.00, 3, 5.00, NULL, NULL, 'Horário flexível e política de benefícios boa.', 5),
-- Usuario 5, Empresa 5
(5, 5, 1, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Remuneração poderia ser melhor, mas ambiente ótimo.', 4),

-- Usuario 6, Empresa 1
(6, 1, 2, TRUE, TRUE, 12, 12.00, 6, 6.00, NULL, NULL, 'Empresa inovadora, mas gestão de pessoas precisa evoluir.', 4),
-- Usuario 6, Empresa 3
(6, 3, 3, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Projetos interessantes e desafiadores.', 5),

-- Usuario 7, Empresa 2
(7, 2, 1, TRUE, TRUE, 10, 8.00, 4, 4.00, NULL, NULL, 'Equilíbrio razoável entre vida pessoal e trabalho.', 4),
-- Usuario 7, Empresa 4
(7, 4, 5, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Precisa melhorar a comunicação interna.', 3),

-- Usuario 8, Empresa 3
(8, 3, 6, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ambiente remoto, mas sem muita integração de equipe.', 4),
-- Usuario 8, Empresa 5
(8, 5, 4, TRUE, TRUE, 9, 10.00, 5, 5.00, NULL, NULL, 'Bons líderes, metodologia ágil bem aplicada.', 5),

-- Usuario 9, Empresa 1
(9, 1, 1, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Gestão antiga, mas em processo de modernização.', 4),
-- Usuario 9, Empresa 4
(9, 4, 3, TRUE, TRUE, 20, 15.00, 10, 8.00, NULL, NULL, 'Benefícios excelentes, equipe madura tecnicamente.', 5),

-- Usuario 10, Empresa 2
(10, 2, 2, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Muito trabalho repetitivo, pouca inovação.', 3),
-- Usuario 10, Empresa 5
(10, 5, 6, TRUE, TRUE, 12, 10.00, 6, 4.00, NULL, NULL, 'Boa remuneração e liberdade de escolha de projetos.', 5),

-- Usuario 11, Empresa 3
(11, 3, 1, TRUE, FALSE, 18, 10.00, 9, 7.00, NULL, NULL, 'Empresa com mindset ágil e foco em resultados.', 4),
-- Usuario 11, Empresa 4
(11, 4, 2, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Várias oportunidades de promoção interna.', 3),

-- Usuario 12, Empresa 1
(12, 1, 3, TRUE, TRUE, 7, 8.00, 3, 3.00, NULL, 2, 'Boa cultura de colaboração, mas metas agressivas.', 4),
-- Usuario 12, Empresa 2
(12, 2, 4, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Processos um pouco burocráticos.', 3),

-- Usuario 13, Empresa 4
(13, 4, 1, TRUE, TRUE, 5, 5.00, 2, 2.00, NULL, NULL, 'Benefícios médios, mas projetos interessantes.', 4),
-- Usuario 13, Empresa 5
(13, 5, 2, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ótimo ambiente, mas crescimento lento na carreira.', 3),

-- Usuario 14, Empresa 3
(14, 3, 3, TRUE, TRUE, 10, 12.00, 5, 4.00, NULL, NULL, 'Ótimos gestores, cultura bem definida.', 5),
-- Usuario 14, Empresa 5
(14, 5, 4, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Falta de transparência em algumas decisões.', 3),

-- Usuario 15, Empresa 1
(15, 1, 6, FALSE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Empresa grande, processo mais lento de mudança.', 3),
-- Usuario 15, Empresa 2
(15, 2, 5, TRUE, TRUE, 15, 15.00, 7, 7.00, NULL, NULL, 'Horas extras são remuneradas, clima descontraído.', 5);

------------------------------------------------------------------------------
-- 8. INSERÇÃO DE BENEFÍCIOS PARA AS AVALIAÇÕES (2 BENEFÍCIOS POR AVALIAÇÃO = 60 INSERÇÕES)
------------------------------------------------------------------------------

-- Precisamos saber quantas avaliações foram criadas acima (30).
-- Cada avaliação recebeu um ID sequencial (1 a 30). Adicionaremos 2 benefícios para cada.

INSERT INTO tbl_avaliacao_beneficio (id_avaliacao, id_beneficio)
VALUES
-- Para cada id_avaliacao de 1..30, associamos 2 benefícios
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 1),
(3, 3),
(4, 2),
(4, 3),
(5, 1),
(5, 3),
(6, 3),
(6, 2),
(7, 1),
(7, 2),
(8, 3),
(8, 1),
(9, 1),
(9, 3),
(10, 2),
(10, 3),
(11, 1),
(11, 2),
(12, 2),
(12, 3),
(13, 1),
(13, 2),
(14, 2),
(14, 3),
(15, 1),
(15, 3),
(16, 3),
(16, 1),
(17, 1),
(17, 2),
(18, 2),
(18, 3),
(19, 1),
(19, 3),
(20, 1),
(20, 2),
(21, 2),
(21, 3),
(22, 1),
(22, 3),
(23, 1),
(23, 2),
(24, 2),
(24, 3),
(25, 1),
(25, 3),
(26, 1),
(26, 2),
(27, 2),
(27, 3),
(28, 1),
(28, 3),
(29, 2),
(29, 3),
(30, 1),
(30, 2);
