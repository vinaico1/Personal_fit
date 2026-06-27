-- ============================================================
-- TACO 4ª Edição — Tabela Brasileira de Composição de Alimentos
-- Execute no Supabase SQL Editor
-- Valores por 100 g de parte comestível
-- ============================================================

-- Garante unicidade no nome para evitar duplicatas em re-execuções
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints
    WHERE constraint_name = 'alimentos_nome_key' AND table_name = 'alimentos'
  ) THEN
    ALTER TABLE public.alimentos ADD CONSTRAINT alimentos_nome_key UNIQUE (nome);
  END IF;
END $$;

INSERT INTO public.alimentos
  (nome, categoria, calorias_100g, proteina_100g, carboidrato_100g, gordura_100g, fibra_100g, sodio_mg_100g, porcao_padrao_g)
VALUES

-- ============================================================
-- CEREAIS E DERIVADOS
-- ============================================================
('Arroz, branco, cozido',              'Cereais e derivados', 128, 2.5, 28.1, 0.2,  1.6,  1,    100),
('Arroz, integral, cozido',            'Cereais e derivados', 124, 2.6, 25.8, 1.0,  2.7,  2,    100),
('Arroz, parboilizado, cozido',        'Cereais e derivados', 130, 2.7, 28.4, 0.3,  1.4,  3,    100),
('Aveia, farelo',                      'Cereais e derivados', 246, 13.9,66.6, 7.2, 15.4,  4,     40),
('Aveia, flocos, crua',                'Cereais e derivados', 394, 13.9,66.6, 8.5,  9.1,  4,     40),
('Biscoito, cream cracker',            'Cereais e derivados', 433,  9.6, 67.8,13.1,  2.3,745,    30),
('Biscoito, maisena',                  'Cereais e derivados', 440,  5.6, 76.9,12.5,  1.3,244,    30),
('Biscoito, recheado, chocolate',      'Cereais e derivados', 496,  5.4, 70.5,21.4,  1.0,287,    30),
('Canjica, cozida',                    'Cereais e derivados', 115,  2.3, 25.6, 0.8,  1.5,  2,   100),
('Corn flakes',                        'Cereais e derivados', 383,  6.8, 84.7, 1.2,  2.0,723,    30),
('Cuscuz, milho, cozido',              'Cereais e derivados', 173,  3.4, 38.0, 0.5,  2.4,  2,   100),
('Farinha de mandioca, crua',          'Cereais e derivados', 361,  1.8, 87.6, 0.3,  6.5,  2,    50),
('Farinha de milho, crua',             'Cereais e derivados', 357,  8.5, 73.6, 3.2,  4.4,  1,    50),
('Farinha de trigo, integral',         'Cereais e derivados', 340, 11.3, 69.3, 2.0,  6.9,  2,    50),
('Farinha de trigo, refinada',         'Cereais e derivados', 360,  9.8, 75.1, 1.4,  2.4,  2,    50),
('Farelo de trigo',                    'Cereais e derivados', 200, 12.2, 62.8, 4.2, 42.8,  6,    30),
('Fubá, cru',                          'Cereais e derivados', 354,  9.5, 75.5, 2.3,  4.2,  1,    50),
('Granola',                            'Cereais e derivados', 394,  9.9, 62.5,13.2,  9.1, 23,    50),
('Macarrão, cozido',                   'Cereais e derivados', 157,  4.9, 32.8, 1.0,  1.8,  2,   100),
('Macarrão, seco, cru',                'Cereais e derivados', 364, 12.5, 73.4, 2.3,  3.3,  6,    80),
('Milho, verde, cozido',               'Cereais e derivados',  99,  3.2, 21.2, 1.2,  2.1,243,   100),
('Pão de forma',                       'Cereais e derivados', 264,  8.1, 49.4, 3.7,  2.3,536,    50),
('Pão francês',                        'Cereais e derivados', 300,  8.0, 58.6, 3.1,  2.3,606,    50),
('Pão integral',                       'Cereais e derivados', 253,  8.9, 45.6, 3.3,  6.9,432,    50),
('Pipoca, estourada',                  'Cereais e derivados', 401,  9.8, 78.7, 4.5,  9.7,  6,    30),
('Tapioca, farinha, crua',             'Cereais e derivados', 344,  0.3, 85.0, 0.1,  0.0,  1,    50),

