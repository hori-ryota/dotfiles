<?php

/*
puppet

*/

// ****************

require_once('cache.php');

class Repo {
	
	private $id = 'puppet';
	private $kind = 'modules'; // for none found msg
	private $min_query_length = 1; // increase for slow DBs
	private $max_return = 25;
	
	private $cache;
	private $w;
	private $pkgs;
	
	function __construct() {
		
		$this->cache = new Cache();
		
		// get DB here if not dynamic search
		//$data = (array) $this->cache->get_db($this->id);
		//$this->pkgs = $data;
	}
	
	// return id | url | pkgstr
	function makeArg($id, $url, $version) {
		return $id . "|" . $url . "|" . $id;//"\"$id\":\"$version\",";
	}
	
	/*function check($pkg, $query) {
		if (!$query) { return true; }
		if (strpos($pkg["name"], $query) !== false) {
			return true;
		} else if (strpos($pkg["description"], $query) !== false) {
			return true;
		} 
	
		return false;
	}*/
	
	function search($query) {
		if ( strlen($query) < $this->min_query_length) {
			if ( strlen($query) === 0 ) { return; }
			$this->cache->w->result(
				"{$this->id}-min",
				$query,
				"Minimum query length of {$this->min_query_length} not met.",
				"",
				"icon-cache/{$this->id}.png"
			);
			return;
		}
		
		$this->pkgs = $this->cache->get_query_regex($this->id, $query, 'https://forge.puppetlabs.com/modules?utf-8=✓&sort=rank&q='.$query, '/<li class="clearfix ">([\s\S]*?)<\/li>/i');
		
		foreach($this->pkgs as $pkg) {
			
			// make params
			preg_match('/<h3>([\s\S]*?)<\/h3>/i', $pkg, $matches);
			$name = trim(strip_tags($matches[1]));
			
			preg_match('/<p>([\s\S]*?)<\/p>/i', $pkg, $matches);
			$description = trim(strip_tags($matches[1]));
			
			preg_match('/Version([\s\S]*?)<\/a>/i', $pkg, $matches);
			$version = trim(strip_tags($matches[1]));
	
			$this->cache->w->result(
				$name,
				$this->makeArg($name, 'https://forge.puppetlabs.com/'.$name, "*"),
				$name.' ~ v'.$version,
				$description,
				"icon-cache/{$this->id}.png"
			);
			
			// only search till max return reached
			if ( count ( $this->cache->w->results() ) == $this->max_return ) {
				break;
			}
		}
		
		if ( count( $this->cache->w->results() ) == 0) {
			$this->cache->w->result(
				"{$this->id}-search",
				"https://forge.puppetlabs.com/modules?utf-8=✓&sort=rank&q={$query}",
				"No {$this->kind} were found that matched \"{$query}\"",
				"Click to see the results for yourself",
				"icon-cache/{$this->id}.png"
			);
		}
	}
	
	function xml() {
		$this->cache->w->result(
			"{$this->id}-www",
			'https://forge.puppetlabs.com/',
			'Go to the website',
			'https://forge.puppetlabs.com',
			"icon-cache/{$this->id}.png"
		);
		
		return $this->cache->w->toxml();
	}

}

// ****************

/*
$query = "net";
$repo = new Repo();
$repo->search($query);
echo $repo->xml();
*/

?>