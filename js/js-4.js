(function() {
	function searchLogTable(){
		var logInput = document.getElementById("log-input");
		var tableContainer = document.getElementById("table-container");
		var searchInput = document.getElementById("search-input");
		var log = parseLTSVLog(logInput.value);
		var searchText = searchInput.value;
		var logFiltered = log.filter(function(elem){
			if(typeof elem.path === "undefined") return false;
			return elem.path.indexOf(searchText)>=0;
		});
		createLogTable(tableContainer, logFiltered);
	}

	var searchButton = document.getElementById("search-button");
	searchButton.addEventListener("click", searchLogTable, false);
})();