-- ============================================================
-- VERDURAS, HORTALIÇAS E DERIVADOS
-- ============================================================
('Abóbora, cozida',          'Verduras e hortaliças',  23,  1.0,  5.5, 0.1, 0.8,  1,  100),
('Acelga, crua',             'Verduras e hortaliças',  15,  1.6,  1.9, 0.1, 1.6,213,  100),
('Agrião, cru',              'Verduras e hortaliças',  13,  1.8,  0.7, 0.2, 0.7, 33,   50),
('Alface, cru',              'Verduras e hortaliças',  11,  1.3,  0.7, 0.2, 1.8, 10,   50),
('Alho, cru',                'Verduras e hortaliças', 132,  6.4, 26.6, 0.3, 4.1, 15,   10),
('Aspargo, cru',             'Verduras e hortaliças',  21,  2.2,  1.9, 0.2, 2.1,  3,  100),
('Batata-baroa, crua',       'Verduras e hortaliças', 100,  1.6, 23.3, 0.2, 2.5, 16,  100),
('Batata, cozida',           'Verduras e hortaliças',  52,  1.4, 11.8, 0.1, 1.4,  3,  100),
('Batata doce, cozida',      'Verduras e hortaliças',  77,  0.6, 18.4, 0.1, 2.2, 36,  100),
('Berinjela, crua',          'Verduras e hortaliças',  17,  1.0,  3.0, 0.2, 2.7,  5,  100),
('Beterraba, crua',          'Verduras e hortaliças',  43,  1.6,  9.3, 0.1, 2.1, 71,  100),
('Brócolis, cru',            'Verduras e hortaliças',  34,  4.0,  4.1, 0.5, 3.6, 20,  100),
('Brócolis, cozido',         'Verduras e hortaliças',  25,  2.9,  3.6, 0.3, 2.5, 16,  100),
('Cará, cru',                'Verduras e hortaliças', 116,  2.0, 27.3, 0.2, 1.4,  7,  100),
('Cenoura, crua',            'Verduras e hortaliças',  37,  1.0,  8.3, 0.3, 3.2, 63,  100),
('Cebola, crua',             'Verduras e hortaliças',  37,  1.3,  7.5, 0.2, 2.4,  4,   80),
('Chuchu, cru',              'Verduras e hortaliças',  16,  0.8,  3.1, 0.3, 1.2,  6,  100),
('Couve, crua',              'Verduras e hortaliças',  39,  5.3,  4.0, 1.0, 2.2, 31,  100),
('Couve-flor, crua',         'Verduras e hortaliças',  24,  2.9,  2.5, 0.3, 2.8, 23,  100),
('Espinafre, cru',           'Verduras e hortaliças',  22,  2.5,  1.5, 0.8, 2.0, 85,  100),
('Inhame, cru',              'Verduras e hortaliças', 116,  2.0, 27.3, 0.2, 1.4,  7,  100),
('Jiló, cru',                'Verduras e hortaliças',  22,  1.1,  3.7, 0.2, 2.0,  6,  100),
('Mandioca, cozida',         'Verduras e hortaliças', 125,  0.6, 30.1, 0.3, 1.9,  6,  100),
('Maxixe, cru',              'Verduras e hortaliças',  20,  1.6,  3.3, 0.2, 1.7,  4,  100),
('Pepino, cru',              'Verduras e hortaliças',  10,  0.9,  1.3, 0.1, 0.7,  1,  100),
('Pimentão, verde, cru',     'Verduras e hortaliças',  24,  0.9,  4.8, 0.2, 1.9,  3,   50),
('Pimentão, vermelho, cru',  'Verduras e hortaliças',  31,  1.1,  6.7, 0.4, 2.3,  3,   50),
('Quiabo, cru',              'Verduras e hortaliças',  31,  2.1,  5.6, 0.2, 3.2,  5,  100),
('Repolho, cru',             'Verduras e hortaliças',  28,  2.0,  5.0, 0.1, 2.5, 18,  100),
('Tomate, cru',              'Verduras e hortaliças',  15,  1.0,  2.7, 0.2, 1.2,  4,  100),
('Vagem, crua',              'Verduras e hortaliças',  25,  1.6,  4.2, 0.2, 2.2,  3,  100),
('Abobrinha, crua',          'Verduras e hortaliças',  18,  1.3,  3.0, 0.2, 1.5,  4,  100),

