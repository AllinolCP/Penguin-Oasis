var urlToGo = '';
function openExternalURL(nickname, _url) {
	if (_url.toLowerCase().indexOf('mirai.so') != -1) {
		document.getElementById('badURL').style.display = 'none';
		document.getElementById('safeURL').style.display = 'block';
	} else {
		document.getElementById('badURL').style.display = 'block';
		document.getElementById('safeURL').style.display = 'none';
	}
	document.getElementById('extUS').innerHTML = nickname;
	urlToGo = _url;
	document.getElementById('externalURL').style.display = 'block';
}
function proceedToURL() {
	window.open(urlToGo, "_blank");
	document.getElementById('externalURL').style.display = 'none';
}
function closeExternal() {
	document.getElementById('externalURL').style.display = 'none';
}

function storeResponse(e) {
	switch (e) {
	case "success":
		if (isSnowball == true)
			document.getElementById("errorStore").innerHTML = '<div class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Success:</strong> You have purchased that item. You may now use it in-game.</div>';
		else
			document.getElementById("errorStore2").innerHTML = '<div class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Success:</strong> You have purchased that item. You may now use it in-game.</div>';
		break;
	case "success_nick":
		document.getElementById("nickname-req").style.display='none';
		document.getElementById("creditStore").style.display='block';
		document.getElementById("errorStore2").innerHTML = '<div class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Success:</strong> Your nickname has been changed! You still login using your normal username.</div>';
		break;
	case "fail_cred":
		if (isSnowball == true)
			document.getElementById("errorStore").innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error:</strong> You do not have enough credits.</div>';
		else
			document.getElementById("errorStore2").innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error:</strong> You do not have enough credits.</div>';
		break;
	case "fail_nickname_taken":
		document.getElementById("errorNicknameChange").innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error:</strong> That name is already taken. Try again.</div>';
		break;
	case "fail":
		if (isSnowball == true)
			document.getElementById("errorStore").innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error:</strong> There was an error purchasing this item.</div>';
		else
			document.getElementById("errorStore2").innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error:</strong> There was an error purchasing this item.</div>';
		break
	}
}
function setupMirai(e) {
	if (e == 'login') {
		return false;
	}else if (e == "game") {
		for (var t in parties) {
			document.getElementById("selectParty").innerHTML += '<optgroup label="' + t + '">';
			for (var n in parties[t]) {
				if (parties[t][n] == "normal")
					document.getElementById("selectParty").innerHTML += '<option label="' + n + '" selected="selected">' + parties[t][n] + "</option>";
				else
					document.getElementById("selectParty").innerHTML += '<option label="' + n + '">' + parties[t][n] + "</option>"
			}
			document.getElementById("selectParty").innerHTML += "</optgroup>"
		}
		document.getElementById("selectParty").style.display = "inline";
		document.getElementById("storeBtn").style.display = "inline";
		document.getElementById("gameSettingsBtn").style.display = "inline"
	} else {
		isSnowball = true;
		document.getElementById("snowballStoreBtn").style.display = "block";
		document.getElementById("snowballAlert").style.display = "block"
	}
	thisMovie("miraiLoader").toggleDebugMode(DEBUG_MODE)
}

function setOutfitList(outfits) {
	document.getElementById('outfitSelect').innerHTML = '';
	myOutfits = {}
	if (outfits.length == 0)
		return document.getElementById('outfitSelect').innerHTML += '<optgroup label="No Outfits!></optgroup>';
	for (var i in outfits) {
		if (outfits[i] == undefined)
			continue;
		if (outfits[i].name == undefined)
			continue;
		document.getElementById('outfitSelect').innerHTML += '<option value="' + i + '">' + outfits[i].name + '</option>';
		myOutfits[i] = outfits[i]
	}
}

function viewOutfit() {
	var id = document.getElementById('outfitSelect').value;
	if (myOutfits[id] != undefined) {
		thisMovie('outfitPreviewSWF').setPlayer(myOutfits[id].body, myOutfits[id].feet, myOutfits[id].hand, myOutfits[id].face, myOutfits[id].neck, myOutfits[id].color, myOutfits[id].head, myOutfits[id].flag, myOutfits[id].photo);
	}
}

function deleteOutfit() {
	var id = document.getElementById('outfitSelect').value;
	if (myOutfits[id] != undefined) {
		myOutfits[id] = undefined;
		setOutfitList(myOutfits);
		thisMovie('miraiLoader').deleteOutfit(id);
		console.log('Deleting: ' + id);
	}
}

function wearOutfit() {
	var id = document.getElementById('outfitSelect').value;
	if (myOutfits[id] != undefined) {
		thisMovie('miraiLoader').wearOutfit(id);
		closeOutsideContent("outfitSaver");
	}
}

function updateGameSetting(st) {
	if (st == 'fo') {
		thisMovie('miraiLoader').toggleFind(document.getElementById(st + "setting").checked);
	}
	thisMovie("miraiLoader").updateGameSettings(st, document.getElementById(st + "setting").checked);
}

