
-module(dbconnect).


-export([start/0]).

-define(ConnectStr, "DSN=Erlang;UID=root;PWD=root").
-define(X, _).
-define(ID, "0").


start() ->

	
	odbc:start(),

	{ok, Ref} = odbc:connect(?ConnectStr, []),
	
   %% odbc:sql_query(Ref, "INSERT INTO stocks (ID, Ini, Name, Date, Val1, Val2, Val3, StockV) VALUES ('"++?ID++"', 'man', 'mannen', '02/02/02', '50.0', '2.13', '15.5', 'abo123Stocks');").

  odbc:sql_query(Ref, "SELECT * FROM stocks WHERE ID >='"++ ?ID ++"';").
    




%%[ID, Ini, Name, Date, Val1 , Val2, Val3, StockV]  '"++ ID ++"'
				  


 