-- ============================================================
-- FRUTAS E DERIVADOS
-- ============================================================
('Abacate',           'Frutas e derivados',  96, 1.2,  6.0,  8.4, 6.3,  4, 100),
('Abacaxi',           'Frutas e derivados',  48, 0.9, 11.5,  0.1, 1.0,  1, 100),
('Acerola',           'Frutas e derivados',  32, 0.8,  6.8,  0.4, 1.4,  6,  50),
('Banana, prata',     'Frutas e derivados',  98, 1.3, 25.7,  0.1, 2.0,  1,  80),
('Banana, maçã',      'Frutas e derivados',  93, 1.1, 24.3,  0.3, 1.9,  1,  80),
('Banana, nanica',    'Frutas e derivados',  92, 1.4, 23.8,  0.1, 1.9,  1,  80),
('Caju',              'Frutas e derivados',  43, 1.2,  9.8,  0.6, 1.4,  5, 100),
('Caqui',             'Frutas e derivados',  64, 0.4, 16.2,  0.1, 2.3,  1, 100),
('Carambola',         'Frutas e derivados',  31, 0.5,  7.2,  0.1, 2.1,  4, 100),
('Coco, fruto maduro','Frutas e derivados', 354, 3.7, 15.2, 34.4, 9.5, 28,  50),
('Figo',              'Frutas e derivados',  61, 0.8, 14.7,  0.2, 2.8,  1, 100),
('Goiaba',            'Frutas e derivados',  54, 2.3,  9.1,  1.0, 6.2, 15, 100),
('Goiaba, vermelha',  'Frutas e derivados',  54, 2.3,  9.1,  1.0, 6.2, 15, 100),
('Graviola',          'Frutas e derivados',  62, 1.0, 15.1,  0.3, 1.9, 23, 100),
('Laranja, pêra',     'Frutas e derivados',  37, 1.0,  8.9,  0.1, 1.6,  1, 130),
('Limão, tahiti',     'Frutas e derivados',  30, 0.9,  6.3,  0.9, 2.6,  1,  50),
('Maçã, fuji',        'Frutas e derivados',  56, 0.3, 14.3,  0.2, 1.8,  1, 130),
('Mamão, papaia',     'Frutas e derivados',  45, 0.5, 11.4,  0.1, 1.8,  3, 150),
('Manga, tommy',      'Frutas e derivados',  64, 0.7, 16.1,  0.3, 1.2,  2, 100),
('Maracujá, polpa',   'Frutas e derivados',  68, 2.2, 14.8,  0.5, 0.4,  6, 100),
('Melancia',          'Frutas e derivados',  30, 0.8,  7.0,  0.2, 0.4,  4, 200),
('Melão',             'Frutas e derivados',  29, 0.7,  6.7,  0.2, 0.3, 14, 150),
('Morango',           'Frutas e derivados',  30, 0.7,  6.6,  0.4, 2.0,  1, 100),
('Pera',              'Frutas e derivados',  55, 0.4, 14.4,  0.1, 3.0,  1, 130),
('Pêssego',           'Frutas e derivados',  36, 0.8,  8.5,  0.1, 2.3,  1, 100),
('Pitanga',           'Frutas e derivados',  39, 0.7,  9.4,  0.2, 1.4,  3,  50),
('Tamarindo',         'Frutas e derivados', 272, 2.8, 70.0,  0.5, 5.1, 74,  30),
('Uva, niagara',      'Frutas e derivados',  62, 1.3, 15.3,  0.3, 1.5,  8, 100),
('Uva, itália',       'Frutas e derivados',  70, 0.9, 17.5,  0.3, 1.0,  8, 100),

