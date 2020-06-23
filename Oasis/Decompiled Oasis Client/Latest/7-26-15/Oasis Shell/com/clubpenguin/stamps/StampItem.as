class com.clubpenguin.stamps.StampItem implements com.clubpenguin.stamps.IStampItem
{
    var id, mainCategoryID, difficulty, name, description, isMemberItem;
    function StampItem(id, mainCategoryID, difficulty, name, description, isMemberItem)
    {
        this.id = id;
        this.mainCategoryID = mainCategoryID;
        this.difficulty = difficulty;
        this.name = name;
        this.description = description;
        this.isMemberItem = isMemberItem;
    } // End of the function
    function getMainCategoryID()
    {
        return (mainCategoryID);
    } // End of the function
    function setMainCategoryID(id)
    {
        mainCategoryID = id;
    } // End of the function
    function getType()
    {
        return (com.clubpenguin.stamps.StampBookItemType.STAMP);
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
    function getDifficulty()
    {
        return (difficulty);
    } // End of the function
    function setDifficulty(difficulty)
    {
        this.difficulty = difficulty;
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
