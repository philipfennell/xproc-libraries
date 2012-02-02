xquery version "1.0-ml" encoding "utf-8";



declare variable $PATH as xs:string external;
declare variable $DEFAULT_NAMESPACE as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : [DEPRECATED: use xdmp:document-get instead] Returns the document in the XML file specified by $path. This function is deprecated and will be removed from a future release. Use xdmp:document-get instead. : @param $PATH
 : @param $DEFAULT_NAMESPACE
 : @param $OPTIONS
 : @return node()
 :)

try {
	xdmp:get(xs:string($PATH), xs:string($DEFAULT_NAMESPACE), xs:string($OPTIONS))
} catch($error) {
	$error
}