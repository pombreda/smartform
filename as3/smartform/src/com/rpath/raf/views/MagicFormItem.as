/*
#
# Copyright (c) 2009 rPath, Inc.
#
# This program is distributed under the terms of the MIT License as found 
# in a file called LICENSE. If it is not present, the license
# is always available at http://www.opensource.org/licenses/mit-license.php.
#
# This program is distributed in the hope that it will be useful, but
# without any waranty; without even the implied warranty of merchantability
# or fitness for a particular purpose. See the MIT License for full details.
*/


package com.rpath.raf.views
{
    import mx.containers.Canvas;
    import mx.core.IVisualElement;
    import mx.core.UIComponent;
    import mx.events.ValidationResultEvent;
    
    import spark.components.BorderContainer;
    import spark.components.Group;

    public class MagicFormItem extends Group
    {
        
        public function MagicFormItem()
        {
            super();

            // force height computation
            minHeight = 0;
            
            // force initial setting of validation styles
            _validChanged = true;
        }
        
        private var _validChanged:Boolean;
        
        [Bindable]
        public function set isValid(v:Boolean):void
        {
            _isValid = v;
            _validChanged = true;
            invalidateProperties();
        }
        
        private var _isValid:Boolean;
        
        public function get isValid():Boolean
        {
            return _isValid;
        }
        
        public override function validationResultHandler(event:ValidationResultEvent):void
        {
            isValid = (event.type == ValidationResultEvent.VALID);
            // let our specific input control mark itself appropriately
            try
            {
                if (this.getChildAt(0) is UIComponent)
                {
                    (this.getChildAt(0) as UIComponent).validationResultHandler(event);
                }
            }
            catch (e:RangeError)
            {
                // no children yet. Ignore
            }
            
            // propagate events beyond ourselves
            super.validationResultHandler(event);
        }
        
        private var _selectedIndex:int;
        
        public function get selectedIndex():int
        {
            return _selectedIndex;
        }

        public function set selectedIndex( value:int ):void
        {
            _selectedIndex = value;
        }
    
        /** enabled override
        * We do this to prevent the Canvas that is our parent type
        * from dimming the whole box. Rather, we want the items within
        * the box to respond to the enabled flag directly
        */
        
        [Bindable]
        public override function set enabled(v:Boolean):void
        {
            _itemEnabled = v;
        }
    
        private var _itemEnabled:Boolean = true;
        
        public override function get enabled():Boolean
        {
            return _itemEnabled;
        }

        
        override protected function commitProperties():void
        {
            super.commitProperties();

            if (_validChanged)
            {
                _validChanged = false;
                //setStylesFromValidStatus();
            }
            
        }
    }
}