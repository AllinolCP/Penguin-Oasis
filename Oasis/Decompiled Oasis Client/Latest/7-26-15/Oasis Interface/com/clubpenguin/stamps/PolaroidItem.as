class com.clubpenguin.stamps.PolaroidItem implements com.clubpenguin.stamps.IPolaroidItem
{
    var id, numStampsToUnlock, name, description;
    function PolaroidItem(id, numStampsToUnlock, name, description)
    {
        this.id = id;
        this.numStampsToUnlock = numStampsToUnlock;
        this.name = name;
        this.description = description;
    } // End of the function
    function getType()
    {
        return (com.clubpenguin.stamps.StampBookItemType.POLAROID);
    } // End of the function
    function getID()
    {
        return (id);
    } // End of the function
    function setID(id)
    {
        this.id = id;
    } // End of the function
    function getNumStampsToUnlock()
    {
        return (numStampsToUnlock);
    } // End of the function
    function setNumStampsToUnlock(numStampsToUnlock)
    {
        this.numStampsToUnlock = numStampsToUnlock;
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
        return (false);
    } // End of the function
    function setIsMemberItem(isMemberItem)
    {
    } // End of the function
} // End of Class
