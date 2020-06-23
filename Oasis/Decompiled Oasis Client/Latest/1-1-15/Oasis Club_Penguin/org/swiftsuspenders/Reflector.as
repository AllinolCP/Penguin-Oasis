package org.swiftsuspenders
{
    import flash.system.*;
    import flash.utils.*;

    public class Reflector extends Object
    {

        public function Reflector()
        {
            return;
        }// end function

        public function classExtendsOrImplements(param1:Object, param2:Class, param3:ApplicationDomain = null) : Boolean
        {
            var actualClass:Class;
            var classOrClassName:* = param1;
            var superclass:* = param2;
            var application:* = param3;
            if (classOrClassName is Class)
            {
                actualClass = Class(classOrClassName);
            }
            else if (classOrClassName is String)
            {
                try
                {
                    actualClass = Class(getDefinitionByName(classOrClassName as String));
                }
                catch (e:Error)
                {
                    throw new Error("The class name " + classOrClassName + " is not valid because of " + e + "\n" + e.getStackTrace());
                }
            }
            if (!actualClass)
            {
                throw new Error("The parameter classOrClassName must be a valid Class " + "instance or fully qualified class name.");
            }
            if (actualClass == superclass)
            {
                return true;
            }
            var factoryDescription:* = describeType(actualClass).factory[0];
            var _loc_6:int = 0;
            var _loc_9:int = 0;
            var _loc_10:* = factoryDescription.children();
            var _loc_8:* = new XMLList("");
            for each (_loc_11 in _loc_10)
            {
                
                var _loc_12:* = _loc_11;
                with (_loc_11)
                {
                    if (name() != "implementsInterface")
                    {
                    }
                    if (name() == "extendsClass")
                    {
                        _loc_8[_loc_9] = _loc_11;
                    }
                }
            }
            var _loc_7:* = _loc_8;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (attribute("type") == getQualifiedClassName(superclass))
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            return _loc_5.length() > 0;
        }// end function

        public function getClass(param1, param2:ApplicationDomain = null) : Class
        {
            if (param1 is Class)
            {
                return param1;
            }
            return getConstructor(param1);
        }// end function

        public function getFQCN(param1, param2:Boolean = false) : String
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            if (param1 is String)
            {
                _loc_3 = param1;
                if (!param2)
                {
                }
                if (_loc_3.indexOf("::") == -1)
                {
                    _loc_4 = _loc_3.lastIndexOf(".");
                    if (_loc_4 == -1)
                    {
                        return _loc_3;
                    }
                    return _loc_3.substring(0, _loc_4) + "::" + _loc_3.substring((_loc_4 + 1));
                }
            }
            else
            {
                _loc_3 = getQualifiedClassName(param1);
            }
            return param2 ? (_loc_3.replace("::", ".")) : (_loc_3);
        }// end function

    }
}
