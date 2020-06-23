class com.clubpenguin.shell.AbstractPuffleModel
{
    var __get__health, __get__hunger, __get__rest, __get__maxHealth, __get__maxHunger, __get__maxRest, _id, __get__id, _typeID, __get__typeID, _health, _hunger, _rest, _maxHealth, _maxHunger, _maxRest, __get__happy, __set__health, __set__hunger, __set__id, __set__maxHealth, __set__maxHunger, __set__maxRest, __set__rest, __set__typeID;
    function AbstractPuffleModel()
    {
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function get happy()
    {
        var _loc3 = this.__get__health() + this.__get__hunger() + this.__get__rest();
        var _loc2 = this.__get__maxHealth() + this.__get__maxHunger() + this.__get__maxRest();
        return (Math.round(_loc3 / _loc2 * 100));
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function set id(id)
    {
        _id = id;
        //return (this.id());
        null;
    } // End of the function
    function get typeID()
    {
        return (_typeID);
    } // End of the function
    function set typeID(id)
    {
        _typeID = id;
        //return (this.typeID());
        null;
    } // End of the function
    function get health()
    {
        return (_health);
    } // End of the function
    function set health(health)
    {
        if (health < 0)
        {
            health = 0;
        } // end if
        _health = health;
        //return (this.health());
        null;
    } // End of the function
    function get hunger()
    {
        return (_hunger);
    } // End of the function
    function set hunger(hunger)
    {
        if (hunger < 0)
        {
            hunger = 0;
        } // end if
        _hunger = hunger;
        //return (this.hunger());
        null;
    } // End of the function
    function get rest()
    {
        return (_rest);
    } // End of the function
    function set rest(rest)
    {
        if (rest < 0)
        {
            rest = 0;
        } // end if
        _rest = rest;
        //return (this.rest());
        null;
    } // End of the function
    function get maxHealth()
    {
        return (_maxHealth);
    } // End of the function
    function set maxHealth(maxHealth)
    {
        _maxHealth = maxHealth;
        //return (this.maxHealth());
        null;
    } // End of the function
    function get maxHunger()
    {
        return (_maxHunger);
    } // End of the function
    function set maxHunger(maxHunger)
    {
        _maxHunger = maxHunger;
        //return (this.maxHunger());
        null;
    } // End of the function
    function get maxRest()
    {
        return (_maxRest);
    } // End of the function
    function set maxRest(maxRest)
    {
        _maxRest = maxRest;
        //return (this.maxRest());
        null;
    } // End of the function
    function cleanUp()
    {
        _id = null;
        _typeID = null;
        _health = null;
        _hunger = null;
        _rest = null;
        _maxHealth = null;
        _maxHunger = null;
        _maxRest = null;
    } // End of the function
} // End of Class
