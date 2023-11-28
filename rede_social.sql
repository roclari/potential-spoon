CREATE DATABASE rede_social;
USE rede_social;

CREATE TABLE usuarios (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(30),
idade INT NOT NULL
);

CREATE TABLE posts (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
conteudo TEXT(250),
id_usuario INT,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE comentarios (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
conteudo TEXT(150),
id_usuario INT, FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
id_post INT, FOREIGN KEY (id_post) REFERENCES posts(id)
);

CREATE TABLE amizades (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
id_usuario_ativo INT, FOREIGN KEY (id_usuario_ativo) REFERENCES usuarios(id),
id_usuario_amigo INT, FOREIGN KEY (id_usuario_amigo) REFERENCES usuarios(id),
data_amizade DATE
);

SHOW TABLES;

INSERT INTO usuarios VALUES
(id, 'Larissa', 26), (id, 'João', 30), (id, 'Maria', 28),
(id, 'José', 29), (id, 'Ana', 28), (id, 'Pedro', 34);

INSERT INTO posts VALUES
(id, 'Bom dia, mundo!', 2),
(id, 'Boa tarde, mundo!', 2),
(id, 'Olá!', 1),
(id, 'Ooooi!', 3),
(id, 'Boa noite, mundo!', 2),
(id, 'Boa noite a todos!', 3),
(id, 'Estou ouvindo música.', 5),
(id, 'Adoro essa música: <link>', 5),
(id, 'Acabei de criar esse perfil.', 6);

INSERT INTO comentarios VALUES
(id, 'Bom dia!', 1, 1),
(id, 'Oie, bom dia!', 3, 1),
(id, 'Buenos!', 4, 1),
(id, 'Booom dia!', 5, 1),
(id, 'Oi!', 2, 3),
(id, 'Também estou!', 3, 5),
(id, 'Também adoro essa!', 1, 6),
(id, 'Adorooo!', 5, 6);

INSERT INTO amizades VALUES
(id, 1, 3, '2023-01-01'),
(id, 3, 5, '2023-02-15'),
(id, 2, 4, '2023-03-10'),
(id, 5, 6, '2023-04-05'),
(id, 4, 6, '2023-11-20'),
(id, 2, 3, '2023-11-01'),
(id, 1, 4, '2023-11-15');

SELECT * FROM posts WHERE id_usuario=2;

SELECT posts.conteudo, comentarios.*
FROM comentarios
JOIN posts ON comentarios.id_post = posts.id
WHERE posts.conteudo = 'Bom dia, mundo!';

SELECT usuarios.id, usuarios.nome,
COUNT(DISTINCT posts.id) AS total_posts,
COUNT(DISTINCT comentarios.id) AS total_comentarios
FROM usuarios
LEFT JOIN posts ON usuarios.id = posts.id_usuario
LEFT JOIN comentarios ON usuarios.id = comentarios.id_usuario
GROUP BY usuarios.id, usuarios.nome;

SELECT * FROM amizades WHERE data_amizade >= CURRENT_DATE - INTERVAL 30 DAY;

SELECT usuarios.id,
usuarios.nome,
posts.id AS id_post,
posts.conteudo AS postagem,
amizades.id_usuario_ativo AS usuario_1, amizades.id_usuario_amigo AS usuario_2,
amizades.data_amizade
FROM usuarios
LEFT JOIN posts ON usuarios.id = posts.id_usuario
LEFT JOIN amizades ON usuarios.id IN (amizades.id_usuario_ativo, amizades.id_usuario_amigo)
WHERE usuarios.nome = 'Maria';

SELECT * FROM amizades WHERE 3 IN (id_usuario_ativo, id_usuario_amigo);