xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the the ID of the group specified in the parameter. Returns the ID of the current group if no parameter is specified. : @param $NAME
 : @return xs:unsignedLong
 :)

try {
	xdmp:group(xs:string($NAME))
} catch($error) {
	$error
}