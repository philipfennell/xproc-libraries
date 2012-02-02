xquery version "1.0-ml" encoding "utf-8";

declare variable $URI as xs:string external;

(:fn:doc($URI)/MedlineCitation/MedlineID/text():)

let $doc as document-node() := fn:doc($URI)
return
	( xdmp:node-replace($doc/MedlineCitation/@Status, attribute Status {'Archived'}),
	concat(string($doc/MedlineCitation/MedlineID), ' - ', string(fn:doc($URI)/MedlineCitation/@Status)) )