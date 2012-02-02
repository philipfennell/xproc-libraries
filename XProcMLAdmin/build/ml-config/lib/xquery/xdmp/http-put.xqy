xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $OPTIONS as xs:string* external;
declare variable $DATA as xs:string* external;

(:
 : Sends an HTTP PUT request to an HTTP server. The HTTP server should return a response, which will differ depending on the action the HTTP server takes for the PUT. : @param $URI
 : @param $OPTIONS
 : @param $DATA
 : @return item()+
 :)

try {
	xdmp:http-put(xs:string($URI), node()($OPTIONS), node()($DATA))
} catch($error) {
	$error
}