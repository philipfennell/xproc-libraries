xquery version "1.0-ml" encoding "utf-8";



declare variable $SOURCE as xs:string external;
declare variable $STARTING_LOCATION as xs:string external;
declare variable $LENGTH as xs:string* external;

(:
 : Returns a binary node made up of a subset of the given binary node. : @param $SOURCE
 : @param $STARTING_LOCATION
 : @param $LENGTH
 : @return binary()
 :)

try {
	xdmp:subbinary(binary()($SOURCE), xs:double($STARTING_LOCATION), xs:double($LENGTH))
} catch($error) {
	$error
}