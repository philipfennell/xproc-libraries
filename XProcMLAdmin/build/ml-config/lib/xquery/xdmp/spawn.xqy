xquery version "1.0-ml" encoding "utf-8";



declare variable $PATH as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : Place the specified module on the task queue for evaluation. : @param $PATH
 : @param $VARS
 : @param $OPTIONS
 : @return empty-sequence()
 :)

try {
	xdmp:spawn(xs:string($PATH), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), node()($OPTIONS))
} catch($error) {
	$error
}