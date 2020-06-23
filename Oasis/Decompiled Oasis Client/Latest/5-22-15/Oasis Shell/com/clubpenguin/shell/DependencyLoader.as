class com.clubpenguin.shell.DependencyLoader extends com.clubpenguin.util.EventDispatcher
{
    var container, dependencies, isSnowball, updateListeners;
    function DependencyLoader(baseURL, container)
    {
        super();
        if (baseURL == undefined)
        {
            throw new Error("DependencyLoader -> baseURL is undefined! baseURL:" + baseURL);
        } // end if
        if (!container)
        {
            throw new Error("DependencyLoader -> container is not set! container:" + container);
        } // end if
        this.baseURL = baseURL;
        this.container = container;
    } // End of the function
    function load(dependencies, isSnowball)
    {
        if (!dependencies.length)
        {
            throw new Error("DependencyLoader.load -> dependencies array is not defined! dependencies: " + dependencies);
        } // end if
        this.dependencies = dependencies.concat();
        this.isSnowball = isSnowball;
        currentIndex = 0;
        this.loadDependency(dependencies[currentIndex]);
    } // End of the function
    function loadDependency(dependency)
    {
        currentID = dependency.id;
        if (container[currentID] != undefined)
        {
            container[currentID].removeMovieClip();
        } // end if
        var _loc5 = container.createEmptyMovieClip(currentID, container.getNextHighestDepth());
        var _loc6 = dependency.folder || "";
        var _loc2 = currentID;
        if (isSnowball == true)
        {
            if (currentID.toLowerCase() == "interface")
            {
                _loc2 = "interface_snowball";
            }
            else if (currentID == "engine")
            {
                _loc2 = "engine_snowball";
            } // end if
        } // end else if
        var _loc4 = com.clubpenguin.util.URLUtils.getCacheResetURL(baseURL + _loc6 + _loc2 + com.clubpenguin.shell.DependencyLoader.DEPENDENCY_FILE_EXTENSTION);
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onLoadProgress));
        _loc3.loadClip(_loc4, _loc5);
    } // End of the function
    function onLoadInit(event)
    {
        if (currentIndex >= dependencies.length - 1)
        {
            this.updateListeners(com.clubpenguin.shell.DependencyLoader.COMPLETE);
            return;
        } // end if
        ++currentIndex;
        this.loadDependency(dependencies[currentIndex]);
    } // End of the function
    function onLoadProgress(event)
    {
        event.dependencyTitle = dependencies[currentIndex].title;
        this.updateListeners(com.clubpenguin.shell.DependencyLoader.PROGRESS, event);
    } // End of the function
    static var COMPLETE = "complete";
    static var PROGRESS = "progress";
    static var DEPENDENCY_FILE_EXTENSTION = ".swf";
    var currentID = "";
    var currentIndex = -1;
    var baseURL = "";
} // End of Class
