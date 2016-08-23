package  
{
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.display.DisplayObjectContainer;
	
	/*
	File:Checker.as
	
	Author:	Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
	Date: 10-02-13
	Partner: Georbec Ammon/ Conan Zhang
	Course:	Computer Science 1410 - EAE
	
	Description:
	
	The Checker class creates a Checker object with information about the Player who owns that Checker and
	draws/animates it into the right position.
	
	*/
	public class Checker extends Sprite
	{
		//member variables
		private var ownerString : String;
		private var finalDestinationPoint : Point; // final resting point on stage
		
		/*
		Summary of the Checker constructor:
		The Checker constructor takes in specific strings and a point.
		
		Parameters: String [should be "Player 1" or "Player 2"], 
		
		Return Value: void
		
		Description: Sets owner, clones pixel parameter, sets members, calls display.
		
		*/
		public function Checker(guiContainer: DisplayObjectContainer, ownerParameter : String, finalDestinationPointParameter : Point)
        {
        
			//put parameter into member variables
            this.ownerString = ownerParameter;  // does this "share" the owner with every other checker?
			this.finalDestinationPoint = finalDestinationPointParameter.clone();

			//Set Initial X and Y Values//
            this.x = this.finalDestinationPoint.x;
            this.y = 0;
			
			//add to the upper level Sprite
			guiContainer.addChildAt(this, 0);

			//draw
            this.createDisplayList();
			
			//add event listener
			this.addEventListener(Event.ENTER_FRAME, this.descend);
        }
		
		/*
		Summary of the getOwnerString() function:
		Return owner.
		
		Parameters: None
		
		Return Value: String
		
		Description: Returns a String of "whose" checker it is.
		
		*/
		public function getOwnerString() : String
        {
            return this.ownerString;
        }
		
		
		/*
		Summary of the createDisplayList() function:
		Choose color then draw circle.
		
		Parameters: None
		
		Return Value: void
		
		Description: Chooses whether to draw red or black based
						on owner member variable, then draws circle.		
		*/
		public function createDisplayList() : void
        {
			//Clear//
            this.graphics.clear();
			
			//Set draw for Player 1
            if (this.ownerString == "Player 1")
            {
                this.graphics.beginFill(0x0D4DFF);
				this.graphics.drawCircle(0, 0, 30);
            	this.graphics.endFill();
				this.graphics.beginFill(0x03ADD);
            }
			//Set draw for Player 2
            else
            {
                this.graphics.beginFill(0x880000);
				this.graphics.drawCircle(0, 0, 30);
            	this.graphics.endFill();
				this.graphics.beginFill(0x720000);
            }

			//Draw Code//
            this.graphics.drawCircle(0, 0, 20);
            this.graphics.endFill();
        }
		
		
		/*
		Summary of the descend() function:
		Decides whether or not to "animate" the Checker based on its position on the stage.
		
		Parameters: Event 
		
		Return Value: void
		
		Description: Animates a falling checker.
		
		*/
		public function descend(e : Event) : void
        {
			//if the checker's ending Point is further DOWN
			//the screen than where it is currently
			//keep going down
            if (this.finalDestinationPoint.y > this.y)
            {
                this.y += 5;
            }
            else //else stop moving down.
            {
				this.y = this.finalDestinationPoint.y;
                this.removeEventListener(Event.ENTER_FRAME, this.descend);
            }
			
        }

	}//End Class
	
}//End Package
