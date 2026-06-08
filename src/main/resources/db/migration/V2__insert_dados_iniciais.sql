INSERT INTO modalidades(nome) VALUES 
('Musculação'),
('Funcional'),
('Jiu-Jitsu'),
('Muay Thai'),
('Pilates');

INSERT INTO planos(modalidade_id, nome, valor_mensal) VALUES 
SELECT id, 'Mensal', 120.00 FROM modalidades WHERE nome = 'Musculação';

INSERT INTO planos(modalidade_id, nome, valor_mensal) VALUES 
SELECT id, 'Trimestral', 330.00 FROM modalidades WHERE nome = 'Musculação';

INSERT INTO planos(modalidade_id, nome, valor_mensal) VALUES
SELECT id, 'Mensal', 150.00 FROM modalidades WHERE nome = 'Funcional';

INSERT INTO planos(modalidade_id, nome, valor_mensal) VALUES
SELECT id, 'Mensal', 180.00 FROM modalidades WHERE nome = 'Jiu-Jitsu';

INSERT INTO graduacoes(modalidade_id, nome) VALUES
SELECT id, 'Faixa Branca' FROM modalidades WHERE nome = 'Jiu-Jitsu