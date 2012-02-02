xquery version "1.0-ml" encoding "utf-8";



declare variable $VAL as xs:string external;

(:
 : Returns a hexadecimal representation of an integer. : @param $VAL
 : @return xs:string
 :)

try {
	xdmp:integer-to-hex(xs:integer($VAL))
} catch($error) {
	$error
}