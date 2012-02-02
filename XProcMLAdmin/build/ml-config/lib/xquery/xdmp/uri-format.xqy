xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;

(:
 : Returns the format of the given URI as matched in the mimetypes configuration. : @param $URI
 : @return xs:string
 :)

try {
	xdmp:uri-format(xs:string($URI))
} catch($error) {
	$error
}