class com.clubpenguin.stamps.PinItem implements com.clubpenguin.stamps.IStampBookItem
{
    var id, name, description, isMemberItem;
    function PinItem(id, name, description, isMemberItem)
    {
        this.id = id;
        this.name = name;
        this.description = description;
        this.isMemberItem = isMemberItem;
    } // End of the function
    function getType()
    {
        return (com.clubpenguin.stamps.StampBookItemType.PIN);
    } // End of the function
    function getID()
    {
        return (id);
    } // End of the function
    function setID(id)
    {
        this.id = id;
    } // End of the function
    function getName()
    {
        return (name);
    } // End of the function
    function setName(name)
    {
        this.name = name;
    } // End of the function
    function getDescription()
    {
        return (description);
    } // End of the function
    function setDescription(description)
    {
        this.description = description;
    } // End of the function
    function getIsMemberItem()
    {
        return (isMemberItem);
    } // End of the function
    function setIsMemberItem(isMemberItem)
    {
        this.isMemberItem = isMemberItem;
    } // End of the function
} // End of Class
