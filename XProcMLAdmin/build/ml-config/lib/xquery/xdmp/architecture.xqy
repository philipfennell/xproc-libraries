xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the hardware architecture upon which MarkLogic Server is running. If xdmp:platform() returns "linux", it will return "x86_64" or "i686. If xdmp:platform() returns "solaris", it will return "amd64" or "sparcv9". If xdmp:platform() returns "winnt", it will return "amd64" or "i686". If xdmp:platform() returns "macosx", it will return "x86_64". : @return xs:string
 :)

try {
	xdmp:architecture()
} catch($error) {
	$error
}