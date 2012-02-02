xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the IDs of all hosts belonging to the group with the given ID. If no parameter is specified, it uses the group of the current host. : @param $NAME
 : @return xs:unsignedLong*
 :)

try {
	xdmp:group-hosts(xs:unsignedLong($NAME))
} catch($error) {
	$error
}