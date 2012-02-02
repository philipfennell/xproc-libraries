xquery version "1.0-ml" encoding "utf-8";



declare variable $FORMAT as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : Formats a dateTime value using POSIX strftime. : @param $FORMAT
 : @param $VALUE
 : @return xs:string
 :)

try {
	xdmp:strftime(xs:string($FORMAT), xs:dateTime($VALUE))
} catch($error) {
	$error
}