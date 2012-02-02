xquery version "1.0-ml" encoding "utf-8";



declare variable $ARG as xs:string external;
declare variable $OPTIONS as xs:string* external;

(:
 : Returns the unevaluated serialized representation of the input parameter as a string. : @param $ARG
 : @param $OPTIONS
 : @return xs:string
 :)

try {
	xdmp:quote(if (fn:matches($ARG, '\d+')) then xs:unsignedLong($ARG) else xs:string($ARG), node()($OPTIONS))
} catch($error) {
	$error
}