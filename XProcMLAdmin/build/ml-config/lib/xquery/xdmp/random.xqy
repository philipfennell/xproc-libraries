xquery version "1.0-ml" encoding "utf-8";



declare variable $MAX as xs:string* external;

(:
 : Returns a random unsigned integer between 0 and a number up to 64 bits long. : @param $MAX
 : @return xs:unsignedLong
 :)

try {
	xdmp:random(xs:unsignedLong($MAX))
} catch($error) {
	$error
}