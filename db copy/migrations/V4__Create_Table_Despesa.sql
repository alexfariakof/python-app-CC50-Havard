CREATE  TABLE Despesa (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idUsuario INTEGER NOT NULL,
  idCategoria INTEGER NOT NULL,
  data DATE,
  descricao TEXT,
  valor REAL NULL ,
  dataVencimento DATE);