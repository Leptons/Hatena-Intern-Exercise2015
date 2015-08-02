(function() {
	function printLogTable() {
		var logInput = document.getElementById("log-input");
		var tableContainer = document.getElementById("table-container");
		createLogTable(tableContainer, parseLTSVLog(logInput.innerHTML));
	}

	var submitButton = document.getElementById("submit-button");
	submitButton.addEventListener("click", printLogTable, false);
})();
