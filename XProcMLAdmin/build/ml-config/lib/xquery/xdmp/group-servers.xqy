xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string* external;

(:
 : Returns the the IDs of all App Servers belonging to the group with the given ID. If no parameter is specified, it uses the group of the current host. : @param $NAME
 : @return xs:unsignedLong*
 :)

try {
	xdmp:group-servers(xs:unsignedLong($NAME))
} catch($error) {
	$error
}