function showQuickModTools(e, t) {
	pID = e;
	pName = t;
	document.getElementById("pNick").innerHTML = t + " [" + e + "]";
	document.getElementById("modTools").style.display = "block"
}
function givenCredits(amt) {
	document.getElementById("santaCRED").style.display = "block";
}

function closeSanta() {
	document.getElementById("santaCRED").style.display = "none";
}

function setupForMod(e, t) {
	document.getElementById("modPanel").style.display = "block";
	modPanel.myID = e;
	modPanel.moderatorKey = t;
	modPanel.readyState = true;
	modPanel.isValidated = true;
	if (e == 1098)
		document.getElementById('SANTA_ONLY').style.display = 'block';
	modPanel.loadReports()
}

function checkVersion(versionNum) {
	if (versionNum != miraiVersion)
		return thisMovie("miraiLoader").showError('large', 'There is a new version of Mirai available (' + miraiVersion + '). You are currently using ' + versionNum + '. If you want the new version you can clear your cache.', 'Continue', undefined, 'mirai.so/versions.php');
	return true;
}

function showEditor(e) {
	document.getElementById('editor_' + e).style.display = 'block';
}

function modAction(e) {
	switch (e) {
	case "pname":
		var t = "P" + pID;
		thisMovie("miraiLoader").moderatorAction("name", pID, t);
		break;
	case "warn":
		thisMovie("miraiLoader").moderatorAction("warn", pID, pName);
		break;
	case "snowballs":
		thisMovie("miraiLoader").moderatorAction("action", pID, "snowball");
		break;
	case "actions":
		thisMovie("miraiLoader").moderatorAction("action", pID, "dance");
		thisMovie("miraiLoader").moderatorAction("action", pID, "wave");
		break;
	case "emotes":
		thisMovie("miraiLoader").moderatorAction("action", pID, "emote");
		break;
	case "jokes":
		thisMovie("miraiLoader").moderatorAction("action", pID, "joke");
		break
	case "move":
		thisMovie("miraiLoader").showModCrosshair(pID);
		break
	case "transform":
		thisMovie("miraiLoader").moderatorAction("transform", pID);
		break
	case "credits":
		thisMovie("miraiLoader").moderatorAction("credits", pID, 5000);
		break
	}
}
function sendNickChange() {
	document.getElementById("errorNicknameChange").innerHTML = '<div class="alert alert-info fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Info:</strong> Requesting nickname change...</div>';
	thisMovie("miraiLoader").changeNickname(document.getElementById('nform-newName').value);
}
function buyItem(e) {
	if (e == 'nnc') {
		document.getElementById("nickname-req").style.display='block';
		document.getElementById("creditStore").style.display='none';
		return true;
	}
	thisMovie("miraiLoader").buyCreditItem(e)
}

function openStore() {
	document.getElementById("creditStore").style.display = "block"
}

function closeStore() {
	document.getElementById("creditStore").style.display = "none"
}

function openCreateDialog() {
	openExternalURL('Mirai', 'http://me.mirai.so/join/');
}

function openSnowballStore() {
	document.getElementById("snowballStore").style.display = "block"
}

function closeSnowballStore() {
	document.getElementById("snowballStore").style.display = "none"
}

function openSettings() {
	document.getElementById("gameSettings").style.display = "block"
}

function closeSettings() {
	document.getElementById("gameSettings").style.display = "none"
}

function debugTrace(e) {
	document.getElementById("debugTrace").innerHTML += "[DEBUG]: " + e + "\n"
}

function changeParty() {
	thisMovie("miraiLoader").setNewParty(document.getElementById("selectParty").value)
}

function createTransformations() {
	var e = document.getElementById("transformations");
	hasOpenedTrans = true;
	for (var t in transformations) {
		e.innerHTML += '<div class="transTile" onclick="transformMe(\'' + transformations[t] + '\');"><center><img src="http://c.mirai.so/img/trans/' + transformations[t] + '.png" height="80" width="80" /></center></div>'
	}
}

function transformMe(e) {
	var validT = false;
	for (var i in transformations) {
		if (transformations[i] == e)
			validT = true;
	}
	if (validT == false) {
		closeOutsideContent("transformManager")
		return thisMovie("miraiLoader").showError('large', 'Transforming into a non-valid character will result in a ban on your account if it continues.', 'Okay', undefined, 'BAN');
	}
	thisMovie("miraiLoader").transformMe(e);
	closeOutsideContent("transformManager")
}

function sendForcePW() {
	var newPass = document.getElementById('pform-newPass').value;
	var newPassConfirm = document.getElementById('pform-confirmPass').value;
	if (newPass != newPassConfirm) {
		document.getElementById('errorPasswordForce').style.display = 'block';
		document.getElementById('errorPasswordForce').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your new passwords must match</div>';
		return false;
	}
	if (newPass.length < 5) {
		document.getElementById('errorPasswordForce').style.display = 'block';
		document.getElementById('errorPasswordForce').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your new password must be at least 5 characters long</div>';
		return false;
	}
	MNX.startNewRequest({
		id : me.id,
		authKey : me.pwKey,
		newPass : newPass
	}, 'MNX_CMD_FORCE_PW_UPDATE', handleChangeForcedPasswordResponse);
	return true;
}

