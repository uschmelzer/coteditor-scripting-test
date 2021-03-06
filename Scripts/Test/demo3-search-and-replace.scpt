JsOsaDAS1.001.00bplist00�Vscript_// ------------------------------------------------------------------------------
// Sample JavaScript Script for CotEditor
// ------------------------------------------------------------------------------
// This script uses Javascript for Automation (JXA) on OS X Yosemite (and later).
// ------------------------------------------------------------------------------
// What does it do?
// - Get active document in CotEditor
// - Do some search & replace
// - Write the results back to CotEditor
// ------------------------------------------------------------------------------
// This even works with unsafed documents
// ------------------------------------------------------------------------------

function modifyContent(content) {

	var newContent = '';
	newContent += 'INSERTED BY MY SCRIPT';
	newContent += "\n";
	newContent += content;

	return newContent;

}




try {

	// -----------------------------------------
	// Init app
	// -----------------------------------------
	var app = Application('CotEditor');
	app.includeStandardAdditions = true;


	// -----------------------------------------
	// App
	// -----------------------------------------
	// Get properties
	// -----------------------------------------
	// https://forum.keyboardmaestro.com/t/jxa-problem-name-of-application/5685/3
	// app.properties()
	// --- RETURNS ---
	// {selection: null, frontmost: false, class: 'application', name: 'Script Editor', version: '2.8.1'}
	// -----------------------------------------
	var appProperties = app.properties();


	// -----------------------------------------
	// Show some info on console
	// -----------------------------------------
	app.writeToConsole('Application "'+ appProperties['name'] +'" is starting up...');
	app.writeToConsole('Application "'+ appProperties['name'] +'" has '+ app.documents.length  + ' open documents');


	// -----------------------------------------
	// Check if a document is in the editor
	// -----------------------------------------
	if (!app.documents.length) {

		// Quit
		// No documents available
    	throw ( new Error('Application "'+ appProperties['name'] +'": No documents available.') );
	}

	// -----------------------------------------
	// Get active document
	// -----------------------------------------
	var document = app.documents[0];


	// -----------------------------------------
	// Document
	// -----------------------------------------
	// Get properties
	// -----------------------------------------
	// https://forum.keyboardmaestro.com/t/jxa-problem-name-of-application/5685/3
	// app.documents.properties()
	// -----------------------------------------
	var documentProperties = document.properties();
	// e.g.: var nameDocument = propDocument['name'];

	//app.writeToConsole('Document name: '' + documentProperties['name']  + '' is the name of the active file');
	//app.writeToConsole('Document path: ' + documentProperties['file']);
	//app.writeToConsole('Document length: ' + documentProperties['length'] +' chars');
	//app.writeToConsole('Document content: ' + documentProperties['contents']);

	// -----------------------------------------
	// Modify the content
	// -----------------------------------------
	// Variant 1 
	// Using external binary
	// -----------------------------------------
	if (0) {

		// Run - This doesn't work
		app.doShellScript('/usr/local/bin/php-cs-fixer --version')

	}
	
	
	// -----------------------------------------
	// Modify the content
	// -----------------------------------------
	// Variant 2
	// Using plain JS
	// -----------------------------------------
	if (0) {
		var content = documentProperties['contents'];
		var modifiedContent = modifyContent(content);
		showBeforeAfterInConsole(content, modifiedContent);

		// -----------------------------------------
		// Replace all content
		// -----------------------------------------
		// The changes are visible instantly in 
		// CotEditor
		// -----------------------------------------
		// I wonder if there is a better way...
		// -----------------------------------------
		// I'd like something like this:
		// document.content = newContent;
		// -----------------------------------------
		var numberOfReplacedTexts = document.replace({ 
				for: content, 
				to: modifiedContent, 
				all: true
			});

	}


	// -----------------------------------------
	// Modify the content
	// -----------------------------------------
	// Variant 3
	// Using JXA methods
	// -----------------------------------------
	// The replacements are instantly 
	// visible in the editor
	// -----------------------------------------
	var numberOfReplacedTexts = null;
	var search = '';
	var replace = '';

	// -----------------------------------------
	// Search & replace
	// -----------------------------------------
	searchHint = 'Remove tabs';
	search = "\t";
	replace = '';
	numberOfReplacedTexts = document.replace({ 
				for: search, 
				to: replace, 
				all: true
			});
	
	app.writeToConsole('Application "'+ appProperties['name'] +'" replaced '+ numberOfReplacedTexts + ' occurences of "'+ searchHint +'"');


	// -----------------------------------------
	// Search & replace
	// -----------------------------------------
	searchHint = 'Remove multiple blanks';
	search = '  ';
	replace = ' ';
	numberOfReplacedTexts = document.replace({ 
				for: search, 
				to: replace, 
				all: true
			});
	
	app.writeToConsole('Application "'+ appProperties['name'] +'" replaced '+ numberOfReplacedTexts + ' occurences of "'+ searchHint +'"');


	// -----------------------------------------
	// Search & replace
	// -----------------------------------------
	searchHint = 'Add newline before {';
	search = "{";
	replace = "\n{";
	numberOfReplacedTexts = document.replace({ 
				for: search, 
				to: replace, 
				all: true
			});
	
	app.writeToConsole('Application "'+ appProperties['name'] +'" replaced '+ numberOfReplacedTexts + ' occurences of "'+ searchHint +'"');

	// -----------------------------------------
	// Search & replace
	// -----------------------------------------
	searchHint = 'Add newline after }';
	search = "}";
	replace = "}\n";
	numberOfReplacedTexts = document.replace({ 
				for: search, 
				to: replace, 
				all: true
			});
	
	app.writeToConsole('Application "'+ appProperties['name'] +'" replaced '+ numberOfReplacedTexts + ' occurences of "'+ searchHint +'"');


	// -----------------------------------------
	// Search & replace
	// -----------------------------------------
	searchHint = 'Remove excessive newlines';
	search = "\n\n";
	replace = "\n";
	numberOfReplacedTexts = document.replace({ 
				for: search, 
				to: replace, 
				all: true
			});
	
	app.writeToConsole('Application "'+ appProperties['name'] +'" replaced '+ numberOfReplacedTexts + ' occurences of "'+ searchHint +'"');



} catch( e ) {

	// -----------------------------------------
	// Handle exception
	// -----------------------------------------
	// TODO: Get message from exception obj
	// -----------------------------------------
    var exceptionErrormessage = '';
	exceptionErrormessage += e.name;
	exceptionErrormessage += " ";
	exceptionErrormessage += e.message;
	
	app.writeToConsole(exceptionErrormessage);
	app.displayAlert('Error', { message: exceptionErrormessage })
	
} finally {

	// -----------------------------------------
	// Final things
	// -----------------------------------------
    app.writeToConsole('*** End ***');
		
}
                              - jscr  ��ޭ