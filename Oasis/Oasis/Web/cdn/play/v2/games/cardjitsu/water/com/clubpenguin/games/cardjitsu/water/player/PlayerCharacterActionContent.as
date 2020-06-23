class com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterActionContent extends com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterAction
{
    var __data, content;
    function PlayerCharacterActionContent()
    {
        super();
    } // End of the function
    function setElementFromData()
    {
        if (!isNaN(__data))
        {
            content.config(__data + 1);
        } // end if
    } // End of the function
} // End of Class