function showNotification(msg) {
	document.getElementById('notificationMsg').innerHTML = msg;
	document.getElementById('notificationMsg').style.display = 'block';
}

function handleChangeForcedPasswordResponse(isSuccess, responseData) {
	if (!isSuccess) {
		document.getElementById('errorPasswordForce').style.display = 'block';
		document.getElementById('errorPasswordForce').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> The API server could not be contacted. Try again later.</div>';
		return false;
	} else {
		if (responseData['success'] == true) {
			showNotification('Success: Your password was successfully updated!');
			document.getElementById('forcePWChange').style.display = 'none';
			thisMovie('miraiLoader').sendNewLogin(me.username, document.getElementById('pform-newPass').value);
		} else {
			if (responseData['errorNum'] == 2958 || responseData['errorNum'] == 1393) {
				showNotification('Error: Your password was <b>not</b> updated because you are no longer required to update it.');
				document.getElementById('forcePWChange').style.display = 'none';
				f
			} else {
				document.getElementById('errorPasswordForce').style.display = 'block';
				document.getElementById('errorPasswordForce').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Please enter a valid password and try again.</div>';
			}
		}
	}
	return true;
}

function openForcePW(username, id, key) {
	me.pwKey = key;
	me.id = id;
	me.username = username;
	document.getElementById('forcePWChange').style.display = 'block';
	MNX.addMNXCommand('MNX_CMD_FORCE_PW_UPDATE', 'forced_change_password');
	return true;
}

function setMyKey(e, t) {
	me.key = t;
	me.id = e
		privateMessenger.myID = e;
	privateMessenger.myPMKey = t;
}

function showOutsideContent(e, t) {
	var n = document.getElementById(e);
	if (n == undefined)
		return "unknown";
	if (e == "transformManager") {
		if (hasOpenedTrans == false)
			createTransformations()
	}
	if (e == "userRate") {
		if (t != undefined && !isNaN(t)) {
			document.getElementById("userRate").style.display = "block"
		}
	}
	if (e == 'privateMessenger') {
		if (hasOpenedPrivateMessenger == false) {
			hasOpenedPrivateMessenger = true;
			privateMessenger.loadMessages();
			privateMessenger.openMessenger();
			return true;
		}
		document.getElementById('privateMessenger').style.display = 'block';
	}
	n.style.display = "block"
}

function closeOutsideContent(e) {
	var t = document.getElementById(e);
	if (t == undefined)
		return "unknown";
	t.style.display = "none";
	thisMovie("miraiLoader").hideOutsideContent()
}

function thisMovie(e) {
	if (navigator.appName.indexOf("Microsoft") != -1) {
		return window[e]
	} else {
		return document[e]
	}
}
var parties = {};
var me = {};
var hasOpenedTrans = false;
var hasOpenedPrivateMessenger = false;
var transformations = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 48, 100, 101, 102, 103, 104, 105];
parties["Normal"] = {
	"New Normal Rooms" : "normal",
	"Old Normal Rooms" : "oldcp"
};
parties[2007] = {
	"Halloween Party" : "h1",
	"Surprise Party" : "w2"
};
parties[2008] = {
	"April Fools Party" : "a1",
	"Christmas Party" : "c2",
	"Halloween Party" : "h2",
	"Medieval Party" : "m2",
	"Waddle On Dance-A-Thon" : "m3",
	"St. Patrick's Day Party" : "s1",
	"Sub-Marine Party" : "w1"
};
parties[2009] = {
	"Festival of Flight" : "f2",
	"Halloween Party" : "h3",
	"Medieval Party" : "m1",
	"St. Patrick's Day Party" : "s2",
	"The Fair" : "t1",
	"Winter Fiesta" : "w4"
};
parties[2010] = {
	"April Fools Party" : "a2",
	"Earth Day Party" : "e1",
	"Fall Fair 2010" : "f1",
	"Holiday Party" : "h4",
	"Mountain Expedition" : "m4",
	"Puffle Party" : "p1"
};
parties[2011] = {
	"Card-Jitsu Party" : "c1",
	"Music Jam" : "m5",
	"Puffle Party" : "p2"
};
parties[2013] = {
	"Halloween Party" : "h6",
	"Christmas Party" : "h8"
};
parties[2014] = {
	"Puffle Party" : "p3",
	"The Fair" : "f3",
	"Muppet Takeover" : "m6",
	"Pre-historic Party" : "p4"
};
var mediaURL = "media.mirai.so";
var flashvars = {
	play : "http://" + mediaURL + "/play/",
	client : "http://" + mediaURL + "/play/v2/client/",
	content : "http://" + mediaURL + "/play/v2/content/",
	games : "http://" + mediaURL + "/play/v2/games/",
	lang : "en",
	p : "0",
	a : "1",
	connectionID : "cp" + Math.floor(Math.random() * 1e4 + 1)
};
var params = {
	wmode : "opaque",
	allowScriptAccess : "always"
};
var attributes = {
	name : "miraiLoader",
	id : "miraiLoader"
};
