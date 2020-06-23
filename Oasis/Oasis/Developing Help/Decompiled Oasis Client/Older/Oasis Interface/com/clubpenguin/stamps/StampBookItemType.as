class com.clubpenguin.stamps.StampBookItemType extends com.clubpenguin.util.Enumeration
{
    var type;
    function StampBookItemType(type)
    {
        super();
        this.type = type;
    } // End of the function
    function toString()
    {
        return ("[StampBookItemType type=\"" + type + "\"]");
    } // End of the function
    static var STAMP = new com.clubpenguin.stamps.StampBookItemType("stamp");
    static var PIN = new com.clubpenguin.stamps.StampBookItemType("pin");
    static var AWARD = new com.clubpenguin.stamps.StampBookItemType("award");
    static var POLAROID = new com.clubpenguin.stamps.StampBookItemType("polaroid");
} // End of Class
