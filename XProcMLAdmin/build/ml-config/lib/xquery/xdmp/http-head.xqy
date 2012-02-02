xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $OPTIONS as xs:string* external;

(:
 : Sends the http HEAD method to the specified URI. Returns the http response header for the specified URI. : @param $URI
 : @param $OPTIONS
 : @return item()+
 :)

try {
	xdmp:http-head(xs:string($URI), node()($OPTIONS))
} catch($error) {
	$error
}