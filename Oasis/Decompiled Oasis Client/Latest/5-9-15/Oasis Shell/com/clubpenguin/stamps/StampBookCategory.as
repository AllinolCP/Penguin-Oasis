class com.clubpenguin.stamps.StampBookCategory implements com.clubpenguin.stamps.IStampBookCategory
{
    var id, name, subCategories, stampBookItems, polaroids;
    function StampBookCategory(id, name, subCategories, stampBookItems, polaroids)
    {
        this.id = id;
        this.name = name;
        this.subCategories = subCategories;
        this.stampBookItems = stampBookItems;
        this.polaroids = polaroids;
    } // End of the function
    function destroy()
    {
        var _loc3 = subCategories.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            subCategories[_loc2].destroy();
        } // end of for
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
    function getSubCategories()
    {
        return (subCategories);
    } // End of the function
    function setSubCategories(subCategories)
    {
        this.subCategories = subCategories;
    } // End of the function
    function addSubCategory(subCategory)
    {
        if (subCategories == undefined)
        {
            subCategories = [];
        } // end if
        subCategories.push(subCategory);
    } // End of the function
    function getItems()
    {
        return (stampBookItems);
    } // End of the function
    function setItems(stampBookItems)
    {
        this.stampBookItems = stampBookItems;
    } // End of the function
    function getPolaroids()
    {
        return (polaroids);
    } // End of the function
    function setPolaroids(polaroids)
    {
        this.polaroids = polaroids;
    } // End of the function
} // End of Class
