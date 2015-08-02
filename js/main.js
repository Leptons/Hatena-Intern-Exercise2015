function parseLTSVLog(logStr) {
	var logs = logStr.split("\n");
	logs.pop();
	var logRecords = new Array;
	for(var i = 0; i < logs.length; i++){
		var keyValues = logs[i].split("\t");
		var record = new Object;
		for(var j = 0; j < keyValues.length; j++){
			var result = keyValues[j].match(/^(.+?):(.*)$/);
			if(result !== null && result[2] !== "-"){
				if(result[1] === "epoch"){
					result[2] = parseInt(result[2], 10);
				}	
				record[result[1]] = result[2];
				// key が req のときは、value の中から path を取り出す
				if(result[1] === "req"){
					var r = result[2].match(/^.+ (.*) .+$/);
					if(r !== null){
						record.path = r[1];
					}
				}
			}
		}
		logRecords.push(record);
	}
	return logRecords;
}

function createLogTable(elem, logRecords) {
	var pathText = document.createTextNode('path');
	var pathNode = document.createElement('th');
	pathNode.appendChild(pathText);

	var epochText = document.createTextNode('epoch');
	var epochNode = document.createElement('th');
	epochNode.appendChild(epochText);

	var pathEpochNode = document.createElement('tr');
	pathEpochNode.appendChild(pathNode);
	pathEpochNode.appendChild(epochNode);
	var theadNode = document.createElement('thead');
	theadNode.appendChild(pathEpochNode);

	var tbodyNode = document.createElement('tbody');
	for(var i = 0; i < logRecords.length; i++){
		// path または epoch が空のデータは無視する
		if(typeof logRecords[i].path === "undefined" || typeof logRecords[i].epoch === "undefined") continue;
		var text1 = document.createTextNode(logRecords[i].path);
		var tdNode1 = document.createElement('td');
		tdNode1.appendChild(text1);

		var text2 = document.createTextNode(logRecords[i].epoch);
		var tdNode2 = document.createElement('td');
		tdNode2.appendChild(text2);

		var trNode = document.createElement('tr');
		trNode.appendChild(tdNode1);
		trNode.appendChild(tdNode2);
		tbodyNode.appendChild(trNode);
	}

	var tableNode = document.createElement('table');
	tableNode.appendChild(theadNode);
	tableNode.appendChild(tbodyNode);
	elem.appendChild(tableNode);
}
