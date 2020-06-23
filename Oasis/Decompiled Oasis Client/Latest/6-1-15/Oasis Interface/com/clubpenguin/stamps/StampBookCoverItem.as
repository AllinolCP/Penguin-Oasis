class com.clubpenguin.stamps.StampBookCoverItem implements com.clubpenguin.stamps.IStampBookCoverItem
{
    var item, position, rotation, depth;
    function StampBookCoverItem(item, position, rotation, depth)
    {
        this.item = item;
        this.position = position;
        this.rotation = rotation;
        this.depth = depth;
    } // End of the function
    function getItem()
    {
        return (item);
    } // End of the function
    function setItem(item)
    {
        this.item = item;
    } // End of the function
    function getItemPosition()
    {
        return (position);
    } // End of the function
    function setItemPosition(position)
    {
        this.position = position;
    } // End of the function
    function getItemRotation()
    {
        return (rotation);
    } // End of the function
    function setItemRotation(rotation)
    {
        this.rotation = rotation;
    } // End of the function
    function getItemDepth()
    {
        return (depth);
    } // End of the function
    function setItemDepth(depth)
    {
        this.depth = depth;
    } // End of the function
} // End of Class
