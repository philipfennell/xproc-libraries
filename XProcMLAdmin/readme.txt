h1. XProc Language Binding for MarkLogic Admin API

h2. Project Structure

XProcMLAdmin
	build
		ml-config			Template pipeline and connection config
			lib				Generated XProc library files
				xquery
					admin	Admin API queries
					xdmp	XDMP API queries
				
	src
		main
			resources		Config and ML Documentation files
			xproc			XProc Libraries
		test
			resources		Config and connection files
			xproc			Test pipelines
	xslt					Transforms used to build the API libraries

The build.xpl file is the 'build' script for the XProc libraries.

If it proves necessary to build the libraries, and it shouldn't, then running
build.xpl in Calabash should generate the admin and xdmp XProc libraries, the
associated XQueries and also copy any 'static' library files into the build 
directory.


h2. Running XProcMLAdmin pipelines.

As an example, invoke the test pipeline:

	src/test/xproc/yellcontent.xpl 

using Calabash, other processor won't have the necessary MarkLogic extension 
steps, where the 'connection' input port should be bound to:

	src/test/resources/connection.xml

The 'connection' document defines the 'user', 'password', 'host' and 'port' 
parameters that are common to applications that use XCC. The 'dry-run' 
attribute allows you to only run through the steps without making any 
actual requests to the server. Using this can catch silly XProc errors. The 
d\'debug' attribute will cause the pipeline to spit-out each XQuery that was 
evaluated, which can be useful because it lets you see any errors that resulted
from preceeding steps. This bit could be better but it's better than a 'poke in
the eye'!


Important:

In the 'yellcontent' test script, the forest declarations have to state their 
host:

<mla:forest name="_poicontent01" host="hp6910-772b.marklogic.com" datadir=""/>

It goes without saying that you must set the host attribute according to the 
host name of your target environment!


It is easy enough to run this in oXygen 11, but you'll need to add the XCC Jar 
to the:

	Oxygen XML Editor 11/lib/xproc/calabash
	
directory. You'll also need to insert the following line of XML, as a child of 
'runtime', to the engine.xml file that lives in the above directory. 

<library name="xcc.jar"/>

This will allow Calabash to talk to XCC and therefore MarkLogic.


This all should run from the commandline too. In saying that I haven't tried it
as yet so if it doesn't work, please let me know.


Q: How do I script CPF install?
A: First, distinguish CPF installation from the installation of a default application
(either with conversion or without). The "Install" button in the Admin UI does both.
To script installation of CPF the APIs you need are in the CPF XQuery modules,
specifically 'Domains' and 'Pipelines'. You need to:

   1. Create a CPF configuration using dom:configuration-create
   2. Create one or more CPF domains using dom:create
   3. Insert one or more pipelines using p:insert (or create them using p:create)
   4. Attach the pipelines to the appropriate domains

The pipelines for the applications that are part of the server are all under the
Installer directory. You will almost certainly need to load and attach the status 
change handling pipeline, whatever you do.