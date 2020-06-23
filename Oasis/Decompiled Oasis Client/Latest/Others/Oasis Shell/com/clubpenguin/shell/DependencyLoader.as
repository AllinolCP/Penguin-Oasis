class com.clubpenguin.shell.DependencyLoader extends com.clubpenguin.util.EventDispatcher
{
    var container, dependencies, updateListeners;
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
    function load(dependencies)
    {
        if (!dependencies.length)
        {
            throw new Error("DependencyLoader.load -> dependencies array is not defined! dependencies: " + dependencies);
        } // end if
        this.dependencies = dependencies.concat();
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
        var _loc4 = container.createEmptyMovieClip(currentID, container.getNextHighestDepth());
        var _loc5 = dependency.folder || "";
        var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(baseURL + _loc5 + currentID + com.clubpenguin.shell.DependencyLoader.DEPENDENCY_FILE_EXTENSTION);
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onLoadProgress));
        _loc2.loadClip(_loc3, _loc4);
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
