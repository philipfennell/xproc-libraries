xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the current MarkLogic Server version. : @return xs:string
 :)

try {
	xdmp:version()
} catch($error) {
	$error
}