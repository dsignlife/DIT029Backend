

%%Author Patric Lövgren Berg

-module(dbconnect).


-export([start/1]).

%% Defines the connection values for the DSN
-define(ConnectStr, "DSN=Erlang;UID=root;PWD=root").


%% Initializing of the values that are to be inserted into the DB

start([ID, Ini, Name, Date, Val1, Val2, Val3, StockV]) ->

	%%Start ODBC
	odbc:start(),
    
	%% Initialize the connection
	{ok, Ref} = odbc:connect(?ConnectStr, []),
	
	%% Defines the Sql query
	Sql_query = "INSERT INTO stocks (ID, Ini, Name, Date, Val1, Val2, Val3, StockV) VALUES
    ('"++ID++"',
     '"++Ini++"',
     '"++Name++"', 
     '"++Date++"', 
     '"++Val1++"', 
     '"++Val2++"', 
     '"++Val3++"', 
    '"++StockV++"');",
	
  %% Insert query into DB
  odbc:sql_query(Ref, Sql_query),
 
  
  odbc:sql_query(Ref, "SELECT * FROM stocks;"),
  
  %% Disconnect from the DSN
  odbc:disconnect(Ref),
  
  %% Stop the odbc service and quit
  odbc:stop().
    




%%[ID, Ini, Name, Date, Val1 , Val2, Val3, StockV]  '"++ ID ++"'
				  


 