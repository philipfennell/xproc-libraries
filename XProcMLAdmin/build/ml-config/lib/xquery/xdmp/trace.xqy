xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : Signal a trace event. If trace events are activated and the event is enabled, the trace event is logged. : @param $NAME
 : @param $VALUE
 : @return empty-sequence()
 :)

try {
	xdmp:trace(xs:string($NAME), if (fn:matches($VALUE, '\d+')) then xs:unsignedLong($VALUE) else xs:string($VALUE))
} catch($error) {
	$error
}