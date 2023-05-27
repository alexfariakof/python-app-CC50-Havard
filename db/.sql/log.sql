
-- sqlite3 DespesasPessoaisDB.db
-- .schema


Select '' as id, lancamentos.*
  From (Select d.idUsuario, data, idCategoria, valor*-1 as valor, 'Despesas' as Tipo, d.id as idDespesa, 0 as idReceita, d.descricao, c.descricao as categoria
          From Despesa d
         Inner Join Categoria c on d.idCategoria = c.id
         where d.idUsuario = 1
           and MONTHdata, 6, 2) = '10'
           and SUBSTRING(data, 1, 4) = '2002'
 union


--Regra de negocios para população da dropdown list categorias de receitas

Select id, descricao From Categoria where idUsuario = 1 and idTipoCategoria = 2



Select r.idUsuario, data, idCategoria, valor, 'Receitas' as Tipo, 0 as idDespesa, r.id as idReceita, r.descricao, cr.descricao as categoria
  From Receita r
 Inner Join Categoria cr on r.idCategoria = cr.id
 where r.idUsuario = 1
   and data like '%2022-10%'




select count(1) from despesa where idUsuario = 1;
select (CASE (select count(1) from despesa where idUsuario = 1) WHEN '0' THEN 0 ELSE sum(valor) END) as valor  from despesa where idUsuario = 2;





   ) lancamentos;


Select  SUBSTRING(data, 6, 2) as mes from despesa;
Select  SUBSTRING(data, 1, 4) as ano from despesa;

Select  SUBSTRING(data, 6, 2) as mes from Receita;
Select  SUBSTRING(data, 1, 4) as ano from Receita;

Select * From Categoria;
Select * From Despesa;
Select * From Receita;
select * From lançamento;


Select  lancamentos.* from
(Select d.idUsuario, data, idCategoria, valor*-1 as valor, 'Despesas' as Tipo, d.id as idDespesa, 0 as idReceita, d.descricao, c.descricao as categoria
  From Despesa d
 Inner Join Categoria c on d.idCategoria = c.id
 where d.idUsuario = 1
union
Select r.idUsuario, data, idCategoria, valor, 'Receitas' as Tipo, 0 as idDespesa, r.id as idReceita, r.descricao, cr.descricao as categoria
  From Receita r
 Inner Join Categoria cr on r.idCategoria = cr.id
 where r.idUsuario = 1
   ) as lancamentos;


Select cast(CONV(SUBSTRING(uuid(), 4, 4), 16, 10) as UNSIGNED) as id;
Select CURRENT_DATE as data, CURRENT_TIMESTAMP as data_hora ;


CREATE  TABLE _teste2 (
  id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,
  idUsuario INTEGER NULL,
  idCategoria INTEGER NULL,
  data DATETIME DEFAULT CURRENT_TIMESTAMP ,
  descricao TEXT NULL,
  valor REAL(10,2) NULL);





SELECT lower(hex(randomblob(16)));


Select c.id, tc.id as idCategoria,  tc.descricao as tipo, c.descricao From Categoria c Inner Join TipoCategoria tc on c.idTipoCategoria = tc.id where c.idUsuario = 1;


UPDATE Categoria SET idTipoCategoria = ?,  descricao = ? VALUE (1,'Transporte Alterado' ) Where idUsuario = 1 and id = 17;

UPDATE Categoria SET idTipoCategoria = ?,  descricao = ? Where idUsuario = ? and id = ?;

Delete  from Categoria where idUsuario = 1 and id = 17;



/*
Comandos de despesas
sqlite3 DespesasPessoaisDB.db
.schema
*/

INSERT INTO Despesa(idUsuario,idCategoria,data, descricao,valor,dataVencimento) values (1, 1, '2023-04-14', '1º Parveça Infnet', '2023-04-15', 24580.0)

-- Regra de negocio para apenas editar alterar ou exluir despesas que não foram consolidadas
Select d.*, (CASE l.consolidado  WHEN null THEN 0 ELSE l.consolidado END) as consolidado  From despesa d  LEFT Join lancamentos l on d.idUsuario = l.idUsuario  and d.id = l.idDespesa where d.idUsuario =1 and d.id =1 and l.consolidado = false;

