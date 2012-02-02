xquery version "1.0-ml" encoding "utf-8";



declare variable $MSG as xs:string external;
declare variable $LEVEL as xs:string* external;

(:
 : Logs a debug message to the log file <install_dir>/Logs/ErrorLog.txt . : @param $MSG
 : @param $LEVEL
 : @return empty-sequence()
 :)

try {
	xdmp:log(if (fn:matches($MSG, '\d+')) then xs:unsignedLong($MSG) else xs:string($MSG), xs:string($LEVEL))
} catch($error) {
	$error
}