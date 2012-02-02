xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $OPTIONS as xs:string* external;

(:
 : Sends the http GET method to the specified URI. Returns the http response as well as whatever information is identified by the specified URI (for example, an html document). : @param $URI
 : @param $OPTIONS
 : @return item()+
 :)

try {
	xdmp:http-get(xs:string($URI), node()($OPTIONS))
} catch($error) {
	$error
}