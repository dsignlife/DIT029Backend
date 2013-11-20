-module(getCsv).

-export([readlines/1, get_all_lines/1, parse/1]).

parse(List) ->
    Lines = re:split(List, ","),
 io:get_line(Lines).
         

readlines(Csv) ->
 {ok, Device} = file:open(Csv, [read]),
  try get_all_lines(Device)
 after file:close(Device),
    parse(Device)
  end.

get_all_lines(Device) ->
  case io:get_line(Device, "") of
   eof -> [];
   Line -> parse(Line),     
     get_all_lines(Device)
               end.