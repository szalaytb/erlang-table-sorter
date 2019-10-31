-module(torso).

-import(lists,[nth/2]).

-import(string,[concat/2]).

-compile(export_all). 

%%-include_lib("wx/include/wx.hrl").%%

main(_) ->
    start(),
	receive
		stop -> ok
	end.

run_server() ->
   ok = inets:start(),
   {ok, _} = inets:start(httpd, [ 
      {modules, [ 
         mod_alias, 
         mod_auth, 
         mod_esi, 
         mod_actions, 
         mod_cgi, 
         mod_dir,
         mod_get, 
         mod_head, 
         mod_log, 
         mod_disk_log 
      ]}, 
      
      {port,8081}, 
      {server_name,"torso"}, 
      {server_root,"C://Users/Public"}, 
      {document_root,"C://Users/Public/Documents"}, 
      {erl_script_alias, {"/erl", [torso]}}, 
      {error_log, "error.log"}, 
      {security_log, "security.log"}, 
      {transfer_log, "transfer.log"}, 
      
      {mime_types,[ 
         {"html","text/html"}, {"css","text/css"}, {"js","application/x-javascript"} ]} 
   ]). 
         
service(SessionID, _Env, _Input) -> mod_esi:deliver(SessionID, [ 
   "Content-Type: text/html\r\n\r\n", "<html><body>Hello, World!</body></html>" ]).

start() -> run_server().

%%http://localhost:8081/erl/torso:service
