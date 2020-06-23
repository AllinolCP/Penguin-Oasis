package com.clubpenguin.lib.managers.resource
{
    import com.clubpenguin.lib.enums.resource.*;
    import com.clubpenguin.lib.vo.resource.*;

    public interface IResourceManager
    {

        public function IResourceManager();

        function getResourceVO(param1:ResourceTypeEnum, param2:int) : ResourceVO;

    }
}
