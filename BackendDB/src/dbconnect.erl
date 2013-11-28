

%%Author Patric Lövgren Berg

-module(dbconnect).


-export([start/2]).

%% Defines the connection values for the DSN
-define(ConnectStr, "DSN=erlang;UID=root;PWD=root").


%% Initializing of the values that are to be inserted into the DB

start([Date, Close, High, Low, Open, Volume], [Ticker]) ->

	%%Start ODBC
	odbc:start(),
    
	%% Initialize the connection
	{ok, Ref} = odbc:connect(?ConnectStr, []),
	
	%% Defines the Sql query
	Sql_query = "INSERT INTO "++Ticker++" (Date, close, high, low, Open, Volume) VALUES
    ('"++Date++"',
     '"++Close++"', 
     '"++High++"', 
     '"++Low++"', 
     '"++Open++"', 
     '"++Volume++"');",
	
  %% Insert query into DB
  odbc:sql_query(Ref, Sql_query),
 
  
  odbc:sql_query(Ref, "SELECT * FROM aapl;"),
  
  %% Disconnect from the DSN
  odbc:disconnect(Ref),
  
  %% Stop the odbc service and quit
  odbc:stop().
    




%%[ID, Ini, Name, Date, Val1 , Val2, Val3, StockV]  '"++ ID ++"'
				  


 