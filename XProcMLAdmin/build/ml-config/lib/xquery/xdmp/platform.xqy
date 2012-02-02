xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the operating-system platform upon which MarkLogic Server is running ("solaris", "winnt", "linux", or "macosx"). : @return xs:string
 :)

try {
	xdmp:platform()
} catch($error) {
	$error
}