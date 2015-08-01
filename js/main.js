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
			}
		}
		logRecords.push(record);
	}
	return logRecords;
}

// 課題 JS-2: 関数 `createLogTable` を記述してください
