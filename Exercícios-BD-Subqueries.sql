# Exercícios Subqueries

-- Exercício 01 - Liste o título e o preço dos livros cujo preço é maior do que a média dos preços de todos os livros.
select l.titulo, l.preco
from livros l
where l.preco > (
			select avg(preco)
			from livros
            );

-- Exercício 02 - Encontre o nome dos autores que escreveram livros publicados pela editora 'Eras'.
select a.nome
from autores a
where a.codigo in (
			select la.codigo_autor
			from livros_autores la
			inner join livros l on l.numero = la.numero_livro
			inner join editoras e on e.codigo_editora = l.codigo_editora
			where e.nome_editora = 'Saraiva'
            );

-- Exercício 03 - Liste o nome dos autores que escreveram livros com preços abaixo de R$30.
select a.nome
from autores a
where a.codigo in (select la.codigo_autor
				   from livros_autores la
                   inner join livros l on l.numero = la.numero_livro
                   where l.preco < 30);

-- Exercício 04 - Liste os títulos dos livros que têm mais de um autor.
select l.titulo
from livros l
where l.numero in (
			select la.numero_livro
			from livros_autores la
			inner join autores a on a.codigo = la.codigo_autor
			group by la.numero_livro
			having count(codigo_autor) > 1
            );

-- Exercício 05 - Encontre o nome das editoras que publicaram livros do gênero 'Romance'.
select e.nome_editora
from editoras e
where e.codigo_editora in (select l.codigo_editora
						   from livros l
                           where l.genero = 'Romance');

-- Exercício 06 - Liste o nome dos autores que não escreveram nenhum livro publicado pela editora 'Saraiva'.
select a.nome
from autores a
where a.codigo not in (
			  select la.codigo_autor
			  from livros_autores la
			  inner join livros l on l.numero = la.numero_livro
			  inner join editoras e on e.codigo_editora = l.codigo_editora
			  where e.nome_editora = 'Saraiva'
              );

-- Exercício 07 - Liste o título dos livros cujo preço está entre o menor e o maior preço de todos os livros.
select l.titulo
from livros l
where l.preco between (select min(preco) from livros) 
				   and (select max(preco) from livros);

-- Exercício 08 - Encontre os nomes das editoras que publicaram livros de pelo menos três autores diferentes.


-- Exercício 09 - Liste os títulos dos livros que não possuem autores associados.
-- Exercício 10 - Liste o nome dos autores que escreveram livros com preço superior à média de preços dos livros publicados pela 'Editora Summer'.

select*from editoras;
select*from autores;
select*from livros;
