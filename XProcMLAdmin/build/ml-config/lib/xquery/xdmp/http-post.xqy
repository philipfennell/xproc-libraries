xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $OPTIONS as xs:string* external;
declare variable $DATA as xs:string* external;

(:
 : Sends the http POST request to the server. : @param $URI
 : @param $OPTIONS
 : @param $DATA
 : @return item()+
 :)

try {
	xdmp:http-post(xs:string($URI), node()($OPTIONS), node()($DATA))
} catch($error) {
	$error
}