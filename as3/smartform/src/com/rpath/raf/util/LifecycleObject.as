/*
#
# Copyright (c) 2008-2010 rPath, Inc.
#
# This program is distributed under the terms of the MIT License as found 
# in a file called LICENSE. If it is not present, the license
# is always available at http://www.opensource.org/licenses/mit-license.php.
#
# This program is distributed in the hope that it will be useful, but
# without any warranty; without even the implied warranty of merchantability
# or fitness for a particular purpose. See the MIT License for full details.
*/

package com.rpath.raf.util
{
    import flash.utils.Dictionary;
    
    import mx.core.FlexGlobals;

    public class LifecycleObject
    {
        public function LifecycleObject()
        {
            super();
        }
        
        // INVALIDATION AND COMMITPROPERTIES PATTERN
        
        private var invalidatePropertiesFlag:Boolean;
        
        public function invalidateProperties():void
        {
            if (!invalidatePropertiesFlag)
            {
                invalidatePropertiesFlag = true;
                invalidateObject(this);
            }
        }
        
        protected function commitProperties():void
        {
            // override this
        }
        
        // -- INVALIDATION SUPPORT
        private static var invalidObjects:Dictionary = new Dictionary(true);
        private static var validatePending:Boolean = false;
        
        public static function invalidateObject(obj:LifecycleObject):void
        {
            invalidObjects[obj] = true;
            
            if (!validatePending)
            {
                validatePending = true;
                FlexGlobals.topLevelApplication.callLater(validateObjects);
            }
        }
        
        protected static function validateObjects():void
        {
            var invalidQueue:Dictionary = invalidObjects;
            
            // start a fresh tracker for further invalidations
            // that are a side effect of this pass
            invalidObjects = new Dictionary(true);
            // ready to receive another call
            validatePending = false;
            
            for (var o:* in invalidQueue)
            {
                var rm:LifecycleObject = o as LifecycleObject;
                if (rm)
                {
                    // clear the flag first, in case we're reentrant
                    // on any given instance
                    rm.invalidatePropertiesFlag = false;
                    rm.commitProperties();
                }
            }
            
        }

    }
}