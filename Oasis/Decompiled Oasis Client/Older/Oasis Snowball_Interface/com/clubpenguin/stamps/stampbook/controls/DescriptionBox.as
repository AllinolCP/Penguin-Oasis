class com.clubpenguin.stamps.stampbook.controls.DescriptionBox extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
    var _singleLine, __get__singleLine, title_txt, _data, tooltipRightSideClip, descriptionSingleLine_txt, description_txt, tooltipMiddleSideClip, tooltipLeftSideClip, __set__singleLine;
    function DescriptionBox()
    {
        super();
        _singleLine = false;
    } // End of the function
    function set singleLine(flag)
    {
        _singleLine = flag;
        null;
        //return (this.singleLine());
        null;
    } // End of the function
    function populateUI()
    {
        var _loc3 = 0;
        var _loc2;
        title_txt.text = _data.getName();
        tooltipRightSideClip.memberBadge._visible = _data.getIsMemberItem();
        if (_singleLine)
        {
            _loc2 = descriptionSingleLine_txt;
            descriptionSingleLine_txt.text = _data.getDescription();
            descriptionSingleLine_txt._width = descriptionSingleLine_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_DESCRIPTION_TEXT_PADDING;
            if (descriptionSingleLine_txt._width < title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING)
            {
                descriptionSingleLine_txt._width = title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING;
            } // end if
        }
        else
        {
            _loc2 = description_txt;
            description_txt.text = _data.getDescription();
            description_txt._width = title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.DESCRIPTION_TEXT_WIDTH_PADDING;
            if (description_txt._width < com.clubpenguin.stamps.stampbook.controls.DescriptionBox.MIN_DESCRIPTION_WIDTH)
            {
                description_txt._width = com.clubpenguin.stamps.stampbook.controls.DescriptionBox.MIN_DESCRIPTION_WIDTH;
            } // end if
        } // end else if
        if (tooltipRightSideClip.memberBadge._visible)
        {
            _loc3 = tooltipRightSideClip.memberBadge._width;
        } // end if
        tooltipRightSideClip._x = _loc2._x + _loc2._width + _loc3 + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.TOOLTIP_RIGHT_SIDE_CLIP_PADDING;
        tooltipMiddleSideClip._width = tooltipRightSideClip._x - (tooltipLeftSideClip._x + tooltipLeftSideClip._width) + 1;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.DescriptionBox;
    static var LINKAGE_ID = "DescriptionBox";
    static var TOOLTIP_RIGHT_SIDE_CLIP_PADDING = -20;
    static var DESCRIPTION_TEXT_WIDTH_PADDING = 50;
    static var SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING = 12;
    static var MIN_DESCRIPTION_WIDTH = 128;
    static var SINGLE_LINE_DESCRIPTION_TEXT_PADDING = 10;
} // End of Class
