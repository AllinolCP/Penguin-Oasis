var keysTried = new Array();
var showLogins = true;
function loadHistory(refreshCache) {
    document.getElementById('historyBody').innerHTML = "<tr><td colspan='3'><center><img src='http://c.mirai.so/img/lightbox/loading.gif' height='20' width='20' />Loading History</td></center></tr>";
    if (lastHistoryLoad > Math.round(new Date().getTime() / 1000)) {
		document.getElementById('historyBody').innerHTML = "";
		if (refreshCache) {
			for (var i in cachedResults) {
				switch (cachedResults[i]['actionID']) {
					case 0:
						document.getElementById('historyBody').innerHTML += '<tr><td>Kicked by ' + cachedResults[i]['moderatorName'] + ' for: ' + cachedResults[i]['message'] + '</td><td>' + cachedResults[i]['ipAddr'] + '</td><td>' + cachedResults[i]['date'] + '</td></tr>';
						break;
					case 1:
						document.getElementById('historyBody').innerHTML += '<tr><td>Banned by ' + cachedResults[i]['moderatorName'] + ' for: ' + cachedResults[i]['message'] + '</td><td>' + cachedResults[i]['ipAddr'] + '</td><td>' + cachedResults[i]['date'] + '</td></tr>';
						break;
					case 11:
						document.getElementById('historyBody').innerHTML += '<tr><td>Warned by ' + cachedResults[i]['moderatorName'] + ' for: ' + cachedResults[i]['message'] + '</td><td>' + cachedResults[i]['ipAddr'] + '</td><td>' + cachedResults[i]['date'] + '</td></tr>';
						break;
					case 3:
						if (showLogins)
							document.getElementById('historyBody').innerHTML += '<tr><td>Logged into Mirai</td><td>' + cachedResults[i]['ipAddr'] + '</td><td>' + cachedResults[i]['date'] + '</td></tr>';
						break;
					case 4:
						document.getElementById('historyBody').innerHTML += '<tr><td>Changed password</td><td>' + cachedResults[i]['ipAddr'] + '</td><td>' + cachedResults[i]['date'] + '</td></tr>';
						break;
					default:
						break;
				}
			}
		} else {
			document.getElementById('historyBody').innerHTML = cachedHistory;
		}
    } else {
        lastHistoryLoad = (Math.round(new Date().getTime() / 1000) + 60);
		MNX.startNewRequest({ id: myID, authKey: myKey }, 'MNX_CMD_GET_HISTORY', handleGetHistoryResponse);
	}
}

function toggleLogins() {
	showLogins = !showLogins;
	loadHistory(true);
}

function handleGetHistoryResponse(isSuccess, responseData) {
	if (isSuccess == false) {
		document.getElementById('historyBody').innerHTML = '<tr><td colspan="3"><center>Your history failed to load. Try again later.</center></td></tr>';
		return false;
	} else {
		if (responseData['success'] == true) {
			document.getElementById('historyBody').innerHTML = "";
			for (var i in responseData['results']) {
				switch (responseData['results'][i]['actionID']) {
					case 0:
						document.getElementById('historyBody').innerHTML += '<tr><td>Kicked by ' + responseData['results'][i]['moderatorName'] + ' for: ' + responseData['results'][i]['message'] + '</td><td>' + responseData['results'][i]['ipAddr'] + '</td><td>' + responseData['results'][i]['date'] + '</td></tr>';
						break;
					case 1:
						document.getElementById('historyBody').innerHTML += '<tr><td>Banned by ' + responseData['results'][i]['moderatorName'] + ' for: ' + responseData['results'][i]['message'] + '</td><td>' + responseData['results'][i]['ipAddr'] + '</td><td>' + responseData['results'][i]['date'] + '</td></tr>';
						break;
					case 11:
						document.getElementById('historyBody').innerHTML += '<tr><td>Warned by ' + responseData['results'][i]['moderatorName'] + ' for: ' + responseData['results'][i]['message'] + '</td><td>' + responseData['results'][i]['ipAddr'] + '</td><td>' + responseData['results'][i]['date'] + '</td></tr>';
						break;
					case 3:
						if (showLogins)
							document.getElementById('historyBody').innerHTML += '<tr><td>Logged into Mirai</td><td>' + responseData['results'][i]['ipAddr'] + '</td><td>' + responseData['results'][i]['date'] + '</td></tr>';
						break;
					case 4:
						document.getElementById('historyBody').innerHTML += '<tr><td>Changed password</td><td>' + responseData['results'][i]['ipAddr'] + '</td><td>' + responseData['results'][i]['date'] + '</td></tr>';
						break;
					default:
						break;
				}
			}
			cachedHistory = document.getElementById('historyBody').innerHTML;
			cachedResults = responseData['results'];
			return true;
		}
	}
	document.getElementById('errorBox').style.display = 'block';
	document.getElementById('errorBox').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> There was an error displaying your history, try again later.</div>';
	closePopup('history');
}

function closePopup(type) {
    document.getElementById(type + '-over').style.display = 'none';
	return true;
}

