%%Author Patric Lövgren Berg

-module(dbconnect).

-export([start/2]).



%% Defines the connection values for the DSN
-define(ConnectStr, "DSN=erlang;UID=LB;PWD=root").

%%Takes the values we got from the insert module and putting them in an SQL query which then sends it to the database.
start([Date, Close, High, Low, Open, Volume], Ticker) ->
        %%Starts the ODBC service
       odbc:start(),
	   
	   %% Initializing of the values that are to be inserted into the DB
        
        {ok,Ref} = odbc:connect("DSN=erlang;UID=root;PWD=root", []),

        %% Defines the Sql query
        Sql_query = "INSERT INTO `testbackend`.`"++Ticker++"` (Date, close, high, low, Open, Volume) VALUES
    ('"++Date++"',
     '"++Close++"', 
     '"++High++"', 
     '"++Low++"', 
     '"++Open++"', 
     '"++Volume++"');",
        
  %% Reports query to DB
 odbc:sql_query(Ref, Sql_query),

 
%% Disconnects and stops the odbc service only to be started again when the function starts.
%% This eliminates multiple connections to the database at once from one user which then causes MySQL to autodisconnect.  
 odbc:disconnect(Ref),

 odbc:stop().
  
    
