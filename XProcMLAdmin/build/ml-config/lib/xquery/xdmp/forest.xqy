xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string external;

(:
 : Returns the the ID of the forest specified as the parameter. : @param $NAME
 : @return xs:unsignedLong
 :)

try {
	xdmp:forest(xs:string($NAME))
} catch($error) {
	$error
}