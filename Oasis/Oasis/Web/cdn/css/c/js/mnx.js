var MNX = {
    MNX_VER: '0.01',
    MNX_API_VER: '0.01',
    MNX_BASE: 'localhost',
    MNX_USER_API: '2de7d455d5b40f',
    MNX_ADMIN_API: '9fe17c133f9349ef',
    MNX_CALLBACK_STORE: '',
    MNX_COMMANDS: {
            'MNX_CMD_LOGIN': 'login_user',
            'MNX_CMD_REGISTER_USER': 'create_account',
            'MNX_CMD_GET_MESSAGES': 'get_messages',
            'MNX_CMD_SEND_MESSAGE': 'create_message',
            'MNX_CMD_REMOVE_MESSAGE': 'remove_message'
    },
    overrideMNXValue : function(key, value) {
        MNX[key] = value;
		console.log('[MNX] Overriding MNX default value: ' + key + ' -> ' + value);
        return value;
    },
    startNewRequest : function(requestData, requestCommand, requestCallback, isAdminRequest, overrideURL) {
        if (MNX.MNX_COMMANDS[requestCommand] == undefined && overrideURL == undefined) {
            console.log('[MNX] Could not find command: ' + requestCommand + ' in MNX_COMMANDS');
            return false;
        }
        if (typeof(requestCallback) != 'function') {
            console.log('[MNX] requestCallback in startNewRequest was not a valid function');
            return false;
        }
        if (typeof(requestData) != 'object')
            requestData = {}
        if (isAdminRequest == true && overrideURL == undefined)
            var urlToRequest = 'http://' + MNX.MNX_ADMIN_API + '.' + MNX.MNX_BASE + '/' + MNX.MNX_API_VER + '/' + MNX.MNX_COMMANDS[requestCommand];
        else {
            if (overrideURL == undefined)
                var urlToRequest = 'http://' + MNX.MNX_USER_API + '.' + MNX.MNX_BASE + '/' + MNX.MNX_API_VER + '/' + MNX.MNX_COMMANDS[requestCommand];
        }
        MNX.MNX_CALLBACK_STORE = requestCallback;
        $.post((overrideURL == undefined ? urlToRequest : overrideURL), requestData, function (returnData) { return MNX.MNX_CALLBACK_STORE(true, returnData);})
        .fail(function () { return MNX.MNX_CALLBACK_STORE(false, ''); });
		console.log('[MNX] Sending new request to: ' + (overrideURL == undefined ? urlToRequest : overrideURL));
        return true;
    },
    addMNXCommand : function(commandKey, commandValue) {
        if (typeof(commandKey) != 'string' || typeof(commandValue) != 'string') {
            console.log('[MNX] Invalid command key and value. Both must be strings');
            return false;
        }
		console.log('[MNX] Adding new command: ' + commandKey + ' -> ' + commandValue);
        MNX.MNX_COMMANDS[commandKey] = commandValue;
        return true;
    },
	setMNXCookie : function(cookieKey, cookieValue) {
		document.cookie = (cookieKey + '=' + cookieValue);
		return true;
	},
	getMNXCookie : function(cookieKey) {
		return getCookies()[cookieKey];
	}
};
if (typeof String.prototype.trimLeft !== "function") {
    String.prototype.trimLeft = function() {
        return this.replace(/^\s+/, "");
    };
}
if (typeof String.prototype.trimRight !== "function") {
    String.prototype.trimRight = function() {
        return this.replace(/\s+$/, "");
    };
}
if (typeof Array.prototype.map !== "function") {
    Array.prototype.map = function(callback, thisArg) {
        for (var i=0, n=this.length, a=[]; i<n; i++) {
            if (i in this) a[i] = callback.call(thisArg, this[i]);
        }
        return a;
    };
}
function getCookies() {
    var c = document.cookie, v = 0, cookies = {};
    if (document.cookie.match(/^\s*\$Version=(?:"1"|1);\s*(.*)/)) {
        c = RegExp.$1;
        v = 1;
    }
    if (v === 0) {
        c.split(/[,;]/).map(function(cookie) {
            var parts = cookie.split(/=/, 2),
                name = decodeURIComponent(parts[0].trimLeft()),
                value = parts.length > 1 ? decodeURIComponent(parts[1].trimRight()) : null;
            cookies[name] = value;
        });
    } else {
        c.match(/(?:^|\s+)([!#$%&'*+\-.0-9A-Z^`a-z|~]+)=([!#$%&'*+\-.0-9A-Z^`a-z|~]*|"(?:[\x20-\x7E\x80\xFF]|\\[\x00-\x7F])*")(?=\s*[,;]|$)/g).map(function($0, $1) {
            var name = $0,
                value = $1.charAt(0) === '"'
                          ? $1.substr(1, -1).replace(/\\(.)/g, "$1")
                          : $1;
            cookies[name] = value;
        });
    }
    return cookies;
}