function showPopup(type) {
    if (type == 'history') 
        loadHistory();
    document.getElementById(type + '-over').style.display = 'block';
    return true;
}

function changePassword() {
    var password = document.getElementById('form-password').value;
    var newpassword = document.getElementById('form-new-password').value;
    var cnewpassword = document.getElementById('form-confrimnew-password').value;
    if (password.length < 5) {
        document.getElementById('pwdError').style.display = 'block';
        document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your password must be at least 5 characters long</div>';
        return false;
    }
    if (newpassword != cnewpassword) {
        document.getElementById('pwdError').style.display = 'block';
        document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your new passwords must match</div>';
        return false;
    }
    if (newpassword.length < 5) {
        document.getElementById('pwdError').style.display = 'block';
        document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your new password must be at least 5 characters long</div>';
        return false;
    }
	MNX.startNewRequest({ id: myID, authKey: myKey, pass: password, new_pass: newpassword, new_pass_confirm: cnewpassword }, 'MNX_CMD_CHANGE_PASSWORD', handleChangePasswordResponse);
}
function handleChangePasswordResponse(isSuccess, responseData) {
	if (!isSuccess) {
		document.getElementById('errorBox').style.display = 'block';
		document.getElementById('errorBox').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> There was an error updating your password, try again later.</div>';
		closePopup('pwd');
		return false;
	} else {
		if (responseData['success'] == true) {
            document.getElementById('goodBar').style.display = 'block';
            document.getElementById('goodBar').innerHTML = '<div class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Success!</strong> Your password has been updated</div>';
            document.getElementById('form-password').value = '';
            document.getElementById('form-new-password').value = '';
            document.getElementById('form-confrimnew-password').value = '';
            document.getElementById('pwdError').style.display = 'none';
			MNX.setMNXCookie('userKey', responseData['newKey']);
			myKey = responseData['newKey'];
            closePopup('pwd');
			return true;
		} else {
			switch (responseData['errorNum']) {
				case 5948:
					document.getElementById('pwdError').style.display = 'block';
					document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Both the new password and confirmation password must match</div>';
					return true;
				case 2452:
					document.getElementById('pwdError').style.display = 'block';
					document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Your new password must be at least 5 characters long</div>';
					return true;
				case 3593:
					document.getElementById('pwdError').style.display = 'block';
					document.getElementById('pwdError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Incorrect old password. Try again.</div>';
					return true;
				default:
					MNX.setMNXCookie('isLoggedIn', 'FALSE');
					document.location = '/login';
					break;
			}
		}
	}
	document.getElementById('errorBox').style.display = 'block';
	document.getElementById('errorBox').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> There was an error updating your password, try again later.</div>';
	closePopup('pwd');
	return false;
}

function redeemCode() {
    var key = document.getElementById('form-rcode').value;
	if (keysTried.indexOf(key) != -1)
		return false;
    if (key.length != 36) {
        document.getElementById('redeemError').style.display = 'block';
        document.getElementById('redeemError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Please enter a valid code</div>';
        return false;
    }
	keysTried.push(key);
	MNX.startNewRequest({ id: myID, authKey: myKey, redemptionCode: key }, 'MNX_CMD_REDEEM_CODE', handleRedeemCodeResponse);
}
function handleRedeemCodeResponse(isSuccess, responseData) {
	if (!isSuccess) {
        document.getElementById('errorBox').style.display = 'block';
        document.getElementById('errorBox').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> There was an error redeeming your code. Try again later.</div>';
        closePopup('redeem');
		return true;
	} else {
		if (responseData['success'] != true) {
			switch (responseData['errorNum']) {
				case 2452:
					document.getElementById('redeemError').style.display = 'block';
					document.getElementById('redeemError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> Please enter a valid redemption code</div>';
					return false;
				case 3942:
				case 7003:
					document.getElementById('redeemError').style.display = 'block';
					document.getElementById('redeemError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> That redemption code does not exist</div>';
					return false;
				case 7000:
					document.getElementById('redeemError').style.display = 'block';
					document.getElementById('redeemError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> That redemption code has expired</div>';
					return false;
				case 7001:
				case 7002:
					document.getElementById('redeemError').style.display = 'block';
					document.getElementById('redeemError').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> That redemption has already been used</div>';
					return false;
				default:
					MNX.setMNXCookie('isLoggedIn', 'FALSE');
					document.location = '/login';
					return false;;
			}
		} else {
            document.getElementById('goodBar').style.display = 'block';
            document.getElementById('goodBar').innerHTML = '<div class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Success!</strong> Your code for <b><i>' + responseData['prize'] + '</i></b> has been redeemed.</div>';
            closePopup('redeem');
            return true;
		}
	}
	document.getElementById('errorBox').style.display = 'block';
	document.getElementById('errorBox').innerHTML = '<div class="alert alert-error fade in"><button data-dismiss="alert" class="close" type="button">×</button><strong>Error!</strong> There was an error redeeming your code. Try again later.</div>';
	closePopup('redeem');
	return true;
}