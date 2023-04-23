CREATE  TABLE TipoCategoria (
  id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,
  descricao TEXT);
CREATE UNIQUE INDEX  descricao ON TipoCategoria (descricao);