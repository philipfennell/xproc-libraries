xquery version "1.0-ml" encoding "utf-8";



declare variable $STRING as xs:string external;

(:
 : Returns the specified string, converting all of the characters with diacritics to characters without diacritics. : @param $STRING
 : @return xs:string
 :)

try {
	xdmp:diacritic-less(xs:string($STRING))
} catch($error) {
	$error
}