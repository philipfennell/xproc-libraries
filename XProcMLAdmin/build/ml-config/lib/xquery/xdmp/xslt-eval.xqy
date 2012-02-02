xquery version "1.0-ml" encoding "utf-8";



declare variable $STYLESHEET as element() := <stylesheet/>;
declare variable $INPUT as xs:string external;
declare variable $PARAMS as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : Executes an XSLT stylesheet against a node. : @param $STYLESHEET
 : @param $INPUT
 : @param $PARAMS
 : @param $OPTIONS
 : @return document-node()*
 :)

try {
	xdmp:xslt-eval($STYLESHEET, node()($INPUT), map:map($PARAMS), node()($OPTIONS))
} catch($error) {
	$error
}