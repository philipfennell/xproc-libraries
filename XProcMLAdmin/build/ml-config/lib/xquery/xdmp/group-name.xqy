xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the the name of the group with the given ID. Returns the name of the current group if no parameter is specified. : @param $NAME
 : @return xs:string
 :)

try {
	xdmp:group-name(xs:unsignedLong($NAME))
} catch($error) {
	$error
}