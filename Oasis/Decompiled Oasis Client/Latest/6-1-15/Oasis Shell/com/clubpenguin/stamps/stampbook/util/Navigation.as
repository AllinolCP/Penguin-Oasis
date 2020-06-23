class com.clubpenguin.stamps.stampbook.util.Navigation extends com.clubpenguin.util.EventDispatcher
{
    var _shell, structure, indexList, currentSection, dispatchEvent, __get__children, __get__parentTitle, __get__title, __get__type;
    function Navigation(structure)
    {
        super();
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        this.structure = structure;
        indexList = [];
        this.update();
    } // End of the function
    function get title()
    {
        if (currentSection == structure)
        {
            return (_shell.getLocalizedString("contents_category_title"));
        }
        else
        {
            return (currentSection.getName());
        } // end else if
    } // End of the function
    function get parentTitle()
    {
        var _loc3 = indexList.length;
        var _loc2 = this.lookUp(_loc3 - 1);
        if (_loc2 == structure)
        {
            return (currentSection.getName());
        } // end if
        return (_loc2.getName());
    } // End of the function
    function get children()
    {
        if (currentSection == structure)
        {
            return (Array(currentSection));
        }
        else
        {
            return (currentSection.getSubCategories());
        } // end else if
    } // End of the function
    function get type()
    {
        return (null);
    } // End of the function
    function reset()
    {
        indexList = [];
        this.update();
    } // End of the function
    function next()
    {
        var _loc9 = indexList.slice(0);
        var _loc6 = false;
        while (true)
        {
            if (indexList.length == 0)
            {
                indexList.push(0);
                this.update();
                return;
            } // end if
            var _loc2 = indexList.length;
            var _loc7 = this.lookUp(_loc2);
            var _loc4 = _loc7.getSubCategories();
            if (!_loc6 && _loc4 != undefined && _loc4.length > 0)
            {
                indexList.push(0);
                this.update();
                return;
            } // end if
            _loc6 = false;
            var _loc8 = indexList[_loc2 - 1];
            var _loc3 = this.lookUp(_loc2 - 1);
            var _loc5;
            if (_loc3 == structure)
            {
                _loc5 = structure;
            }
            else
            {
                _loc5 = _loc3.getSubCategories();
            } // end else if
            if (_loc8 == _loc5.length - 1)
            {
                indexList.pop();
                _loc6 = true;
                if (indexList.length == 0)
                {
                    indexList = _loc9;
                    return;
                } // end if
                continue;
                continue;
            } // end if
            ++indexList[_loc2 - 1];
            this.update();
            break;
        } // end while
    } // End of the function
    function previous()
    {
        var _loc7 = indexList.slice(0);
        var _loc6 = false;
        if (indexList.length == 0)
        {
            return;
        } // end if
        var _loc4 = indexList.length;
        var _loc5 = indexList[_loc4 - 1];
        if (_loc5 == 0)
        {
            indexList.pop();
        }
        else
        {
            --indexList[_loc4 - 1];
            var _loc3 = this.lookUp(_loc4);
            for (var _loc2 = _loc3; _loc2.getSubCategories() != undefined && _loc2.getSubCategories().length > 0; _loc2 = _loc2[_loc2.length - 1])
            {
                var _loc2 = _loc2.getSubCategories();
                indexList.push(_loc2.length - 1);
            } // end of for
        } // end else if
        this.update();
        return;
    } // End of the function
    function update()
    {
        currentSection = this.lookUp();
        this.dispatchEvent({type: "change"});
    } // End of the function
    function lookUp(depth)
    {
        if (depth < 0)
        {
            return (null);
        } // end if
        if (depth == null)
        {
            depth = indexList.length;
        } // end if
        var _loc3 = structure;
        for (var _loc2 = 0; _loc2 < depth; ++_loc2)
        {
            if (_loc3 == structure)
            {
                _loc3 = _loc3[indexList[_loc2]];
                continue;
            } // end if
            _loc3 = _loc3.getSubCategories()[indexList[_loc2]];
        } // end of for
        return (_loc3);
    } // End of the function
    function addSection(id)
    {
        indexList.push(id);
        this.update();
    } // End of the function
    function removeSection()
    {
        indexList.pop();
        this.update();
    } // End of the function
    function goToSection(id)
    {
        indexList = [];
        indexList.push(id);
        this.update();
    } // End of the function
} // End of Class
