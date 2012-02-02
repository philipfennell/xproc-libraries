xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the the ID(s) of the App Server specified in the parameter. Returns the ID of the current App Server if no parameter is specified. : @param $NAME
 : @return xs:unsignedLong+
 :)

try {
	xdmp:server(xs:string($NAME))
} catch($error) {
	$error
}