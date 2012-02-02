xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the the ID of the host named in the parameter. Returns the ID of the current host if no parameter is specified. : @param $NAME
 : @return xs:unsignedLong
 :)

try {
	xdmp:host(xs:string($NAME))
} catch($error) {
	$error
}