xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $OPTIONS as xs:string* external;

(:
 : Sends an http DELETE request to the http server specified in the URI to delete the specified resource. The server should respond if the request is to be completed, but a response is not guaranteed. Also, even if the server does respond, it does not guarantee that the request has been or will be completed. : @param $URI
 : @param $OPTIONS
 : @return item()+
 :)

try {
	xdmp:http-delete(xs:string($URI), node()($OPTIONS))
} catch($error) {
	$error
}