xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the current root path for modules. : @return xs:string
 :)

try {
	xdmp:modules-root()
} catch($error) {
	$error
}