-- Regra de negoci somente sera preenchida as categorias pertecente ao usuario e durante a edição sertá sleciona
Select id, descricao From Categoria where idUsuario =1;


Select sum(valor)as total from Receita r Inner Join Categoria c on r.idCategoria = c.id where r.idUsuario = 1 and idTipoCategoria = 2;


Select r.id, r.idUsuario, c.descricao as categoria, tc.descricao as tipo, strftime('%d/%m/%Y', r.data) as data, r.descricao, r.valor  From Receita r Inner Join Categoria c on r.idCategoria = c.id  Inner Join TipoCategoria tc on c.idTipoCategoria = tc.id  where r.idUsuario = 1 and c.idTipoCategoria = 2;



Select d.*, l.consolidado From despesa d  LEFT Join lancamentos l on d.idUsuario = l.idUsuario  and d.id = l.idDespesa where d.idUsuario = 1 and d.id = 13;


Select d.*, l.consolidado From despesa d  LEFT Join lancamentos l on d.idUsuario = l.idUsuario  and d.id = l.idDespesa where d.idUsuario = 1 and d.id = 13;


Select d.id, d.idUsuario, c.descricao as categoria, tc.descricao as tipo, strftime('%d/%m/%Y', d.data) as data, d.descricao, strftime('%d/%m/%Y', d.dataVencimento) as dataVencimento, d.valor  From Despesa d Inner Join Categoria c on d.idCategoria = c.id  Inner Join TipoCategoria tc on c.idTipoCategoria = tc.id  where d.idUsuario = 1 and c.idTipoCategoria = 1 and  strftime('%Y', d.data) = 2023 and strftime('%m', d.data) = 5
Select d.id, d.idUsuario, c.descricao as categoria, tc.descricao as tipo, strftime('%d/%m/%Y', d.data) as data, d.descricao, strftime('%d/%m/%Y', d.dataVencimento) as dataVencimento, d.valor  From Despesa d Inner Join Categoria c on d.idCategoria = c.id  Inner Join TipoCategoria tc on c.idTipoCategoria = tc.id  where d.idUsuario = 1 and c.idTipoCategoria = 1 and  strftime('%Y-%m', d.data) = '2022-10'

Select strftime('%m', data) from despesa;


Select  lancamentos.*
               from (Select d.idUsuario, strftime('%d/%m/%Y', data) as fData,  idCategoria, valor*-1 as valor, 'Despesas' as tipo, d.id as idDespesa, 0 as idReceita, d.descricao, c.descricao as categoria
                       From Despesa d
                      Inner Join Categoria c on d.idCategoria = c.id
                      where d.idUsuario = 1
              union
                     Select r.idUsuario, strftime('%d/%m/%Y', data) as fData, idCategoria, valor, 'Receitas' as tipo, 0 as idDespesa, r.id as idReceita, r.descricao, cr.descricao as categoria
                       From Receita r
                      Inner Join Categoria cr on r.idCategoria = cr.id
                     where r.idUsuario = 1
                    ) as lancamentos;


Select strftime('%d/%m/%Y', data), * from despesa;
Select strftime('%Y', data) from despesa;
Select 
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '01' and strftime('%Y', data) like '2023') as Janeiro,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '02' and strftime('%Y', data) like '2023') as Fevereiro,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '03' and strftime('%Y', data) like '2023') as Março,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '04' and strftime('%Y', data) like '2023') as Abril,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '05' and strftime('%Y', data) like '2023') as Maio,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '06' and strftime('%Y', data) like '2023') as Junho,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '07' and strftime('%Y', data) like '2023') as Julho,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '08' and strftime('%Y', data) like '2023') as Agosto,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '09' and strftime('%Y', data) like '2023') as Setembro,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '10' and strftime('%Y', data) like '2023') as Outubro,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '11' and strftime('%Y', data) like '2023') as Novembro,
(Select sum(valor) from despesa where idUsuario = 2  and strftime('%m', data) like '12' and strftime('%Y', data) like '2023') as Dezembro
; 

