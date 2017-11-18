#! /usr/bin/php -q
<?php
// -------------------------------------------------------------------
// PHP Script for CotEditor
// -------------------------------------------------------------------
// PURPOSE
// Format PHP code with php-cs-fixer
// 
// -------------------------------------------------------------------
// INSTALL 
// 1. In the CotEditor menu, select __Scripts__ > __Open Scripts Folder__.
// 2. Put scripts in the folder.
// See https://github.com/coteditor/SampleScripts for more information
// 
// -------------------------------------------------------------------
// RELATED
// https://github.com/coteditor/SampleScripts
// https://github.com/coteditor/CotEditor
// https://coteditor.com/
// 
// -------------------------------------------------------------------
// PREREQUISITES
// Install php-cs-fixer from 
// http://cs.sensiolabs.org/
// https://github.com/FriendsOfPHP/PHP-CS-Fixer
// 
// -------------------------------------------------------------------

try {


// Write to console
fwrite(STDERR, "*** START ***\n");

if ($argc < 2 )
{
	// ERROR
	// Wrong number of arguments
	// $argv[0] = Name of the script
	// $argv[1] = File in editor
	throw new \Exception('Wrong number of arguments', 1);
}

if (empty($argv[1]))
{
	// ERROR
	// Filename is missing
	// $argv[1] = File in editor
	throw new \Exception('Filename is missing', 1);
}

// Get path to active file in editor
$file = $argv[1];

if (empty($argv[1])) {
	// ERROR
	// Filename is missing
	// $argv[1] = File in editor
	throw new \Exception('Filename is missing', 1);
}

// Check if extension is php or inc
$extension = pathinfo($file, PATHINFO_EXTENSION);  // e.g. "php"
$extension = strtolower($extension);

if ($extension === 'php' || $extension === 'inc' || $extension === 'inc.php') {
	// SUCCESS
	// php extension
	// Continue
	
} else {
	// ERROR
	// Filename is missing
	// $argv[1] = File in editor
	throw new \Exception('Extension "'. $extension .'" is wrong', 1);
}

$binary = '/usr/local/bin/php-cs-fixer';
if (file_exists($binary) && is_executable($binary)){
	// SUCCESS
	// Binary exists
	// Binary is executable
	
} else {
	// ERROR
	// Wrong number of arguments
	// $argv[0] = Name of the script
	// $argv[1] = File in editor
	throw new \Exception('Binary "'. $binary .'" not found. Get it at http://cs.sensiolabs.org', 1);
}

$cmd = '';
$cmd .= $binary;
$cmd .= ' ';
$cmd .= 'fix';
$cmd .= ' ';
$cmd .= '--using-cache=no';
$cmd .= ' ';
//$cmd .= '"'. $file .'"';
$cmd .= $file;

if (0) {
	// Set logfile 
	$log  = $file . '.log';
	
	// Redirect output, and write to file
	$cmd .= ' ';
	$cmd .= '2>&1';
	$cmd .= ' > ';
	$cmd .= $log;
}

fwrite(STDERR, "*** EXEC ***\n");
fwrite(STDERR, $cmd ."\n");

shell_exec( $cmd );

} catch (Exception $e) {
    
    fwrite(STDERR, '*** ERROR ***');
    fwrite(STDERR, "\n");
    fwrite(STDERR, $e->getMessage());
    fwrite(STDERR, "\n");
    
}

fwrite(STDERR, "*** END ***\n");
 