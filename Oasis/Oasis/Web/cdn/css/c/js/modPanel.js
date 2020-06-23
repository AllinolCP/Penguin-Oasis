var modPanel = {
	showSearchTwo : function () {
		document.getElementById('searchForm1').style.display = 'none';
		document.getElementById('searchForm2').style.display = 'block';
		return true;
	},
	searchForUser : function (_arg) {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState)
			return false;
		if (!isNaN(_arg)) {
			var searchType = 'id';
		} else if (_arg.indexOf('.') != -1){
			var searchType = 'ip';
		} else {
			var searchType = 'name';
		}
		document.getElementById('mSUser').innerHTML = _arg;
		document.getElementById('mSearchResults').innerHTML = "<tr><td colspan='3'><center>Searching...</center></td></tr>";
		$.ajax({
			url : 'http://team.api.mirai.so/panel/search/' + searchType,
			type : 'POST',
			dataType : 'json',
			data : {id: _arg},
			statusCode : {
				401 : function () {
					showNotification('There was an error searching for this user. Try re-logging in or waiting a few minutes.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == false) {
					document.getElementById('mSearchResults').innerHTML = "<tr><td colspan='3'><center><i class='icon-remove'></i> No Results</center></td></tr>";
					return false;
				}
				document.getElementById('mSearchResults').innerHTML = '';
				for (var i = 0; i <= data.length; i++) {
					var mTData = data[i];
					if (!(i in data))
						continue;
					document.getElementById('mSearchResults').innerHTML += '<tr onclick="modPanel.viewUser(' + mTData[0] + ', \'' + mTData[1] + '\');"><td>' + mTData[0] + '</td><td>' + mTData[1] + '</td><td>' + mTData[2] + '</td></tr>';
				}
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	pmBanUser : function (_arg) {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState)
			return false;
		if (isNaN(_arg))
			return false;
		$.ajax({
			url : 'http://team.api.mirai.so/panel/update/ban',
			type : 'POST',
			dataType : 'json',
			data : {id: _arg, type: 'pm'},
			statusCode : {
				401 : function () {
					showNotification('There was an error searching for this user. Try re-logging in or waiting a few minutes.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == true) {
					showNotification('Successfully banned the user. If they are online, they will be banned next time they log in.');
					return true;
				}
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	banUser : function (_arg) {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState)
			return false;
		if (isNaN(_arg))
			return false;
		$.ajax({
			url : 'http://team.api.mirai.so/panel/update/ban',
			type : 'POST',
			dataType : 'json',
			data : {id: _arg},
			statusCode : {
				401 : function () {
					showNotification('There was an error searching for this user. Try re-logging in or waiting a few minutes.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == true) {
					showNotification('Successfully banned the user. If they are online, they will be banned next time they log in.');
					return true;
				}
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	loadReports : function () {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState) {
			console.log('Not validated');
			return false;
		}
		$.ajax({
			url : 'http://team.api.mirai.so/panel/load/reports',
			type : 'POST',
			dataType : 'json',
			data : {},
			statusCode : {
				401 : function () {
					showNotification('There was an error loading the reports. Try again later or refresh.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == false) {
					document.getElementById('reportBody').innerHTML = "<tr><td colspan='5'><center><i class='icon-remove'></i> No Active Reports</center></td></tr>";
					return false;
				}
				document.getElementById('reportBody').innerHTML = '';
				for (var i = 0; i <= data.length; i++) {
					if (data[i] == undefined)
						continue;
					var mTData = data[i];
					if (mTData[3] == undefined)
						continue;
					document.getElementById('reportBody').innerHTML += '<tr><td>' + mTData[0] + '</td><td>' + mTData[1] + '</td><td>' + mTData[2] + '</td><td><a onclick="return thisMovie(\'miraiLoader\').joinRoom(' + mTData[3] + ');" href="#room' + mTData[3] + '">' + mTData[3] + '</a></td><td>' + mTData[4] + '</td></tr>';
				}
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	loadModeratorLogs : function () {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState)
			return false;

		$.ajax({
			url : 'http://team.api.mirai.so/panel/load/logs',
			type : 'POST',
			dataType : 'json',
			data : {},
			statusCode : {
				401 : function () {
					showNotification('There was an error loading the mod logs. Refresh or wait a few minutes.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == false) {
					document.getElementById('modLogBody').innerHTML = "<tr><td colspan='5'><center><i class='icon-remove'></i> No Moderator Logs</center></td></tr>";
					return false;
				}
				document.getElementById('modLogBody').innerHTML = '';
				for (var i = 0; i <= data.length; i++) {
					if (data[i] == undefined)
						continue;
					var mTData = data[i];
					if (mTData[2] == undefined)
						continue;
					//array($playerID, $actionID, $modName, $message, $date);
					switch (mTData[1]) {
						case 0:
							var msg = 'Kicked user ID [' + mTData[0] + '] for ' + mTData[3];
							break;
						case 1:
							var msg = 'Banned user ID [' + mTData[0] + '] for ' + mTData[3];
							break;
						case 11:
							var msg = 'Warned user ID [' + mTData[0] + '] for ' + mTData[3];
							break;
						case 39:
							var msg = 'Changed user ID [' + mTData[0] + ']\'s status to ' + mTData[3];
							break;
						default:
							var msg = 'Error reading log';
							break;
					}
					document.getElementById('modLogBody').innerHTML += '<tr><td>' + mTData[2] + '</td><td>' + msg + '</td><td>' + mTData[4] + '</td></tr>';
				}
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	viewUser : function (user_, username) {
		if (!this.isValidated || this.moderatorKey == '' || !this.readyState)
			return false;
		document.getElementById('viewTab').style.display = 'block';
		document.getElementById('mVUser').innerHTML = username;
		$.ajax({
			url : 'http://team.api.mirai.so/panel/get/user',
			type : 'POST',
			dataType : 'json',
			data : {id: user_},
			statusCode : {
				401 : function () {
					showNotification('There was an error loading this user. Refresh or wait a few minutes.');
					return true;
				}
			},
			success : function (data) {
				if (data['success'] == false) {
					document.getElementById('modLogBody').innerHTML = "<tr><td colspan='5'><center><i class='icon-remove'></i> User Not Found</center></td></tr>";
					return false;
				}
				document.getElementById('vULoad').style.display = 'none';
				document.getElementById('userPanes').style.display = 'block';
				document.getElementById('tUserInfo').innerHTML = '';
				for (var i in data) {
					if (i == 'showKeys')
						continue;
					if (i == 'Last Login' || i == 'Register Date')
						data[i] = new Date(data[i]*1000);
					if (i == 'Register IP' || i == 'Last Login IP')
						document.getElementById('tUserInfo').innerHTML += '<tr><td>' + i + '</td><td style="cursor:pointer;" onClick="modPanel.showSearchTwo();modPanel.searchForUser(\'' + data[i] + '\');return true;">' + data[i] + '</td></tr>';
					else
						document.getElementById('tUserInfo').innerHTML += '<tr><td>' + i + '</td><td>' + data[i] + '</td></tr>';
				}
				document.getElementById('tUserInfo').innerHTML += '<tr><td>Ban Options</td><td><button onClick=\'modPanel.banUser(' + data['Player ID'] + ')\'>Permanently Ban User</button> or <button onClick=\'modPanel.pmBanUser(' + data['Player ID'] + ')\'>PM Ban User</button></td></tr>';
			},
			headers : {
				'Mirai-Identifier' : modPanel.myID,
				'Mirai-Secure-Token' : modPanel.moderatorKey
			}
		})
	},
	modLogs : function () {
		return this.loadModeratorLogs();
	},
	moderatorKey : '',
	myID : 0,
	hasLoadedModLogs : false,
	isValidated : false,
	readyState : false
};
console.clear();
function newReport(suspect, victim, reason, roomID) {
	var reasons = ["Swearing", "Sexual Language", "Racial Words", "Personal Info", "Email Address", "Real Name", "Name Calling", "Bad Penguin Name"];
	document.getElementById('reportBody').innerHTML = '<tr><td>' + suspect + '</td><td>' + victim + '</td><td>' + reasons[reason] + '</td><td><a onclick="return thisMovie(\'miraiLoader\').joinRoom(' + roomID + ');" href="#game">' + roomID + '</a></td><td><span class="label label-success">now</span></td></tr>' + document.getElementById('reportBody').innerHTML;
}