## Exercícios para praticar
### Subquery, Views, Stored Procedure, inner join, Função, Triggers, Gran e Revoke DCL
 
-- Exercício 01 INNER JOIN - Liste o título do livro e o nome de seus respectivos autores.
select l.titulo as 'Título do Livro', a.nome as 'Nome do autor'
from livros l
inner join livros_autores la on l.numero = la.numero_livro
inner join autores a on a.codigo = la.codigo_autor;

-- Exercício 02 INNER JOIN - Liste os nomes das editoras e os títulos dos livros que publicaram.
select e.nome_editora as 'Editora', l.titulo as 'Livro'
from editoras e
inner join livros l on l.codigo_editora = e.codigo_editora;

-- Exercício 03 SUBQUERIES - Encontre o nome das editoras que publicaram livros com preço acima de R$50.
select e.nome_editora
from editoras e
where codigo_editora in
				(select l.codigo_editora
				 from livros l
				 where l.preco > 50);

-- Exercício 04 SUBQUERIES - Liste o título dos livros cujo preço é o maior da tabela.
select l.titulo, l.preco
from livros l
where l.preco =
		(select max(preco)
		 from livros);

-- Exercício 05 SUBQUERIES - Liste o nome dos autores que escreveram mais de dois livros.
select a.nome
from autores a
where a.codigo in 
		(select la.codigo_autor
		 from livros_autores la
         group by la.codigo_autor
         having count(la.numero_livro) > 2);

-- Exercício 06 TRIGGERS - Crie uma trigger para atualizar automaticamente a tabela historico_preco_produto quando o preço de um livro for alterado.
DELIMITER //
create trigger atualiza_preco after update 
on livros
for each row
begin
	if old.preco <> new.preco then
		insert into historico_preco_produto(id_produto, data_modificacao, valor_anterior, valor_novo)
        values (new.numero, now(), old.preco, new.preco);
	end if;
end //
DELIMITER ;

-- Exercício 07 STORED PROCEDURES - Crie uma procedure para cadastrar um novo autor.
DELIMITER $$
create procedure cadastrarAutor(in codigo int, in nome varchar(45), in nacionalidade varchar(45))
begin
	insert into autores(codigo, nome, nacionalidade)
    values (codigo, nome, nacionalidade);
end $$
DELIMITER ;

call cadastrarAutor(28374996, 'Ludwig Von Mises', 'Austríaco');
select*from autores;

-- Exercício 08 FUNCTIONS - Crie uma função para calcular o desconto de um livro dado um percentual.
-- Exercício 09 VIEWS - Crie uma view para listar os livros com seus respectivos autores e editoras.
-- Exercício 10 TRANSAÇÕES - Exemplo de transação para cadastrar um livro e associar um autor.
-- Exercício 11 DCL (GRANT e REVOKE) - Conceda permissão de SELECT na tabela livros para o usuário usuario_teste.
-- Exercício 12 DCL (GRANT e REVOKE) - Revogue a permissão de SELECT na tabela livros do usuário usuario_teste