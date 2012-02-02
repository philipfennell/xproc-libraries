xquery version "1.0-ml" encoding "utf-8";



declare variable $ITEM as xs:string external;
declare variable $MAXSEQUENCELENGTH as xs:string* external;
declare variable $MAXITEMLENGTH as xs:string* external;

(:
 : Returns a string representing the description of a given item sequence. If you take the output of the xdmp:describe function and evaluate it as an XQuery program, it returns the item(s) input to the function. : @param $ITEM
 : @param $MAXSEQUENCELENGTH
 : @param $MAXITEMLENGTH
 : @return xs:string
 :)

try {
	xdmp:describe(if (fn:matches($ITEM, '\d+')) then xs:unsignedLong($ITEM) else xs:string($ITEM), xs:unsignedInt($MAXSEQUENCELENGTH), xs:unsignedInt($MAXITEMLENGTH))
} catch($error) {
	$error
}