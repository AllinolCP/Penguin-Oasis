class cinqetdemi.JSON
{
    var text;
    static var inst;
    function JSON()
    {
    } // End of the function
    static function getInstance()
    {
        if (cinqetdemi.JSON.inst == null)
        {
            inst = new cinqetdemi.JSON();
        } // end if
        return (cinqetdemi.JSON.inst);
    } // End of the function
    static function stringify(arg)
    {
        var _loc3;
        var _loc2;
        var _loc6;
        var _loc1 = "";
        var _loc4;
        switch (typeof(arg))
        {
            case "object":
            {
                if (arg)
                {
                    if (arg instanceof Array)
                    {
                        for (var _loc2 = 0; _loc2 < arg.length; ++_loc2)
                        {
                            _loc4 = cinqetdemi.JSON.stringify(arg[_loc2]);
                            if (_loc1)
                            {
                                _loc1 = _loc1 + ",";
                            } // end if
                            _loc1 = _loc1 + _loc4;
                        } // end of for
                        return ("[" + _loc1 + "]");
                    }
                    else if (typeof(arg.toString) != "undefined")
                    {
                        for (var _loc2 in arg)
                        {
                            _loc4 = arg[_loc2];
                            if (typeof(_loc4) != "undefined" && typeof(_loc4) != "function")
                            {
                                _loc4 = cinqetdemi.JSON.stringify(_loc4);
                                if (_loc1)
                                {
                                    _loc1 = _loc1 + ",";
                                } // end if
                                _loc1 = _loc1 + (cinqetdemi.JSON.stringify(_loc2) + ":" + _loc4);
                            } // end if
                        } // end of for...in
                        return ("{" + _loc1 + "}");
                    } // end if
                } // end else if
                return ("null");
            } 
            case "number":
            {
                return (isFinite(arg) ? (String(arg)) : ("null"));
            } 
            case "string":
            {
                _loc6 = arg.length;
                _loc1 = "\"";
                for (var _loc2 = 0; _loc2 < _loc6; _loc2 = _loc2 + 1)
                {
                    _loc3 = arg.charAt(_loc2);
                    if (_loc3 >= " ")
                    {
                        if (_loc3 == "\\" || _loc3 == "\"")
                        {
                            _loc1 = _loc1 + "\\";
                        } // end if
                        _loc1 = _loc1 + _loc3;
                        continue;
                    } // end if
                    switch (_loc3)
                    {
                        case "\b":
                        {
                            _loc1 = _loc1 + "\\b";
                            break;
                        } 
                        case "\f":
                        {
                            _loc1 = _loc1 + "\\f";
                            break;
                        } 
                        case "\n":
                        {
                            _loc1 = _loc1 + "\\n";
                            break;
                        } 
                        case "\r":
                        {
                            _loc1 = _loc1 + "\\r";
                            break;
                        } 
                        case "\t":
                        {
                            _loc1 = _loc1 + "\\t";
                            break;
                        } 
                        default:
                        {
                            _loc3 = _loc3.charCodeAt();
                            _loc1 = _loc1 + ("\\u00" + Math.floor(_loc3 / 16).toString(16) + (_loc3 % 16).toString(16));
                        } 
                    } // End of switch
                } // end of for
                return (_loc1 + "\"");
            } 
            case "boolean":
            {
                return (String(arg));
            } 
        } // End of switch
        return ("null");
    } // End of the function
    static function parse(text)
    {
        if (!text.length)
        {
            throw new Error("JSONError: Text missing");
        } // end if
        var _loc1 = cinqetdemi.JSON.getInstance();
        _loc1.at = 0;
        _loc1.ch = " ";
        _loc1.text = text;
        return (_loc1.value());
    } // End of the function
    function error(m)
    {
        var _loc2 = "JSONError: " + m + " at " + (at - 1) + "\n";
        _loc2 = _loc2 + (text.substr(at - 10, 20) + "\n");
        _loc2 = _loc2 + "        ^";
        throw new Error(_loc2);
    } // End of the function
    function next()
    {
        ch = text.charAt(at);
        at = at + 1;
        return (ch);
    } // End of the function
    function white()
    {
        while (ch)
        {
            if (ch <= " ")
            {
                this.next();
                continue;
            } // end if
            if (ch == "/")
            {
                switch (this.next())
                {
                    case "/":
                    {
                        while (this.next() && ch != "\n" && ch != "\r")
                        {
                        } // end while
                        break;
                    } 
                    case "*":
                    {
                        this.next();
                        while (true)
                        {
                            if (ch)
                            {
                                if (ch == "*")
                                {
                                    if (this.next() == "/")
                                    {
                                        this.next();
                                        break;
                                    } // end if
                                }
                                else
                                {
                                    this.next();
                                } // end else if
                                continue;
                            } // end if
                            this.error("Unterminated comment");
                        } // end while
                        break;
                    } 
                    default:
                    {
                        this.error("Syntax error");
                    } 
                } // End of switch
                continue;
            } // end if
            break;
        } // end while
    } // End of the function
    function str()
    {
        var _loc3;
        var _loc2 = "";
        var _loc4;
        var _loc5;
        var _loc6 = false;
        if (ch == "\"" || ch == "\'")
        {
            var _loc7 = ch;
            while (this.next())
            {
                if (ch == _loc7)
                {
                    this.next();
                    return (_loc2);
                    continue;
                } // end if
                if (ch == "\\")
                {
                    switch (this.next())
                    {
                        case "b":
                        {
                            _loc2 = _loc2 + "\b";
                            break;
                        } 
                        case "f":
                        {
                            _loc2 = _loc2 + "\f";
                            break;
                        } 
                        case "n":
                        {
                            _loc2 = _loc2 + "\n";
                            break;
                        } 
                        case "r":
                        {
                            _loc2 = _loc2 + "\r";
                            break;
                        } 
                        case "t":
                        {
                            _loc2 = _loc2 + "\t";
                            break;
                        } 
                        case "u":
                        {
                            _loc5 = 0;
                            for (var _loc3 = 0; _loc3 < 4; _loc3 = _loc3 + 1)
                            {
                                _loc4 = parseInt(this.next(), 16);
                                if (!isFinite(_loc4))
                                {
                                    _loc6 = true;
                                    break;
                                } // end if
                                _loc5 = _loc5 * 16 + _loc4;
                            } // end of for
                            if (_loc6)
                            {
                                _loc6 = false;
                                break;
                            } // end if
                            _loc2 = _loc2 + String.fromCharCode(_loc5);
                            break;
                        } 
                        default:
                        {
                            _loc2 = _loc2 + ch;
                        } 
                    } // End of switch
                    continue;
                } // end if
                _loc2 = _loc2 + ch;
            } // end while
        } // end if
        this.error("Bad string");
    } // End of the function
    function key()
    {
        var _loc2 = ch;
        var _loc6 = false;
        var _loc5 = text.indexOf(":", at);
        var _loc4 = text.indexOf("\"", at);
        var _loc3 = text.indexOf("\'", at);
        if (_loc4 <= _loc5 && _loc4 > -1 || _loc3 <= _loc5 && _loc3 > -1)
        {
            _loc2 = this.str();
            this.white();
            if (ch == ":")
            {
                return (_loc2);
            }
            else
            {
                this.error("Bad key");
            } // end if
        } // end else if
        while (this.next())
        {
            if (ch == ":")
            {
                return (_loc2);
            } // end if
            if (ch <= " ")
            {
                continue;
            } // end if
            _loc2 = _loc2 + ch;
        } // end while
        this.error("Bad key");
    } // End of the function
    function arr()
    {
        var _loc2 = [];
        if (ch == "[")
        {
            this.next();
            this.white();
            if (ch == "]")
            {
                this.next();
                return (_loc2);
            } // end if
            while (ch)
            {
                if (ch == "]")
                {
                    this.next();
                    return (_loc2);
                } // end if
                _loc2.push(this.value());
                this.white();
                if (ch == "]")
                {
                    this.next();
                    return (_loc2);
                }
                else if (ch != ",")
                {
                    break;
                } // end else if
                this.next();
                this.white();
            } // end while
        } // end if
        this.error("Bad array");
    } // End of the function
    function obj()
    {
        var _loc3;
        var _loc2 = {};
        if (ch == "{")
        {
            this.next();
            this.white();
            if (ch == "}")
            {
                this.next();
                return (_loc2);
            } // end if
            while (ch)
            {
                if (ch == "}")
                {
                    this.next();
                    return (_loc2);
                } // end if
                _loc3 = this.key();
                if (ch != ":")
                {
                    break;
                } // end if
                this.next();
                _loc2[_loc3] = this.value();
                this.white();
                if (ch == "}")
                {
                    this.next();
                    return (_loc2);
                }
                else if (ch != ",")
                {
                    break;
                } // end else if
                this.next();
                this.white();
            } // end while
        } // end if
        this.error("Bad object");
    } // End of the function
    function num()
    {
        var _loc2 = "";
        var _loc3;
        if (ch == "-")
        {
            _loc2 = "-";
            this.next();
        } // end if
        while (ch >= "0" && ch <= "9" || ch == "x" || ch >= "a" && ch <= "f" || ch >= "A" && ch <= "F")
        {
            _loc2 = _loc2 + ch;
            this.next();
        } // end while
        if (ch == ".")
        {
            _loc2 = _loc2 + ".";
            this.next();
            while (ch >= "0" && ch <= "9")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end while
        } // end if
        if (ch == "e" || ch == "E")
        {
            _loc2 = _loc2 + ch;
            this.next();
            if (ch == "-" || ch == "+")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end if
            while (ch >= "0" && ch <= "9")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end while
        } // end if
        _loc3 = Number(_loc2);
        if (!isFinite(_loc3))
        {
            this.error("Bad number");
        } // end if
        return (_loc3);
    } // End of the function
    function word()
    {
        switch (ch)
        {
            case "t":
            {
                if (this.next() == "r" && this.next() == "u" && this.next() == "e")
                {
                    this.next();
                    return (true);
                } // end if
                break;
            } 
            case "f":
            {
                if (this.next() == "a" && this.next() == "l" && this.next() == "s" && this.next() == "e")
                {
                    this.next();
                    return (false);
                } // end if
                break;
            } 
            case "n":
            {
                if (this.next() == "u" && this.next() == "l" && this.next() == "l")
                {
                    this.next();
                    return (null);
                } // end if
                break;
            } 
        } // End of switch
        this.error("Syntax error");
    } // End of the function
    function value()
    {
        this.white();
        switch (ch)
        {
            case "{":
            {
                return (this.obj());
            } 
            case "[":
            {
                return (this.arr());
            } 
            case "\"":
            case "\'":
            {
                return (this.str());
            } 
            case "-":
            {
                return (this.num());
            } 
        } // End of switch
        return (ch >= "0" && ch <= "9" ? (this.num()) : (this.word()));
    } // End of the function
    var at = 0;
    var ch = " ";
} // End of Class
