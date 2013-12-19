%%Author Patric Lövgren Berg

-module(dbconnect).

-export([start/2, startodbc/0]).



%% Defines the connection values for the DSN
-define(ConnectStr, "DSN=erlang;UID=LB;PWD=root").


startodbc() ->
        %%Start ODBC
        odbc:start().
    %% {ok, Ref} = odbc:connect("DSN=erlang;UID=root;PWD=root", []).
        

%% Initializing of the values that are to be inserted into the DB

start([Date, Close, High, Low, Open, Volume], [Ticker]) ->
        
       odbc:start(),
	   
        
        {ok,Ref} = odbc:connect("DSN=erlang;UID=root;PWD=root", []),
   %% io:format([Date, Close, High, Low, Open, Volume]),
        %% Defines the Sql query
        Sql_query = "INSERT INTO `testbackend`.`aapl` (Date, close, high, low, Open, Volume) VALUES
    ('"++Date++"',
     '"++Close++"', 
     '"++High++"', 
     '"++Low++"', 
     '"++Open++"', 
     '"++Volume++"');",
        
  %% Insert query into DB
%%io:format(Sql_query),
 odbc:sql_query(Ref, Sql_query),
 

 odbc:disconnect(Ref),

 odbc:stop().
  
    
