class com.clubpenguin.shell.Music
{
    var container, musicClip;
    function Music(container)
    {
        this.container = container;
    } // End of the function
    function playMusicURL(url)
    {
        if (isMuted || url == currentURL)
        {
            return (false);
        } // end if
        if (url.length)
        {
            musicClip = container.createEmptyMovieClip("music", 0);
            currentURL = url;
            var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
            musicClip.loadMovie(_loc3);
            return (true);
        } // end if
        this.stopMusic();
        return (false);
    } // End of the function
    function stopMusic()
    {
        if (!currentURL.length)
        {
            return (false);
        } // end if
        musicClip.removeMovieClip();
        currentURL = "";
        return (true);
    } // End of the function
    function muteMusic()
    {
        isMuted = true;
        this.stopMusic();
    } // End of the function
    function unMuteMusic()
    {
        isMuted = false;
    } // End of the function
    function isMusicMuted()
    {
        return (isMuted);
    } // End of the function
    var currentURL = "";
    var isMuted = false;
} // End of Class
