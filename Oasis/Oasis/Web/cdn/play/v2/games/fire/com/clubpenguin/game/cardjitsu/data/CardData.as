class com.clubpenguin.game.cardjitsu.data.CardData
{
    function CardData()
    {
    } // End of the function
    static function getBorderColor(_color)
    {
        return (com.clubpenguin.game.cardjitsu.data.CardData.cardBorderColour[com.clubpenguin.game.cardjitsu.data.CardData.getIndexFromColor(_color)]);
    } // End of the function
    static function getGlowColor(_color)
    {
        return (com.clubpenguin.game.cardjitsu.data.CardData.cardGlowColour[com.clubpenguin.game.cardjitsu.data.CardData.getIndexFromColor(_color)]);
    } // End of the function
    static function validateID(_id)
    {
        var _loc1;
        _loc1 = _id;
        if (_id < 1 || _id >= com.clubpenguin.game.cardjitsu.data.CardData.cardArray.length)
        {
            _loc1 = 1;
        } // end if
        return (_loc1);
    } // End of the function
    static function getCardData(Void)
    {
        return (com.clubpenguin.game.cardjitsu.data.CardData.cardArray);
    } // End of the function
    static function getIndexFromColor(_color)
    {
        var _loc1;
        switch (_color)
        {
            case "r":
            {
                _loc1 = 0;
                break;
            } 
            case "g":
            {
                _loc1 = 1;
                break;
            } 
            case "b":
            {
                _loc1 = 2;
                break;
            } 
            case "p":
            {
                _loc1 = 3;
                break;
            } 
            case "o":
            {
                _loc1 = 4;
                break;
            } 
            case "y":
            {
                _loc1 = 5;
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    static var ATTRIBUTE_UID = 0;
    static var ATTRIBUTE_ELEMENT = 1;
    static var ATTRIBUTE_VALUE = 2;
    static var ATTRIBUTE_COLOR = 3;
    static var ATTRIBUTE_SPECIAL = 4;
    static var TOTAL_CARD_ATTRIBUTES = 5;
    static var cardBorderColour = [14826534, 6404422, 1132705, 10721738, 16225579, 16509741];
    static var cardGlowColour = [{ra: 45, rb: 153, ga: 45, gb: 30, ba: 45, bb: 5, aa: 80, ab: 0}, {ra: 50, rb: 49, ga: 50, gb: 93, ba: 50, bb: 35, aa: 80, ab: 0}, {ra: 55, rb: 12, ga: 55, gb: 41, ba: 55, bb: 158, aa: 80, ab: 0}, {ra: 45, rb: 102, ga: 45, gb: 77, ba: 45, bb: 101, aa: 80, ab: 0}, {ra: 45, rb: 153, ga: 45, gb: 86, ba: 45, bb: 15, aa: 80, ab: 0}, {ra: 35, rb: 150, ga: 35, gb: 153, ba: 35, bb: 15, aa: 80, ab: 0}];
    static var cardArray = [null, "1|f|3|b|0", "2|f|2|g|0", "3|f|8|g|0", "4|f|3|o|0", "5|f|4|p|0", "6|f|6|p|0", "7|f|2|r|0", "8|f|7|r|0", "9|f|2|y|0", "10|f|5|y|0", "11|s|3|b|0", "12|s|2|g|0", "13|s|5|g|0", "14|s|3|o|0", "15|s|4|p|0", "16|s|8|p|0", "17|s|2|r|0", "18|s|6|r|0", "19|s|2|y|0", "20|s|7|y|0", "21|w|3|b|0", "22|w|5|b|0", "23|w|2|g|0", "24|w|8|g|0", "25|w|3|o|0", "26|w|4|p|0", "27|w|6|p|0", "28|w|2|r|0", "29|w|7|r|0", "30|w|2|y|0", "31|f|2|b|0", "32|f|5|b|0", "33|f|4|g|0", "34|f|6|o|0", "35|f|3|p|0", "36|f|5|r|0", "37|f|4|y|0", "38|s|2|b|0", "39|s|5|b|0", "40|s|4|g|0", "41|s|6|o|0", "42|s|3|p|0", "43|s|5|r|0", "44|s|4|y|0", "45|w|2|b|0", "46|w|4|g|0", "47|w|6|o|0", "48|w|3|p|0", "49|w|5|r|0", "50|w|5|y|0", "51|f|6|b|0", "52|f|5|g|0", "53|f|4|o|0", "54|f|8|p|0", "55|f|3|r|0", "56|f|7|y|0", "57|s|6|b|0", "58|s|7|g|0", "59|s|4|o|0", "60|s|8|o|0", "61|s|6|p|0", "62|s|3|r|0", "63|s|5|y|0", "64|w|6|b|0", "65|w|5|g|0", "66|w|4|o|0", "67|w|8|p|0", "68|w|3|r|0", "69|w|4|y|0", "70|w|7|y|0", "71|f|9|r|13", "72|f|9|b|16", "73|f|10|y|1", "74|f|10|o|4", "75|f|11|p|7", "76|f|11|g|10", "77|f|12|r|2", "78|f|12|b|3", "79|s|9|r|15", "80|s|9|b|18", "81|s|10|g|1", "82|s|10|g|5", "83|s|11|p|9", "84|s|11|y|12", "85|s|12|o|2", "86|s|12|o|3", "87|w|9|r|14", "88|w|9|b|17", "89|w|10|y|1", "90|w|10|o|6", "91|w|11|p|8", "92|w|11|g|11", "93|w|12|p|2", "94|w|12|y|3", "95|s|12|b|10", "96|f|11|r|4", "97|w|11|g|9", "98|f|8|r|0", "99|f|7|o|0", "100|s|6|y|0", "101|w|5|p|0", "102|f|7|o|0", "103|s|6|g|0", "104|w|5|b|0", "105|f|4|b|0", "106|w|2|g|0", "107|s|3|p|0", "108|f|4|g|0", "109|w|3|g|0", "110|s|2|y|0", "111|f|5|r|0", "112|w|4|p|0", "113|s|3|o|0", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "201|f|2|b|0", "202|f|3|b|0", "203|f|4|p|0", "204|f|5|o|0", "205|f|6|r|0", "206|f|6|y|0", "207|f|7|o|0", "208|f|8|r|0", "209|s|4|b|0", "210|s|4|o|0", "211|s|5|p|0", "212|s|6|g|0", "213|s|7|y|0", "214|s|8|g|0", "215|w|2|g|0", "216|w|3|g|0", "217|w|4|r|0", "218|w|4|y|0", "219|w|5|o|0", "220|w|6|b|0", "221|w|6|o|0", "222|w|8|b|0", "223|f|3|p|0", "224|f|4|g|0", "225|f|5|y|0", "226|f|6|o|0", "227|f|7|r|0", "228|s|2|r|0", "229|s|3|o|0", "230|s|5|p|0", "231|s|6|y|0", "232|s|7|g|0", "233|w|2|g|0", "234|w|3|y|0", "235|w|4|r|0", "236|w|5|p|0", "237|w|7|b|0", "238|w|7|b|0", "239|f|4|p|0", "240|f|5|g|0", "241|s|3|r|0", "242|s|5|b|0", "243|s|6|p|0", "244|s|8|g|0", "245|w|5|r|0", "246|w|6|p|0", "247|w|7|p|0", "248|w|8|b|0", "249|f|9|b|16", "250|f|10|y|13", "251|f|11|p|7", "252|f|12|r|11", "253|s|9|o|15", "254|s|10|b|18", "255|s|11|y|5", "256|s|12|p|12", "257|w|9|p|8", "258|w|10|y|14", "259|w|11|o|6", "260|w|12|b|17", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "301|f|2|o|0", "302|f|3|b|0", "303|f|4|r|0", "304|f|5|o|0", "305|f|6|r|0", "306|f|6|y|0", "307|f|7|o|0", "308|f|8|r|0", "309|s|4|b|0", "310|s|4|o|0", "311|s|5|p|0", "312|s|6|g|0", "313|s|7|y|0", "314|s|8|g|0", "315|w|2|g|0", "316|w|3|g|0", "317|f|4|r|0", "318|w|4|y|0", "319|w|5|o|0", "320|f|6|o|0", "321|w|6|o|0", "322|w|8|b|0", "323|f|3|p|0", "324|f|4|g|0", "325|f|5|y|0", "326|f|6|o|0", "327|f|7|r|0", "328|s|2|r|0", "329|s|3|o|0", "330|s|3|r|0", "331|s|5|r|0", "332|s|6|y|0", "333|s|7|g|0", "334|w|2|g|0", "335|w|3|y|0", "336|w|4|r|0", "337|w|5|p|0", "338|w|7|b|0", "339|f|7|o|0", "340|f|4|p|0", "341|f|5|g|0", "342|s|5|b|0", "343|s|6|p|0", "344|s|8|g|0", "345|w|5|r|0", "346|w|6|r|0", "347|w|7|p|0", "348|w|8|b|0", "349|f|11|b|7", "350|f|10|y|8", "351|f|11|r|3", "352|f|12|o|9", "353|s|12|r|3", "354|s|10|g|12", "355|s|9|p|11", "356|s|9|y|2", "357|w|9|b|2", "358|w|10|p|10", "359|w|11|o|2", "360|w|12|g|3", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "401|w|2|r|0", "402|f|3|b|0", "403|s|4|p|0", "404|w|2|g|0", "405|f|3|y|0", "406|s|4|o|0", "407|w|2|b|0", "408|f|3|p|0", "409|s|4|g|0", "410|w|2|o|0", "411|f|3|r|0", "412|s|4|y|0", "413|w|5|r|0", "414|f|6|b|0", "415|s|5|p|0", "416|w|6|g|0", "417|f|5|y|0", "418|s|6|o|0", "419|w|5|r|0", "420|f|6|b|0", "421|w|7|r|0", "422|w|8|b|0", "423|f|9|p|0", "424|f|7|g|0", "425|s|8|y|0", "426|s|9|o|0", "427|f|12|r|4", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "501|f|2|b|0", "502|f|3|b|0", "503|f|4|p|0", "504|f|5|o|0", "505|f|6|r|0", "506|f|6|y|0", "507|f|7|o|0", "508|f|2|b|0", "509|f|3|b|0", "510|f|4|p|0", "511|f|5|o|0", "512|f|6|r|0", "513|f|6|y|0", "514|f|7|o|0", "515|s|4|b|0", "516|s|4|o|0", "517|s|5|p|0", "518|s|6|g|0", "519|s|7|y|0", "520|s|8|g|0", "521|s|4|b|0", "522|s|4|o|0", "523|s|5|p|0", "524|s|6|g|0", "525|w|2|g|0", "526|w|3|g|0", "527|w|4|r|0", "528|w|4|y|0", "529|w|5|o|0", "530|w|6|b|0", "531|w|6|o|0", "532|w|8|b|0", "533|w|2|g|0", "534|w|3|g|0", "535|w|4|r|0", "536|w|4|y|0", "537|w|5|o|0", "538|w|6|b|0", "539|w|6|o|0", "540|w|8|b|0", "541|w|2|g|0", "542|w|3|g|0", "543|f|3|p|0", "544|f|4|g|0", "545|f|5|y|0", "546|f|6|o|0", "547|f|7|r|0", "548|f|7|r|0", "549|s|2|r|0", "550|s|3|o|0", "551|s|5|p|0", "552|s|7|g|0", "553|w|2|g|0", "554|w|3|y|0", "555|w|4|r|0", "556|w|5|p|0", "557|w|7|b|0", "558|w|7|b|0", "559|w|7|b|0", "560|f|4|p|0", "561|f|5|g|0", "562|f|4|p|0", "563|f|5|g|0", "564|s|3|r|0", "565|s|5|b|0", "566|s|6|p|0", "567|w|5|r|0", "568|w|6|p|0", "569|w|7|p|0", "570|w|8|b|0", "571|w|8|b|0", "572|f|9|b|16", "573|f|10|y|13", "574|f|11|p|7", "575|f|12|r|11", "576|s|9|o|15", "577|s|10|b|18", "578|s|11|y|12", "579|s|12|p|5", "580|w|9|p|8", "581|w|10|y|14", "582|w|11|o|6", "583|w|12|b|17", "584|f|9|b|16", "585|f|10|y|13", "586|f|11|p|7", "587|f|12|r|11", "588|s|9|o|15", "589|s|10|b|18", "590|s|11|y|12", "591|s|12|p|5", "592|w|9|p|8", "593|w|10|y|14", "594|w|11|o|6", "595|w|12|b|17"];
} // End of Class
