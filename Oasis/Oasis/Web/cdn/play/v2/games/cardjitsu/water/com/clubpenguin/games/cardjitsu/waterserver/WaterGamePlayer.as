class com.clubpenguin.games.cardjitsu.waterserver.WaterGamePlayer
{
    var __uid, __hand, __deck, __latencies, __hacks, __color, __activeCard, __coordinate, __get__coordinate, __get__latency, __latency, __get__card, __get__color, __set__coordinate, __get__index;
    function WaterGamePlayer(_id)
    {
        __uid = _id;
        __hand = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
        __deck = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
        __latencies = new Array();
        __hacks = 0;
        this.generateRandomPenguinColor();
        this.generateTemporaryDeck();
    } // End of the function
    function generateRandomPenguinColor()
    {
        var _loc2;
        _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.PENGUIN_COLOURS[Math.floor(Math.random() * com.clubpenguin.games.cardjitsu.water.ProjectConstants.PENGUIN_COLOURS.length - 1) + 1];
        __color = _loc2;
    } // End of the function
    function generateTemporaryDeck()
    {
        __deck = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
        __deck.createSubgroups("suit", ["f", "w", "s"]);
        __deck.addCardsByID(204, 305, 202, 13, 15, 312, 218, 220, 29, 90);
    } // End of the function
    function testSpecial(_item)
    {
        //return (_item.isSpecial());
    } // End of the function
    function getCard()
    {
        var _loc2;
        _loc2 = __deck.deal();
        __hand.addItems(_loc2);
        //return (_loc2.id().toString());
    } // End of the function
    function get card()
    {
        return (__activeCard);
    } // End of the function
    function get color()
    {
        return (__color);
    } // End of the function
    function get index()
    {
        return (__uid);
    } // End of the function
    function get coordinate()
    {
        return (__coordinate);
    } // End of the function
    function set coordinate(_val)
    {
        __coordinate = _val;
        //return (this.coordinate());
        null;
    } // End of the function
    function getInitString()
    {
        var _loc2;
        _loc2 = __color.toString();
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP;
        _loc2 = _loc2 + __coordinate.x.toString();
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL;
        _loc2 = _loc2 + __coordinate.y.toString();
        return (_loc2);
    } // End of the function
    function getCoordinateString()
    {
        var _loc2;
        _loc2 = __uid.toString();
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP;
        _loc2 = _loc2 + __coordinate.x.toString();
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL;
        _loc2 = _loc2 + __coordinate.y.toString();
        return (_loc2);
    } // End of the function
    function selectCard(_cardID)
    {
        if (__hand.containsCard(_cardID))
        {
            __activeCard = __hand.extractCardByID(_cardID);
        } // end if
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "Player" + __uid + "\n";
        return (_loc2);
    } // End of the function
    function resetLatency()
    {
        __latencies = new Array();
    } // End of the function
    function latencyCheck(_time)
    {
        __latencies.push(_time);
    } // End of the function
    function latencyRequest()
    {
        var _loc2;
        _loc2 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_TIME;
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM;
        _loc2 = _loc2 + __uid.toString();
        return (_loc2);
    } // End of the function
    function latencyDiff(_time)
    {
        var _loc3;
        var _loc2;
        _loc3 = __latencies.length;
        _loc2 = __latencies[_loc3 - 1];
        _loc2 = _time - _loc2;
        __latencies[_loc3 - 1] = _loc2;
        maxLatency = Math.max(com.clubpenguin.games.cardjitsu.waterserver.WaterGamePlayer.maxLatency, this.__get__latency());
    } // End of the function
    function get latency()
    {
        var _loc2;
        _loc2 = __latencies.length;
        __latencies.sort(order, Array.NUMERIC);
        if (_loc2 < com.clubpenguin.games.cardjitsu.waterserver.WaterGamePlayer.LATENCY_TESTS)
        {
            __latency = -1;
        }
        else if (__latency == -1)
        {
            __latency = this.determineMedian(__latencies);
        } // end else if
        return (__latency);
    } // End of the function
    function order(a, b)
    {
        var _loc2 = a;
        var _loc1 = b;
        if (_loc2 < _loc1)
        {
            return (-1);
        }
        else if (_loc2 > _loc1)
        {
            return (1);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    function determineMedian(_latencies)
    {
        var _loc2;
        if (_latencies.length % 2 == 0)
        {
            _loc2 = _latencies.length / 2 - 1;
            return ((_latencies[_loc2] + _latencies[_loc2 + 1]) / 2);
        }
        else
        {
            _loc2 = Math.floor(_latencies.length / 2);
            return (_latencies[_loc2]);
        } // end else if
    } // End of the function
    static var LATENCY_TESTS = 10;
    static var maxLatency = 0;
} // End of Class
