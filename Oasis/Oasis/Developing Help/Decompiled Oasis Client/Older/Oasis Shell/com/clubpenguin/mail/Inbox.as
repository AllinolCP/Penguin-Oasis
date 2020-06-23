class com.clubpenguin.mail.Inbox
{
    var postCards;
    function Inbox()
    {
        postCards = [];
    } // End of the function
    function addPostCard(postCard)
    {
        postCards.push(postCard);
    } // End of the function
    function getPostCardsByTypeID(typeID)
    {
        var _loc3;
        var _loc4 = [];
        for (var _loc2 = 0; _loc2 < postCards.length; ++_loc2)
        {
            _loc3 = postCards[_loc2];
            if (_loc3.__get__typeID() == typeID)
            {
                _loc4.push(_loc3);
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    static function getInboxFromRawArray(rawInbox)
    {
        var _loc3 = new com.clubpenguin.mail.Inbox();
        for (var _loc1 = 0; _loc1 < rawInbox.length; ++_loc1)
        {
            _loc3.addPostCard(com.clubpenguin.mail.Postcard.getPostcardFromRawString(rawInbox[_loc1]));
        } // end of for
        return (_loc3);
    } // End of the function
} // End of Class
