class com.clubpenguin.games.cardjitsu.water.SoundManager
{
    var __rootSFX;
    static var __instance;
    function SoundManager()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.games.cardjitsu.water.SoundManager.__instance == null)
        {
            __instance = new com.clubpenguin.games.cardjitsu.water.SoundManager();
        } // end if
        return (com.clubpenguin.games.cardjitsu.water.SoundManager.__instance);
    } // End of the function
    function initalize(Void)
    {
        __rootSFX = com.clubpenguin.games.cardjitsu.water.DisplayManager.getDisplayLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_SFX);
        if (!__rootSFX)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function add(_soundName, _loopCount, _volume)
    {
        if (!__rootSFX)
        {
            if (!this.initalize())
            {
                return;
            } // end if
        } // end if
        if (!_loopCount || _loopCount < 1)
        {
            _loopCount = 1;
        } // end if
        _volume = this.validateVolume(_volume);
        __rootSFX[_soundName + "Sound"] = new Sound(__rootSFX.createEmptyMovieClip(_soundName + "Sfx", __rootSFX.getNextHighestDepth()));
        (Sound)(__rootSFX[_soundName + "Sound"]).setVolume(_volume);
        (Sound)(__rootSFX[_soundName + "Sound"]).attachSound(_soundName);
        (Sound)(__rootSFX[_soundName + "Sound"]).start(0, _loopCount);
    } // End of the function
    function setVolume(_soundName, _newVolume)
    {
        if (!__rootSFX)
        {
            if (!this.initalize())
            {
                return;
            } // end if
        } // end if
        _newVolume = this.validateVolume(_newVolume);
        if (__rootSFX[_soundName + "Sound"])
        {
            (Sound)(__rootSFX[_soundName + "Sound"]).setVolume(_newVolume);
        } // end if
    } // End of the function
    function getVolume(soundName)
    {
        if (__rootSFX[soundName + "Sound"])
        {
            return ((Sound)(__rootSFX[soundName + "Sound"]).getVolume());
        } // end if
    } // End of the function
    function stop(soundName)
    {
        if (__rootSFX[soundName + "Sound"])
        {
            (Sound)(__rootSFX[soundName + "Sound"]).stop();
        } // end if
    } // End of the function
    function validateVolume(_volume)
    {
        if (!_volume)
        {
            return (50);
        } // end if
        if (_volume < 1)
        {
            return (1);
        } // end if
        if (_volume > 100)
        {
            return (100);
        } // end if
        return (_volume);
    } // End of the function
} // End of Class
