class com.clubpenguin.mail.Postcard
{
    var senderName, senderID, _typeID, details, date, ID, read, __get__typeID;
    function Postcard(senderName, senderID, typeID, details, date, ID)
    {
        this.senderName = senderName;
        this.senderID = senderID;
        _typeID = typeID;
        this.details = details;
        this.date = date;
        this.ID = ID;
        read = false;
    } // End of the function
    function get typeID()
    {
        return (_typeID);
    } // End of the function
    static function getPostcardFromRawString(rawPostcardString)
    {
        var _loc1 = rawPostcardString.split(com.clubpenguin.mail.Postcard.RAW_POSTCARD_SEPARATOR);
        return (com.clubpenguin.mail.Postcard.getPostCardFromRawArray(_loc1));
    } // End of the function
    static function getPostCardFromRawArray(rawPostCardArray)
    {
        var _loc2 = new com.clubpenguin.mail.Postcard(String(rawPostCardArray[0]), Number(rawPostCardArray[1]), Number(rawPostCardArray[2]), String(rawPostCardArray[3]), Number(rawPostCardArray[4]), Number(rawPostCardArray[5]));
        return (_loc2);
    } // End of the function
    static var RAW_POSTCARD_SEPARATOR = "|";
} // End of Class
