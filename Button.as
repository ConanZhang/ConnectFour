/*
    Author: H. James de St. Germain
    Commented by: Georbec Ammon & Conan Zhang.
	File:Button.as
	
	Author:	Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
	Date: 10-02-13
	Partner: Georbec Ammon/ Conan Zhang
	Course:	Computer Science 1410 - EAE
	
	Description:
	
	The Button class contains the code to build a Button object with the properties to alter it.
	
	There are separate draw codes for 3 states the button can be in: a defalut state, a mouse click state, and a mouse hover state.
	
	It also has code to place text onto the button and return and set values that are private.
 */

package
{
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.Event;
  import flash.text.TextField;
  import flash.events.FocusEvent;
  import flash.text.TextFormat;
  import flash.display.MovieClip;
        
  public class Button extends Sprite
  {
	  //member variables
      private var title : String;
      private var value : int = 0;

		/*
		Summary of the Button constructor:
		The Button constructor creates a Button object with all the necessary functions and properties
		for use.
		
		Parameters: my_title:	String,
					my_id:		int, 
					my_width :	int, 
					my_height :	int, 
					call_back : Function
		
		Return Value: void
		
		Description: The constructor assigns variables to the parameters, states the events to "listen" to, draws the button,
		and scales it.
		
		*/
      public function Button( my_title:String, my_id:int, my_width :int, my_height :int, call_back : Function) 
        {
		  //Assign Parameters to Member Variables//
          this.title  = my_title;
          this.value  = my_id;
		  
		  //Add Events to "Listen" For//
          this.addEventListener(MouseEvent.MOUSE_DOWN, create_mouse_down_display_list); 
          this.addEventListener(MouseEvent.MOUSE_UP,   create_mouse_over_display_list); 
          this.addEventListener(MouseEvent.ROLL_OVER,  create_mouse_over_display_list);
          this.addEventListener(MouseEvent.ROLL_OUT,   create_default_display_list);    
          this.addEventListener(MouseEvent.CLICK,      call_back);      
           
		  //Draw Objects//
          this.create_default_display_list( null );
          this.create_title_display_list();
          
		  //Button Size//
          this.scaleX = my_width / 100;
          this.scaleY = my_height / 50;
        }
		
		
		/*
		Summary of the create_default_display_list function:
		The create_default_display_list function draws the default button.
		
		Parameters: e: MouseEvent
		
		Return Value: void
		
		Description: The function sets up the line, gives values for a gradient color, and draws the button.
		
		*/
      private function create_default_display_list( e:MouseEvent ) : void
        {
		  //Set Up Line//
          this.graphics.clear();
          this.graphics.lineStyle(2, 0x999999);
		  
		  //Make Array for Line Values//
          var colors:Array = [0x101010, 0x202020];
          var alphas:Array = [100, 100];
          var ratios:Array = [0, 255];
          
		  //Draw Code//
          this.graphics.beginGradientFill("linear",colors,alphas,ratios);
          this.graphics.drawRoundRect(0, 0, 100, 50, 40);
          this.graphics.endFill();
        }
		
		/*
		Summary of the create_mouse_down_display_list function:
		The create_mouse_down_display_list function draws the button as it is being clicked.
		
		Parameters: e: MouseEvent
		
		Return Value: void
		
		Description: The function sets up the line, makes values for them, and draws the button when it is clicked.
		
		*/                
      private function create_mouse_down_display_list( e:MouseEvent ) : void
        {
		  //Set Up Line//
          this.graphics.clear();
          this.graphics.lineStyle(2, 0xDBDBDB);

		  //Make Array for Line Values//
          var colors:Array = [0x222222, 0x101010, 0x151515, 0x252525];
          var alphas:Array = [25, 50, 75, 100];
          var ratios:Array = [0, 125, 200, 255];
                        
		  //Draw Code//
          this.graphics.beginGradientFill("radial",colors,alphas,ratios);
          this.graphics.drawRoundRect(0, 0, 100, 50, 40);
          this.graphics.endFill();
        }
		
		
         /*
		Summary of the create_mouse_over_display_list function:
		The create_mouse_over_display_list function draws the button as the mouse hovers over it.
		
		Parameters: e:MouseEvent
		
		Return Value: void
		
		Description: The function sets up the line, makes values for them, and draws the button as the mouse
		hovers over it.
		
		*/       
      private function create_mouse_over_display_list( e:MouseEvent ) : void
        {
		  //Set Up Line//
          this.graphics.clear();
          this.graphics.lineStyle(3, 0xDBDBDB);
		  
		  //Make Array for Line Values//
          var colors:Array = [0x101010, 0x333333];
          var alphas:Array = [100, 100];
          var ratios:Array = [0, 255];
         
		  //Draw Code//
          this.graphics.beginGradientFill("linear",colors,alphas,ratios);
          this.graphics.drawRoundRect(0, 0, 100, 50, 40);
          this.graphics.endFill();
        }
                
         /*
		Summary of the create_title_display_list() function:
		The create_title_display_list() function draws text onto the Button.
		
		Parameters: None
		
		Return Value: void
		
		Description: The function declares variables with Text types to define how the text will be formatted.
		It then sizes the text and gives values to the variables. After, properties of the text are stated so
		that the text may be added.
		
		*/       
      private function create_title_display_list() : void
        {
		  //Declare Text Variables//
          var text:TextField = new TextField();
          var my_format : TextFormat = new TextFormat();
		  
		  //Set Text Size to Object//
          text.width = this.width;
          text.height = this.height;
		  
		  //Define Values for my_format//
          my_format.align= "center";
          my_format.font = "Courier";
          my_format.size = 24;
          my_format.color = 0xDBDBDB;
		  
		  //Set Up Properties of the Text//
          text.text = this.title;
          text.selectable = false;
          text.antiAliasType = "advanced";
          text.setTextFormat( my_format );
          text.y = 10; // center vertically
		  
		  //Add Text//
          this.addChild(text);
        }
           
		 /*
		Summary of the set_value function:
		The set_value function sets a value for the member variable (Button ID).
		
		Parameters: the_value: int
		
		Return Value: void
		
		Description: The function sets the member variable's value. This in turn sets the value of the Button ID.
		
		*/
      public function set_value( the_value : int ) : void
        {
          this.value = the_value;
        }
		
		
		/*
		Summary of the get_value() function:
		The get_value() function gives the value of the value member variable which is the Button's ID.
		
		Parameters: None
		
		Return Value: int
		
		Description: The function returns the value of the value member variable as an integer. This is the Button's ID.
		
		*/
      public function get_value() : int
        {
          return this.value;
        }


  }//end class
}//end package