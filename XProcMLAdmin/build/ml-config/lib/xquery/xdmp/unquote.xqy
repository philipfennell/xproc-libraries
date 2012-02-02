xquery version "1.0-ml" encoding "utf-8";



declare variable $ARG as xs:string external;
declare variable $DEFAULT_NAMESPACE as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : Parses a string as XML, returning one or more document nodes. : @param $ARG
 : @param $DEFAULT_NAMESPACE
 : @param $OPTIONS
 : @return document-node()+
 :)

try {
	xdmp:unquote(xs:string($ARG), xs:string($DEFAULT_NAMESPACE), xs:string($OPTIONS))
} catch($error) {
	$error
}