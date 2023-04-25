-- sqlite3 DespesasPessoaisDB.db
-- .schema


Select r.id, r.idUsuario, c.descricao as categoria, tc.descricao as tipo, strftime('%d/%m/%Y', r.data) as data, r.descricao, r.valor
  From Receita r
 Inner Join Categoria c on r.idCategoria = c.id
 Inner Join TipoCategoria tc on c.idTipoCategoria = tc.id
 where r.idUsuario = 1 and c.idTipoCategoria = 2;