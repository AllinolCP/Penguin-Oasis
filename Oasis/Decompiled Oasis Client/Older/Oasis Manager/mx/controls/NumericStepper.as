class mx.controls.NumericStepper extends mx.core.UIComponent
{
    var boundingBox_mc, _visible, tabEnabled, tabChildren, nextButton_mc, __width, prevButton_mc, __height, inputField, StepTrack_mc, focusTextField, createObject, enabled, __set__visible, setSize, createClassObject, owner, __maxChars, _parent, __get__value, __set__value, dispatchEvent, __get__stepSize, __get__maxChars, __get__minimum, __get__maximum, __get__tabIndex, __set__maxChars, __set__maximum, __set__minimum, __get__nextValue, __get__previousValue, __set__stepSize, __set__tabIndex;
    function NumericStepper()
    {
        super();
    } // End of the function
    function init()
    {
        super.init();
        boundingBox_mc._visible = false;
        boundingBox_mc._width = boundingBox_mc._height = 0;
        _visible = false;
        tabEnabled = false;
        tabChildren = true;
    } // End of the function
    function setVisible(x, noEvent)
    {
        super.setVisible(x, noEvent);
        if (initializing)
        {
            __visible = x;
        } // end if
    } // End of the function
    function layoutControl()
    {
        nextButton_mc._x = __width - nextButton_mc.__width;
        nextButton_mc._y = 0;
        prevButton_mc._x = __width - prevButton_mc.__width;
        prevButton_mc._y = __height - prevButton_mc.__height;
        inputField.setSize(__width - nextButton_mc.__width, __height);
        StepTrack_mc._width = Math.max(nextButton_mc.__width, prevButton_mc.__width);
        StepTrack_mc._x = __width - StepTrack_mc._width;
        StepTrack_mc._height = __height - (nextButton_mc._height + prevButton_mc._height);
        StepTrack_mc._y = nextButton_mc.__height;
    } // End of the function
    function createChildren()
    {
        super.createChildren();
        this.addAsset("nextButton_mc", skinIDUpArrow);
        this.addAsset("prevButton_mc", skinIDDownArrow);
        this.addAsset("inputField", skinIDInput);
        focusTextField = inputField.label;
        this.createObject("StepTrack", "StepTrack_mc", 2);
        this.size();
    } // End of the function
    function draw()
    {
        prevButton_mc.enabled = enabled;
        nextButton_mc.enabled = enabled;
        inputField.enabled = enabled;
        this.size();
        initializing = false;
        this.__set__visible(__visible);
    } // End of the function
    function size()
    {
        var _loc2 = this.calcMinHeight();
        var _loc3 = this.calcMinWidth();
        if (__height < _loc2)
        {
            this.setSize(__width, _loc2);
        } // end if
        if (__width < _loc3)
        {
            this.setSize(_loc3, __height);
        } // end if
        this.layoutControl();
    } // End of the function
    function calcMinHeight()
    {
        return (22);
    } // End of the function
    function calcMinWidth()
    {
        return (40);
    } // End of the function
    function addAsset(id, skinID)
    {
        var _loc2 = new Object();
        _loc2.styleName = this;
        if (skinID == 10)
        {
            _loc2.falseUpSkin = upArrowUp;
            _loc2.falseOverSkin = upArrowOver;
            _loc2.falseDownSkin = upArrowDown;
            _loc2.falseDisabledSkin = upArrowDisabled;
            this.createClassObject(mx.controls.SimpleButton, id, skinID, _loc2);
            var _loc5 = nextButton_mc;
            _loc5.tabEnabled = false;
            _loc5.styleName = this;
            _loc5._x = __width - _loc5.__width;
            _loc5._y = 0;
            _loc5.owner = this;
            _loc5.autoRepeat = true;
            _loc5.clickHandler = function ()
            {
                Selection.setSelection(0, 0);
            };
            _loc5.buttonDownHandler = function ()
            {
                owner.buttonPress(this);
            };
        }
        else if (skinID == 11)
        {
            _loc2.falseUpSkin = downArrowUp;
            _loc2.falseOverSkin = downArrowOver;
            _loc2.falseDownSkin = downArrowDown;
            _loc2.falseDisabledSkin = downArrowDisabled;
            this.createClassObject(mx.controls.SimpleButton, id, skinID, _loc2);
            var _loc3 = prevButton_mc;
            _loc3.tabEnabled = false;
            _loc3.styleName = this;
            _loc3._x = __width - _loc3.__width;
            _loc3._y = __height - _loc3.__height;
            _loc3.owner = this;
            _loc3.autoRepeat = true;
            _loc3.clickHandler = function ()
            {
                Selection.setSelection(0, 0);
            };
            _loc3.buttonDownHandler = function ()
            {
                owner.buttonPress(this);
            };
        }
        else if (skinID == 9)
        {
            this.createClassObject(mx.controls.TextInput, id, skinID);
            var _loc4 = inputField;
            _loc4.styleName = this;
            _loc4.setSize(__width - nextButton_mc.__width, __height);
            _loc4.restrict = "0-9\\-\\.\\,";
            _loc4.maxChars = __maxChars;
            _loc4.text = value;
            _loc4.onSetFocus = function ()
            {
                _parent.onSetFocus();
            };
            _loc4.onKillFocus = function ()
            {
                _parent.onKillFocus();
            };
            _loc4.drawFocus = function (b)
            {
                _parent.drawFocus(b);
            };
            _loc4.onKeyDown = function ()
            {
                _parent.onFieldKeyDown();
            };
        } // end else if
    } // End of the function
    function setFocus()
    {
        Selection.setFocus(inputField);
    } // End of the function
    function onKillFocus()
    {
        mx.managers.SystemManager.form.focusManager.defaultPushButtonEnabled = true;
        super.onKillFocus();
        Key.removeListener(inputField);
        if (Number(inputField.text) != this.__get__value())
        {
            var _loc3 = this.checkValidValue(Number(inputField.text));
            inputField.text = _loc3;
            this.__set__value(_loc3);
            this.dispatchEvent({type: "change"});
        } // end if
    } // End of the function
    function onSetFocus()
    {
        super.onSetFocus();
        Key.addListener(inputField);
        mx.managers.SystemManager.form.focusManager.defaultPushButtonEnabled = false;
    } // End of the function
    function onFieldKeyDown()
    {
        var _loc2 = this.__get__value();
        switch (Key.getCode())
        {
            case 40:
            {
                var _loc3 = this.__get__value() - this.__get__stepSize();
                this.__set__value(_loc3);
                if (_loc2 != this.__get__value())
                {
                    this.dispatchEvent({type: "change"});
                } // end if
                break;
            } 
            case 38:
            {
                _loc3 = this.__get__stepSize() + this.__get__value();
                this.__set__value(_loc3);
                if (_loc2 != this.__get__value())
                {
                    this.dispatchEvent({type: "change"});
                } // end if
                break;
            } 
            case 36:
            {
                inputField.text = minimum;
                this.__set__value(minimum);
                if (_loc2 != this.__get__value())
                {
                    this.dispatchEvent({type: "change"});
                } // end if
                break;
            } 
            case 35:
            {
                inputField.text = maximum;
                this.__set__value(maximum);
                if (_loc2 != this.__get__value())
                {
                    this.dispatchEvent({type: "change"});
                } // end if
                break;
            } 
            case 13:
            {
                this.__set__value(Number(inputField.text));
                if (_loc2 != this.__get__value())
                {
                    this.dispatchEvent({type: "change"});
                } // end if
            } 
        } // End of switch
    } // End of the function
    function get nextValue()
    {
        if (this.checkRange(this.__get__value() + this.__get__stepSize()))
        {
            __nextValue = this.__get__value() + this.__get__stepSize();
            return (__nextValue);
        } // end if
    } // End of the function
    function get previousValue()
    {
        if (this.checkRange(__value - this.__get__stepSize()))
        {
            __previousValue = this.__get__value() - this.__get__stepSize();
            return (__previousValue);
        } // end if
    } // End of the function
    function set maxChars(num)
    {
        __maxChars = num;
        inputField.maxChars = __maxChars;
        //return (this.maxChars());
        null;
    } // End of the function
    function get maxChars()
    {
        return (__maxChars);
    } // End of the function
    function get value()
    {
        return (__value);
    } // End of the function
    function set value(v)
    {
        var _loc2 = this.checkValidValue(v);
        if (_loc2 == __value)
        {
            return;
        } // end if
        inputField.text = __value = _loc2;
        //return (this.value());
        null;
    } // End of the function
    function get minimum()
    {
        return (__minimum);
    } // End of the function
    function set minimum(v)
    {
        __minimum = v;
        //return (this.minimum());
        null;
    } // End of the function
    function get maximum()
    {
        return (__maximum);
    } // End of the function
    function set maximum(v)
    {
        __maximum = v;
        //return (this.maximum());
        null;
    } // End of the function
    function get stepSize()
    {
        return (__stepSize);
    } // End of the function
    function set stepSize(v)
    {
        __stepSize = v;
        //return (this.stepSize());
        null;
    } // End of the function
    function onFocus()
    {
    } // End of the function
    function buttonPress(button)
    {
        var _loc2 = this.__get__value();
        if (button._name == "nextButton_mc")
        {
            value = value + stepSize;
        }
        else
        {
            value = value - stepSize;
        } // end else if
        if (_loc2 != this.__get__value())
        {
            this.dispatchEvent({type: "change"});
            Selection.setSelection(0, 0);
        } // end if
    } // End of the function
    function checkRange(v)
    {
        //return (v >= this.minimum() && v <= this.__get__maximum());
    } // End of the function
    function checkValidValue(val)
    {
        var _loc7 = val / this.__get__stepSize();
        var _loc9 = Math.floor(_loc7);
        var _loc2 = this.__get__stepSize();
        var _loc6 = this.__get__minimum();
        var _loc5 = this.__get__maximum();
        if (val > _loc6 && val < _loc5)
        {
            if (_loc7 - _loc9 == 0)
            {
                return (val);
            }
            else
            {
                var _loc8 = Math.floor(val / _loc2);
                var _loc4 = _loc8 * _loc2;
                if (val - _loc4 >= _loc2 / 2 && _loc5 >= _loc4 + _loc2 && _loc6 <= _loc4 - _loc2 || val + _loc2 == _loc5 && _loc5 - _loc4 - _loc2 > 0.000000)
                {
                    _loc4 = _loc4 + _loc2;
                } // end if
                return (_loc4);
            } // end else if
        }
        else if (val >= _loc5)
        {
            return (_loc5);
        }
        else
        {
            return (_loc6);
        } // end else if
    } // End of the function
    function onLabelChanged(o)
    {
        var _loc2 = this.checkValidValue(Number(o.__get__text()));
        o.__set__text(_loc2);
        this.__set__value(_loc2);
    } // End of the function
    function get tabIndex()
    {
        return (inputField.tabIndex);
    } // End of the function
    function set tabIndex(w)
    {
        inputField.tabIndex = w;
        //return (this.tabIndex());
        null;
    } // End of the function
    static var symbolName = "NumericStepper";
    static var symbolOwner = mx.controls.NumericStepper;
    static var version = "2.0.2.127";
    var className = "NumericStepper";
    var upArrowUp = "StepUpArrowUp";
    var upArrowDown = "StepUpArrowDown";
    var upArrowOver = "StepUpArrowOver";
    var upArrowDisabled = "StepUpArrowDisabled";
    var downArrowUp = "StepDownArrowUp";
    var downArrowDown = "StepDownArrowDown";
    var downArrowOver = "StepDownArrowOver";
    var downArrowDisabled = "StepDownArrowDisabled";
    var skinIDUpArrow = 10;
    var skinIDDownArrow = 11;
    var skinIDInput = 9;
    var initializing = true;
    var __visible = true;
    var __minimum = 0;
    var __maximum = 10;
    var __stepSize = 1;
    var __value = 0;
    var __nextValue = 0;
    var __previousValue = 0;
    var clipParameters = {minimum: 1, maximum: 1, stepSize: 1, value: 1, maxChars: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.controls.NumericStepper.prototype.clipParameters, mx.core.UIComponent.prototype.clipParameters);
} // End of Class