-- ============================================================
-- GORDURAS E ÓLEOS
-- ============================================================
('Azeite de oliva',    'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   1,  10),
('Banha de porco',     'Gorduras e óleos', 897, 0.0, 0.0,  99.5, 0.0,   0,  10),
('Manteiga',           'Gorduras e óleos', 752, 0.5, 0.1,  83.5, 0.0, 576,  10),
('Margarina, vegetal', 'Gorduras e óleos', 720, 0.1, 0.1,  80.0, 0.0, 606,  10),
('Óleo de coco',       'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   0,  10),
('Óleo de girassol',   'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   0,  10),
('Óleo de milho',      'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   0,  10),
('Óleo de soja',       'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   0,  10),
('Óleo de canola',     'Gorduras e óleos', 884, 0.0, 0.0, 100.0, 0.0,   0,  10),

-- ============================================================
-- PESCADOS E FRUTOS DO MAR
-- ============================================================
('Atum, enlatado em água',      'Pescados e frutos do mar', 137, 30.7, 0.0,  2.2, 0.0,  367, 100),
('Atum, enlatado em óleo',      'Pescados e frutos do mar', 221, 25.9, 0.0, 12.7, 0.0,  346, 100),
('Bacalhau, fresco',            'Pescados e frutos do mar', 144, 22.1, 0.0,  5.7, 0.0,   92, 100),
('Cação, cru',                  'Pescados e frutos do mar', 100, 21.2, 0.0,  1.6, 0.0,   83, 100),
('Camarão, cozido',             'Pescados e frutos do mar',  98, 20.3, 0.4,  1.6, 0.0,  262, 100),
('Corvina, crua',               'Pescados e frutos do mar',  99, 18.5, 0.0,  2.6, 0.0,   72, 100),
('Lagosta, cozida',             'Pescados e frutos do mar',  95, 20.6, 0.6,  0.6, 0.0,  284, 100),
('Lula, crua',                  'Pescados e frutos do mar',  68, 14.9, 0.8,  0.8, 0.0,   44, 100),
('Merluza, filé, cru',          'Pescados e frutos do mar',  72, 15.7, 0.0,  0.8, 0.0,   77, 100),
('Pescada, crua',               'Pescados e frutos do mar',  75, 16.6, 0.0,  0.9, 0.0,   70, 100),
('Salmão, cru',                 'Pescados e frutos do mar', 143, 20.2, 0.0,  6.8, 0.0,   44, 100),
('Sardinha, enlatada em óleo',  'Pescados e frutos do mar', 270, 19.0, 0.0, 21.3, 0.0,  468, 100),
('Tilápia, filé, cru',          'Pescados e frutos do mar',  96, 20.1, 0.0,  1.7, 0.0,   56, 100),
('Truta, crua',                 'Pescados e frutos do mar', 129, 19.8, 0.0,  5.3, 0.0,   52, 100),

-- ============================================================
-- CARNES E DERIVADOS
-- ============================================================
('Frango, peito sem pele, grelhado',       'Carnes e derivados', 163, 31.5, 0.0,  3.8, 0.0,   65, 100),
('Frango, peito sem pele, cozido',         'Carnes e derivados', 159, 32.0, 0.0,  3.2, 0.0,   73, 100),
('Frango, coxa sem pele, assada',          'Carnes e derivados', 230, 27.3, 0.0, 13.4, 0.0,   78, 100),
('Frango, coxinha da asa, assada',         'Carnes e derivados', 307, 27.3, 0.0, 21.7, 0.0,   93, 100),
('Frango, sobrecoxa sem pele, cozida',     'Carnes e derivados', 202, 22.6, 0.0, 12.0, 0.0,   80, 100),
('Carne bovina, acém, cozido',             'Carnes e derivados', 219, 34.3, 0.0,  8.7, 0.0,   63, 100),
('Carne bovina, contrafilé, churrasco',    'Carnes e derivados', 266, 27.4, 0.0, 17.2, 0.0,   55, 100),
('Carne bovina, costela, assada',          'Carnes e derivados', 381, 24.9, 0.0, 31.1, 0.0,   65, 100),
('Carne bovina, filé mignon, grelhado',    'Carnes e derivados', 219, 33.4, 0.0,  8.8, 0.0,   59, 100),
('Carne bovina, patinho, cozido',          'Carnes e derivados', 219, 34.3, 0.0,  8.7, 0.0,   63, 100),
('Carne bovina, picanha, churrasco',       'Carnes e derivados', 298, 25.4, 0.0, 21.4, 0.0,   58, 100),
('Carne moída, bovina, refogada',          'Carnes e derivados', 248, 25.1, 0.0, 16.0, 0.0,   67, 100),
('Fígado, bovino, refogado',               'Carnes e derivados', 267, 33.7, 4.2, 13.5, 0.0,   86, 100),
('Linguiça de porco, fresca, frita',       'Carnes e derivados', 360, 17.4, 0.7, 31.8, 0.0,  738, 100),
('Linguiça calabresa, crua',               'Carnes e derivados', 403, 14.4, 0.0, 38.0, 0.0, 1120, 100),
('Mortadela',                              'Carnes e derivados', 292, 13.0, 3.1, 25.0, 0.0, 1090,  50),
('Pernil suíno, assado',                   'Carnes e derivados', 269, 22.7, 0.0, 19.2, 0.0,   49, 100),
('Presunto',                               'Carnes e derivados', 149, 17.8, 2.3,  7.3, 0.0, 1096,  50),
('Salsicha, de frango',                    'Carnes e derivados', 188, 12.6, 4.9, 13.2, 0.0,  814,  50),

-- ============================================================
-- LEITE E DERIVADOS
-- ============================================================
('Iogurte, desnatado',       'Leite e derivados',  55,  5.7,  7.8,  0.2, 0.0,  76, 200),
('Iogurte, integral',        'Leite e derivados',  66,  3.4,  4.8,  3.2, 0.0,  47, 200),
('Leite de vaca, desnatado', 'Leite e derivados',  35,  3.4,  4.9,  0.1, 0.0,  51, 200),
('Leite de vaca, integral',  'Leite e derivados',  61,  3.2,  4.5,  3.2, 0.0,  44, 200),
('Leite em pó, integral',    'Leite e derivados', 509, 26.6, 38.5, 26.9, 0.0, 427,  30),
('Leite condensado',         'Leite e derivados', 321,  7.4, 55.0,  8.3, 0.0, 134,  30),
('Creme de leite',           'Leite e derivados', 262,  2.2,  3.3, 26.6, 0.0,  31,  30),
('Queijo minas frescal',     'Leite e derivados', 264, 17.4,  2.9, 20.2, 0.0, 544,  50),
('Queijo mussarela',         'Leite e derivados', 354, 25.1,  0.0, 28.0, 0.0, 671,  30),
('Queijo parmesão',          'Leite e derivados', 456, 35.6,  4.0, 32.4, 0.0,1602,  15),
('Queijo prato',             'Leite e derivados', 357, 22.0,  1.5, 29.0, 0.0, 637,  30),
('Requeijão, cremoso',       'Leite e derivados', 245,  7.5,  2.9, 23.2, 0.0, 470,  30),
('Ricota',                   'Leite e derivados', 144, 11.1,  3.0,  9.7, 0.0, 124,  50),

-- ============================================================
-- OVOS E DERIVADOS
-- ============================================================
('Ovo de galinha, cru',   'Ovos e derivados', 143, 13.0, 1.0,  9.5, 0.0, 141, 50),
('Ovo de galinha, cozido','Ovos e derivados', 146, 13.0, 0.6, 10.0, 0.0, 146, 50),
('Ovo de galinha, frito', 'Ovos e derivados', 220, 14.1, 0.6, 17.7, 0.0, 222, 50),
('Clara de ovo, crua',    'Ovos e derivados',  48, 11.1, 0.7,  0.2, 0.0, 143, 30),
('Gema de ovo, crua',     'Ovos e derivados', 358, 16.1, 0.7, 31.9, 0.0,  62, 20),

-- ============================================================
-- LEGUMINOSAS E DERIVADOS
-- ============================================================
('Ervilha, enlatada',         'Leguminosas e derivados',  81, 5.6, 13.1, 0.2, 6.7, 228, 100),
('Ervilha, seca, cozida',     'Leguminosas e derivados',  91, 6.2, 16.4, 0.6, 8.3,   3, 100),
('Feijão, branco, cozido',    'Leguminosas e derivados', 100, 7.0, 17.9, 0.4, 7.9,   3, 100),
('Feijão, carioca, cozido',   'Leguminosas e derivados',  77, 4.8, 13.5, 0.5, 8.4,   2, 100),
('Feijão, fradinho, cozido',  'Leguminosas e derivados',  76, 5.2, 13.5, 0.4, 6.5,   3, 100),
('Feijão, preto, cozido',     'Leguminosas e derivados',  77, 4.5, 14.0, 0.5, 8.4,   4, 100),
('Feijão, verde, cru',        'Leguminosas e derivados',  46, 3.3,  7.8, 0.3, 4.0,   4, 100),
('Grão-de-bico, cozido',      'Leguminosas e derivados', 164, 9.0, 27.0, 2.7, 6.1,   7, 100),
('Lentilha, cozida',          'Leguminosas e derivados',  93, 7.0, 14.8, 0.6, 7.9,   3, 100),
('Soja, grão, cozido',        'Leguminosas e derivados', 204,20.2, 12.0, 9.3,13.0,   4, 100),
('Tofu',                      'Leguminosas e derivados',  68, 6.6,  1.9, 4.2, 0.3, 134, 100),

-- ============================================================
-- NOZES E SEMENTES
-- ============================================================
('Amendoim, torrado sem sal',           'Nozes e sementes', 567, 26.2, 21.0, 45.6,  8.0,   1, 30),
('Castanha de caju, torrada sem sal',   'Nozes e sementes', 570, 16.8, 31.6, 44.4,  3.7, 382, 30),
('Castanha do Pará, crua',              'Nozes e sementes', 670, 14.5, 15.1, 63.5,  5.4,   1, 20),
('Gergelim, semente crua',              'Nozes e sementes', 574, 17.7, 26.0, 49.7, 10.5,   6, 15),
('Linhaça, semente crua',               'Nozes e sementes', 534, 18.3, 28.9, 42.2, 27.3,  27, 15),
('Nozes, crua',                         'Nozes e sementes', 652, 14.4, 14.3, 63.3,  5.2,   1, 30),
('Pistache, torrado sem sal',           'Nozes e sementes', 562, 21.4, 27.5, 44.4, 10.3, 503, 30),
('Semente de abóbora, torrada',         'Nozes e sementes', 541, 24.5, 14.7, 45.8,  3.7,  18, 20),
('Semente de girassol, torrada sem sal','Nozes e sementes', 582, 22.0, 22.0, 48.0,  7.0,   3, 20),

-- ============================================================
-- AÇÚCARES E DOCES
-- ============================================================
('Açúcar, cristal',    'Açúcares e doces', 387, 0.0, 99.9,  0.0, 0.0,  0,  10),
('Açúcar, mascavo',    'Açúcares e doces', 375, 0.0, 92.7,  0.0, 0.0, 28,  10),
('Chocolate, amargo',  'Açúcares e doces', 508, 5.5, 54.8, 30.4, 8.8,  4,  30),
('Chocolate, ao leite','Açúcares e doces', 550, 6.7, 59.8, 30.1, 2.8, 76,  30),
('Geleia de frutas',   'Açúcares e doces', 249, 0.3, 62.7,  0.1, 0.8,  6,  20),
('Mel de abelha',      'Açúcares e doces', 309, 0.3, 82.4,  0.0, 0.3,  6,  20),
('Melado de cana',     'Açúcares e doces', 308, 0.0, 79.6,  0.0, 0.0,  7,  20),

-- ============================================================
-- BEBIDAS
-- ============================================================
('Água de coco',            'Bebidas', 22, 0.1,  5.3, 0.1, 0.0,  30, 200),
('Café, infusão',           'Bebidas',  2, 0.3,  0.0, 0.0, 0.0,   3, 240),
('Chá verde, infusão',      'Bebidas',  1, 0.0,  0.0, 0.0, 0.0,   1, 240),
('Chá preto, infusão',      'Bebidas',  2, 0.0,  0.4, 0.0, 0.0,   3, 240),
('Suco de laranja, natural','Bebidas', 43, 0.7, 10.3, 0.2, 0.3,   1, 200),
('Suco de uva, integral',   'Bebidas', 72, 0.7, 16.6, 0.3, 0.5,  14, 200),
('Refrigerante, cola',      'Bebidas', 37, 0.0,  9.3, 0.0, 0.0,   4, 350),
('Leite de coco',           'Bebidas',185, 1.9,  4.8,18.5, 0.0,  17, 100),

-- ============================================================
-- CONDIMENTOS E TEMPEROS
-- ============================================================
('Gengibre, fresco',  'Condimentos e temperos',  64, 1.8, 11.1,  1.7, 2.0,  13,  10),
('Molho de tomate',   'Condimentos e temperos',  47, 1.8,  9.3,  0.3, 1.9, 450,  60),
('Mostarda, amarela', 'Condimentos e temperos',  67, 4.0,  6.8,  3.6, 2.8,1128,  10),
('Ketchup',           'Condimentos e temperos',  96, 1.8, 22.7,  0.5, 1.2, 976,  30),
('Maionese',          'Condimentos e temperos', 699, 1.4,  2.7, 75.0, 0.3, 592,  15),
('Vinagre',           'Condimentos e temperos',   4, 0.0,  0.7,  0.0, 0.0,   3,  15)

ON CONFLICT (nome) DO NOTHING;
