xquery version "1.0-ml" encoding "utf-8";



declare variable $ID as xs:string external;

(:
 : Returns the the name of the host ID specified as the parameter. Returns the current host if no name is specified. : @param $ID
 : @return xs:string
 :)

try {
	xdmp:host-name(xs:unsignedLong($ID))
} catch($error) {
	$error
}