package org.swiftsuspenders
{
    import flash.system.*;
    import flash.utils.*;
    import org.swiftsuspenders.injectionpoints.*;
    import org.swiftsuspenders.injectionresults.*;

    public class Injector extends Object
    {
        private var m_parentInjector:Injector;
        private var m_applicationDomain:ApplicationDomain;
        private var m_mappings:Dictionary;
        private var m_injectionPointLists:Dictionary;
        private var m_constructorInjectionPoints:Dictionary;
        private var m_attendedToInjectees:Dictionary;
        private var m_xmlMetadata:XML;

        public function Injector(param1:XML = null)
        {
            this.m_mappings = new Dictionary();
            this.m_injectionPointLists = new Dictionary();
            this.m_constructorInjectionPoints = new Dictionary();
            this.m_attendedToInjectees = new Dictionary(true);
            this.m_xmlMetadata = param1;
            return;
        }// end function

        public function mapValue(param1:Class, param2:Object, param3:String = "")
        {
            var _loc_4:* = this.getMapping(param1, param3);
            _loc_4.setResult(new InjectValueResult(param2));
            return _loc_4;
        }// end function

        public function mapClass(param1:Class, param2:Class, param3:String = "")
        {
            var _loc_4:* = this.getMapping(param1, param3);
            _loc_4.setResult(new InjectClassResult(param2));
            return _loc_4;
        }// end function

        public function mapSingleton(param1:Class, param2:String = "")
        {
            return this.mapSingletonOf(param1, param1, param2);
        }// end function

        public function mapSingletonOf(param1:Class, param2:Class, param3:String = "")
        {
            var _loc_4:* = this.getMapping(param1, param3);
            _loc_4.setResult(new InjectSingletonResult(param2));
            return _loc_4;
        }// end function

        public function mapRule(param1:Class, param2, param3:String = "")
        {
            var _loc_4:* = this.getMapping(param1, param3);
            _loc_4.setResult(new InjectOtherRuleResult(param2));
            return param2;
        }// end function

        public function getMapping(param1:Class, param2:String = "") : InjectionConfig
        {
            var _loc_3:* = getQualifiedClassName(param1);
            var _loc_4:* = this.m_mappings[_loc_3 + "#" + param2];
            if (!_loc_4)
            {
                var _loc_5:* = new InjectionConfig(param1, param2);
                this.m_mappings[_loc_3 + "#" + param2] = new InjectionConfig(param1, param2);
                _loc_4 = _loc_5;
            }
            return _loc_4;
        }// end function

        public function injectInto(param1:Object) : void
        {
            var _loc_2:Array = null;
            var _loc_6:InjectionPoint = null;
            if (this.m_attendedToInjectees[param1])
            {
                return;
            }
            this.m_attendedToInjectees[param1] = true;
            var _loc_3:* = getConstructor(param1);
            if (!this.m_injectionPointLists[_loc_3])
            {
            }
            _loc_2 = this.getInjectionPoints(_loc_3);
            var _loc_4:* = _loc_2.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_2[_loc_5];
                _loc_6.applyInjection(param1, this);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function instantiate(param1:Class)
        {
            var _loc_2:* = this.m_constructorInjectionPoints[param1];
            if (!_loc_2)
            {
                this.getInjectionPoints(param1);
                _loc_2 = this.m_constructorInjectionPoints[param1];
            }
            var _loc_3:* = _loc_2.applyInjection(param1, this);
            this.injectInto(_loc_3);
            return _loc_3;
        }// end function

        public function unmap(param1:Class, param2:String = "") : void
        {
            var _loc_3:* = this.getConfigurationForRequest(param1, param2);
            if (!_loc_3)
            {
                throw new InjectorError("Error while removing an injector mapping: " + "No mapping defined for class " + getQualifiedClassName(param1) + ", named \"" + param2 + "\"");
            }
            _loc_3.setResult(null);
            return;
        }// end function

        public function hasMapping(param1:Class, param2:String = "") : Boolean
        {
            var _loc_3:* = this.getConfigurationForRequest(param1, param2);
            if (!_loc_3)
            {
                return false;
            }
            return _loc_3.hasResponse(this);
        }// end function

        public function getInstance(param1:Class, param2:String = "")
        {
            var _loc_3:* = this.getConfigurationForRequest(param1, param2);
            if (_loc_3)
            {
            }
            if (!_loc_3.hasResponse(this))
            {
                throw new InjectorError("Error while getting mapping response: " + "No mapping defined for class " + getQualifiedClassName(param1) + ", named \"" + param2 + "\"");
            }
            return _loc_3.getResponse(this);
        }// end function

        public function createChildInjector(param1:ApplicationDomain = null) : Injector
        {
            var _loc_2:* = new Injector();
            _loc_2.setApplicationDomain(param1);
            _loc_2.setParentInjector(this);
            return _loc_2;
        }// end function

        public function setApplicationDomain(param1:ApplicationDomain) : void
        {
            this.m_applicationDomain = param1;
            return;
        }// end function

        public function getApplicationDomain() : ApplicationDomain
        {
            return this.m_applicationDomain ? (this.m_applicationDomain) : (ApplicationDomain.currentDomain);
        }// end function

        public function setParentInjector(param1:Injector) : void
        {
            if (this.m_parentInjector)
            {
            }
            if (!param1)
            {
                this.m_attendedToInjectees = new Dictionary(true);
            }
            this.m_parentInjector = param1;
            if (param1)
            {
                this.m_attendedToInjectees = param1.attendedToInjectees;
            }
            return;
        }// end function

        public function getParentInjector() : Injector
        {
            return this.m_parentInjector;
        }// end function

        function getAncestorMapping(param1:Class, param2:String = null) : InjectionConfig
        {
            var _loc_4:InjectionConfig = null;
            var _loc_3:* = this.m_parentInjector;
            while (_loc_3)
            {
                
                _loc_4 = _loc_3.getConfigurationForRequest(param1, param2, false);
                if (_loc_4)
                {
                }
                if (_loc_4.hasOwnResponse())
                {
                    return _loc_4;
                }
                _loc_3 = _loc_3.getParentInjector();
            }
            return null;
        }// end function

        function get attendedToInjectees() : Dictionary
        {
            return this.m_attendedToInjectees;
        }// end function

        private function getInjectionPoints(param1:Class) : Array
        {
            var node:XML;
            var injectionPoint:InjectionPoint;
            var postConstructMethodPoints:Array;
            var clazz:* = param1;
            var description:* = describeType(clazz);
            var injectionPoints:Array;
            this.m_injectionPointLists[clazz] = injectionPoints;
            this.m_injectionPointLists[description.@name.toString()] = injectionPoints;
            if (this.m_xmlMetadata)
            {
                this.createInjectionPointsFromConfigXML(description);
                this.addParentInjectionPoints(description, injectionPoints);
            }
            node = description.factory.constructor[0];
            if (node)
            {
                this.m_constructorInjectionPoints[clazz] = new ConstructorInjectionPoint(node, clazz, this);
            }
            else
            {
                this.m_constructorInjectionPoints[clazz] = new NoParamsConstructorInjectionPoint();
            }
            var _loc_3:int = 0;
            var _loc_6:int = 0;
            var _loc_9:int = 0;
            var _loc_10:* = description.factory.*;
            var _loc_8:* = new XMLList("");
            for each (_loc_11 in _loc_10)
            {
                
                var _loc_12:* = _loc_11;
                with (_loc_11)
                {
                    if (name() != "variable")
                    {
                    }
                    if (name() == "accessor")
                    {
                        _loc_8[_loc_9] = _loc_11;
                    }
                }
            }
            var _loc_7:* = _loc_8.metadata;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (@name == "Inject")
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5;
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                injectionPoint = new PropertyInjectionPoint(node, this);
                injectionPoints.push(injectionPoint);
            }
            var _loc_3:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = description.factory.method.metadata;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (@name == "Inject")
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5;
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                injectionPoint = new MethodInjectionPoint(node, this);
                injectionPoints.push(injectionPoint);
            }
            postConstructMethodPoints;
            var _loc_3:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = description.factory.method.metadata;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (@name == "PostConstruct")
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5;
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                injectionPoint = new PostConstructInjectionPoint(node, this);
                postConstructMethodPoints.push(injectionPoint);
            }
            if (postConstructMethodPoints.length > 0)
            {
                postConstructMethodPoints.sortOn("order", Array.NUMERIC);
                injectionPoints.push.apply(injectionPoints, postConstructMethodPoints);
            }
            return injectionPoints;
        }// end function

        private function getConfigurationForRequest(param1:Class, param2:String, param3:Boolean = true) : InjectionConfig
        {
            var _loc_4:* = getQualifiedClassName(param1);
            var _loc_5:* = this.m_mappings[_loc_4 + "#" + param2];
            if (!_loc_5)
            {
            }
            if (param3)
            {
            }
            if (this.m_parentInjector)
            {
            }
            if (this.m_parentInjector.hasMapping(param1, param2))
            {
                _loc_5 = this.getAncestorMapping(param1, param2);
            }
            return _loc_5;
        }// end function

        private function createInjectionPointsFromConfigXML(param1:XML) : void
        {
            var node:XML;
            var className:String;
            var metaNode:XML;
            var typeNode:XML;
            var arg:XML;
            var description:* = param1;
            var _loc_3:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = description..metadata;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (@name != "Inject")
                    {
                    }
                    if (@name == "PostConstruct")
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5;
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                var _loc_6:int = 0;
                var _loc_7:* = node.parent().metadata;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    
                    var _loc_9:* = _loc_8;
                    with (_loc_8)
                    {
                        if (@name != "Inject")
                        {
                        }
                        if (@name == "PostConstruct")
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }
                    }
                }
                delete _loc_5[0];
            }
            className = description.factory.@type;
            var _loc_3:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = this.m_xmlMetadata.type;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_8;
                with (_loc_8)
                {
                    if (@name == className)
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5.children();
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                metaNode = <metadata/>")("<metadata/>;
                if (node.name() == "postconstruct")
                {
                    metaNode.@name = "PostConstruct";
                    if (node.@order.length())
                    {
                        metaNode.appendChild(new XML("<arg key=\'order\' value=\"" + node.@order + "\"/>"));
                    }
                }
                else
                {
                    metaNode.@name = "Inject";
                    if (node.@injectionname.length())
                    {
                        metaNode.appendChild(new XML("<arg key=\'name\' value=\"" + node.@injectionname + "\"/>"));
                    }
                    var _loc_5:int = 0;
                    var _loc_6:* = node.arg;
                    while (_loc_6 in _loc_5)
                    {
                        
                        arg = _loc_6[_loc_5];
                        metaNode.appendChild(new XML("<arg key=\'name\' value=\"" + arg.@injectionname + "\"/>"));
                    }
                }
                if (node.name() == "constructor")
                {
                    typeNode = description.factory[0];
                }
                else
                {
                    var _loc_6:int = 0;
                    var _loc_7:* = description.factory.*;
                    var _loc_5:* = new XMLList("");
                    for each (_loc_8 in _loc_7)
                    {
                        
                        var _loc_9:* = _loc_8;
                        with (_loc_8)
                        {
                            if (attribute("name") == node.@name)
                            {
                                _loc_5[_loc_6] = _loc_8;
                            }
                        }
                    }
                    typeNode = _loc_5[0];
                    if (!typeNode)
                    {
                        throw new InjectorError("Error in XML configuration: Class \"" + className + "\" doesn\'t contain the instance member \"" + node.@name + "\"");
                    }
                }
                typeNode.appendChild(metaNode);
            }
            return;
        }// end function

        private function addParentInjectionPoints(param1:XML, param2:Array) : void
        {
            var _loc_3:* = param1.factory.extendsClass.@type[0];
            if (!_loc_3)
            {
                return;
            }
            if (!this.m_injectionPointLists[_loc_3])
            {
            }
            var _loc_4:* = this.getInjectionPoints(Class(getDefinitionByName(_loc_3)));
            param2.push.apply(param2, _loc_4);
            return;
        }// end function

    }
}
