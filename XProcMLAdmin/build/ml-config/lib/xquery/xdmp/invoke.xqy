xquery version "1.0-ml" encoding "utf-8";



declare variable $PATH as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : Returns the result of evaluating a module at the given path. : @param $PATH
 : @param $VARS
 : @param $OPTIONS
 : @return item()*
 :)

try {
	xdmp:invoke(xs:string($PATH), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), node()($OPTIONS))
} catch($error) {
	$error
}