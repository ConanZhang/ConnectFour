package 
{
	
  import Button; 
  import flash.events.Event;
  import flash.geom.Point;
  import flash.geom.ColorTransform;
  import flash.display.Sprite;
  import flash.display.DisplayObjectContainer;
  import flash.display.MovieClip;
  import flash.external.ExternalInterface;
  import ColumnOutline;
  import ConnectFourColumn;

 
 	/*
	File:Connect_Four.as
	
	Author:	Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
	Date: 10-02-13
	Partner: Georbec Ammon/ Conan Zhang
	Course:	Computer Science 1410 - EAE
	
	Description:
	
	The Connect_Four class contains a constructor to create 7 Button objects for the game. It then has code to decide what
	color checker to drop into a column when a button is clicked and displays the properites of that click.
	*/
  public class Connect_Four extends Sprite
  {
	  //Class Variables//
	  private var playerIsRed: Boolean = false;
	  private var buttonPosition: int = 115;
	  private var grid: Array = new Array(7);
	  private var gameOver: Boolean = false;
	  private var theStage: DisplayObjectContainer;
	  
	  //outline color switcher variables
	  private var switchColor: ColorTransform = new ColorTransform();
	  private var redTurn: Boolean = true;
	  private var counterForColorSwitch: int = 0;
	  
	  //Column Outlines//
	  private var outline1: ColumnOutline = new ColumnOutline();
	  private var outline2: ColumnOutline = new ColumnOutline();
	  private var outline3: ColumnOutline = new ColumnOutline();
	  private var outline4: ColumnOutline = new ColumnOutline();
      private var outline5: ColumnOutline = new ColumnOutline();
	  private var outline6: ColumnOutline = new ColumnOutline();
	  private var outline7: ColumnOutline = new ColumnOutline();



	  
			/*
			Summary of the Connect_Four constructor:
			The Connect_Four constructor creates button objects for the stage.
			
			Parameters: theStage: DisplayObjectContainer
			
			Return Value: void
			
			Description: The constructor creates 7 button objects for clicking and gives their coordinates and size.
			*/
          public function Connect_Four(theStageP: DisplayObjectContainer)
          {
			  //stage into member var
			  theStage = theStageP;
			  
			  //add board to stage
			  theStage.addChildAt(this, 0);
				
//----------------------START BOARD GUI--------------------------------//
			
			//Create and Add 7 Buttons//
			for(var i: int = 0; i < 7; i++)
				{
                  var button:Button = new Button( "+", i, 100, 50, button_clicked );
                  theStage.addChild(button);				
				  
				  //Set Button Coordinates//
                  button.x = buttonPosition;
                  button.y = 800;				
				  
				  //Button Size//
				  button.scaleX = 0.5;
				  button.scaleY = 0.5;
				  
				  //Increment button position
				  buttonPosition += 120;
				}	
				
				//Reset Button//
				var resetButton: Button = new Button("Reset", 777, 200, 50, reset_button_clicked);
				//Set Button Coordinates//
				resetButton.x = 470;
				resetButton.y = 900;					  
				//Button Size//
				resetButton.scaleX = 0.6;
				resetButton.scaleY = 0.6;
				//add child
				this.addChild(resetButton);
				



				
			
			//7 Connect Four Columns//
			for (var boardColumn: int = 0; boardColumn < 7; boardColumn++)
			{
				//Create Objects//
				var column:  ConnectFourColumn = new ConnectFourColumn();
				
				//Set Location//
				column.x = boardColumn*120 + 80;
				column.y = 155;
				
				//Add Objects//
				theStage.addChild(column);
			}

					//7 Column Outlines//
					
					outline1.x = 0 + 80;
					outline1.y = 155;
					theStage.addChild(outline1);
					
					outline2.x = 120 + 80;
					outline2.y = 155;
					theStage.addChild(outline2);
					
					outline3.x = 240 + 80;
					outline3.y = 155;
					theStage.addChild(outline3);
					
					outline4.x = 360 + 80;
					outline4.y = 155;
					theStage.addChild(outline4);
					
					outline5.x = 480 + 80;
					outline5.y = 155;
					theStage.addChild(outline5);
					
					outline6.x = 600 + 80;
					outline6.y = 155;
					theStage.addChild(outline6);
					
					
					outline7.x = 720 + 80;
					outline7.y = 155;
					theStage.addChild(outline7);
					
//----------------------END BOARD GUI--------------------------------//


//----------------------START GAME LOGIC--------------------------------//

				//Create Matrix to Determine if a Bucket is -777 or Contains a Checker//

				for (var columnMatrix: int = 0; columnMatrix < 7; columnMatrix++)
				{
					//7x6 Matrix//
					grid[columnMatrix] = new Array(6);
					
					for(var rowMatrix: int = 0; rowMatrix < 6; rowMatrix++)
					{
						//All default buckets are -777 
						grid[columnMatrix][rowMatrix] = -777;
					}
				}
//----------------------END GAME LOGIC--------------------------------//
				
				
          }
          
		  
		  
		  /*
			Summary of the drop_into_column function:
			The drop_into_column function states what column a checker is being placed in and places it there.
			
			Parameters: col:int
			
			Return Value: void
			
			Description: The function traces the column # we drop a checker in and creates a new Checker object
			to add to it.
			*/
          public function drop_into_column( col : int ) : void
          {
			  	  /*
			  	  //State column that Checker is being dropped into by button ID
                  trace("drop into column called with : " + col);
				  */
				  
				  //Make Checker variable
				  var checker: Checker;
				  
				  //Find drop height from function for checker
				  var dropHeight: Number = findHeight(col);
				  
				  //Create new Checker and add it for correct player
				  if (playerIsRed && dropHeight != -1 && !gameOver)
				  {
					//GUI//
				  	checker = new Checker(this, "Player 1", new Point(col*120+140, dropHeight));
          		  	this.addChild(checker);
					
					//GAME LOGIC//
					addRedToMatrix(col);
					playerIsRed = false;
					
					//switch outline color
					  changeColor(outline1);
					  changeColor(outline2);
					  changeColor(outline3);
					  changeColor(outline4);
					  changeColor(outline5);
					  changeColor(outline6);
					  changeColor(outline7);
				  }
				  else if (dropHeight != -1 && !gameOver)
				  {
					//GUI//
				  	checker = new Checker(this, "Player 2", new Point(col*120+140, dropHeight));
          		  	this.addChild(checker);
					
					//GAME LOGIC//
					addBlueToMatrix(col);
					playerIsRed = true;
					
					//switch outline color
					  changeColor(outline1);
					  changeColor(outline2);
					  changeColor(outline3);
					  changeColor(outline4);
					  changeColor(outline5);
					  changeColor(outline6);
					  changeColor(outline7);
				  }
				  
				  //Check for a win every time a Checker is dropped
				  if( checkHorizontal() || checkVertical() || checkDiagonalUp() || checkDiagonalDown() )
				  {
					  trace ("Winner");
				  }
				 
				  
          }
		  
		  
          /*
			Summary of the checkHorizontal function:
			Uses the matrix of game logic to check for all horizontal possible wins.
			
			Parameters: none
			
			Return Value: Boolean
			
			Description: This function uses our game matrix to check for one of the ways to win.  We only have
							to look at certain parts of the grid, because only those parts have the --possibility--
							to win in that direction.
			*/
          public function checkHorizontal(): Boolean
          {
			
			//look at each row
			for(var rowMatrix: int = 0; rowMatrix < 6; rowMatrix++)
				{
					//For every column in that row...
					for (var columnMatrix: int = 0; columnMatrix < 4; columnMatrix++)
					{
						//if that specific bucket is not equal to -777
						if (grid[columnMatrix][rowMatrix] != -777)
							{
								//if the checker to the right of the one you're looking at is the same color
								if ( grid[columnMatrix][rowMatrix] == grid[columnMatrix + 1][rowMatrix] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix + 2][rowMatrix] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix + 3][rowMatrix]    )
								{
									//set our gameOver to true
									gameOver = true;
									
									//return a win
									return true;	
								}
							}
					}
				}
			//otherwise return false
			return false;
          }	  
		  
		  
		  /*
			Summary of the checkVertical function:
			Uses matrix of game logic to check for all vertical possible wins.
			
			Parameters: none
			
			Return Value: Boolean
			
			Description: This function uses our game matrix to check for one of the ways to win.  We only have
							to look at certain parts of the grid, because only those parts have the --possibility--
							to win in that direction.
			*/
		  public function checkVertical(): Boolean
          {
			
			//look at each column
			for(var columnMatrix: int = 0; columnMatrix < 7; columnMatrix++)
				{
					//for every Checker in that column
					for (var rowMatrix: int = 0; rowMatrix < 3; rowMatrix++)
					{
						//if that specific bucket is not equal to -777 
						if (grid[columnMatrix][rowMatrix] != -777)
							{
								//if the checker to the bottom of the one you're looking at is the same color
								if ( grid[columnMatrix][rowMatrix] == grid[columnMatrix][rowMatrix + 1] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix][rowMatrix + 2] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix][rowMatrix + 3]    )
								{
									gameOver = true;
									
									return true;								
								}
							}
					}
				}
			//otherwise return false
			return false;
          }	
		  
		  /*
			Summary of the checkDiagonalUp function:
			Uses matrix of game logic to check for all diagonal up (/) possible wins.
			
			Parameters: none
			
			Return Value: Boolean
			
			Description: This function uses our game matrix to check for one of the ways to win.  We only have
							to look at certain parts of the grid, because only those parts have the --possibility--
							to win in that direction.
			*/
		  public function checkDiagonalUp(): Boolean
          {
			
			//look at each column
			for(var columnMatrix: int = 0; columnMatrix < 4; columnMatrix++)
				{
					//for every Checker in that column
					for (var rowMatrix: int = 3; rowMatrix < 6; rowMatrix++)
					{
						//if that specific bucket is not equal to -777 
						if (grid[columnMatrix][rowMatrix] != -777)
							{
								//if the checker to the right and up of the one you're looking at is the same color
								if ( grid[columnMatrix][rowMatrix] == grid[columnMatrix+1][rowMatrix - 1] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix +2][rowMatrix - 2] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix + 3][rowMatrix - 3]    )
								{
									gameOver = true;
									
									return true;								
								}
							}
					}
				}
			//otherwise return false
			return false;
          }	
		  
		  
		  /*
			Summary of the checkDiagonalDown function:
			Uses matrix of game logic to check for all diagonal down (\) possible wins.
			
			Parameters: none
			
			Return Value: Boolean
			
			Description: This function uses our game matrix to check for one of the ways to win.  We only have
							to look at certain parts of the grid, because only those parts have the --possibility--
							to win in that direction.
			*/
		  public function checkDiagonalDown(): Boolean
          {
			
			//look at each column
			for(var columnMatrix: int = 0; columnMatrix < 4; columnMatrix++)
				{
					//for every Checker in that column
					for (var rowMatrix: int = 0; rowMatrix < 3; rowMatrix++)
					{
						//if that specific bucket is not equal to -777 
						if (grid[columnMatrix][rowMatrix] != -777)
							{
								//if the checker to the right and down of the one you're looking at is the same color
								if ( grid[columnMatrix][rowMatrix] == grid[columnMatrix+1][rowMatrix + 1] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix +2][rowMatrix + 2] && 
									 grid[columnMatrix][rowMatrix] == grid[columnMatrix + 3][rowMatrix + 3]    )
								{
									gameOver = true;
									
									return true;								
								}
							}
					}
				}
			//otherwise return false
			return false;
          }	
		  /*
			Summary of the button_clicked function:
			The button_clicked function calls on the drop_into_column function if a button is clicked.
			
			Parameters: event:Event
			
			Return Value: void
			
			Description: The function calls on the drop_into_column function if a button is clicked and
			displays the properties of that clicked button.
			
			*/
          public function button_clicked( event:Event ) : void
          {
			  //Create a variable Button to see if the Button is clicked, then drop a Checker into that column
			  
              var button : Button = (Button)(event.currentTarget); //we use the event parameter
			  
			  drop_into_column( button.get_value() ); //Drop Checker into column

			  /*
			  //Output Values of Button Properties//
              trace("in button clicked");
              trace("button is: " + button.get_value());
              */
          }
		  
		  
		  
		 /*
			Summary of the changeColor() function:
			The changeColor() function changes the colors of the column outlines.
			
			Parameters: outline: MovieClip
			
			Return Value: void
			
			Description: The function checks if a counter is 7 (because we have 7 separate columns)
			and switches the color based on the boolean that determines whose turn it is.
			
			*/  
		  private function changeColor(outline: MovieClip): void
		  {
			  //Determine whose turn it is by counter (7 columns)
			  if(counterForColorSwitch == 7)
			  {
				  redTurn = !redTurn;
				  counterForColorSwitch = 0;
			  }
			  
			  //change outline board color
					if (redTurn)
					{
						//Change to blue for player 2
						switchColor.color = 0x0D4DFF;
						outline.transform.colorTransform = switchColor;		
						counterForColorSwitch++;
					}
					else
					{
						//Change to red for player 1
						switchColor.color = 0x880000;
						outline.transform.colorTransform = switchColor;
						counterForColorSwitch++;
					}
		  }
		  
		  /*
			Summary of the findHeight() function:
			The findHeight() function determines the y Coordinate for a new Checker in a specific column.
			
			Parameters: col: int
			
			Return Value: int
			
			Description: The function looks from the bottom bucket to the top, checking for -777s. When it
			finally finds a -777, it determines the y Coordinate through the number of NON--777s.
			
			If no -777s are found, the function returns a -1 to indicate no more Checkers can be dropped.
			
			*/
		  private function findHeight(col: int) : int
		  {
			  //loop through column from bottom to top until space is -777
			  for (var g: int = 5; g >= 0; g--)
			  {
				  if (grid[col][g] == -777)
				  {
					  //use number of NON--777s to calculate y coordinate of new checker
					  return(215 +  (100*g) );

				  }
					
			  }
			  
			  //If every bucket is NON--777, return -1 to indicate no more Checkers can be dropped
			  return -1;
			  
		  }
		  
		  /*
			Summary of the addRedToMatrix() function:
			The addRedToMatrix function indicates a grid bucket has a Red Checker inside.
			
			Parameters: col:int
			
			Return Value: void
			
			Description: The function determines which bucket in a specific column should
			have a Red Checker then adds a 0 to indicate so.
			
			*/
		  private function addRedToMatrix(col:int) : void
		  {
			  //loop through column from bottom to top until space is -777
			    for (var l: int = 5; l >= 0; l--)
			  {
				  if (grid[col][l] == -777)
				  {
					  //Add Red Checker to Game Logic//
					  grid[col][l] = 0;
					  //ONLY IN THAT BUCKET//
					  return;
				  }
			  }
		  }
		  
		   /*
			Summary of the addBlueToMatrix() function:
			The addBlueToMatrix function indicates a grid bucket has a Blue Checker inside.
			
			Parameters: col:int
			
			Return Value: void
			
			Description: The function determines which bucket in a specific column should
			have a Blue Checker then adds a 1 to indicate so.
			
			*/
		   private function addBlueToMatrix(col:int) : void
		  {
			  //loop through column from bottom to top until space is -777
			    for (var d: int = 5; d >= 0; d--)
			  {
				  if (grid[col][d] == -777)
				  {
					  //Add Blue Checker to Game Logic//
					  grid[col][d] = 1;
					  //ONLY IN THAT BUCKET//
					  return;
				  }
			  }
		  }
		  
		  /*
			Summary of the reset_button_clicked function:
			Resets the game for a new try when the reset button is clicked.
			
			Parameters: event:Event (button clicked)
			
			Return Value: void
			
			Description: This function removes all of the children from the stage, sets all our variables
							to their default values, and sets all of the game logic to -777 (the number we
							used to represent null.  
							
						Called when someone clicks the reset button.
			*/
		  private function reset_button_clicked (event:Event) : void
			{
				//While there is more than 1 Child
				while (numChildren > 1)
				{
					//Remove all the children
					removeChildAt(1);
					
					//Set values back to defaults
					redTurn = true;
					gameOver = false;
					playerIsRed = false;
					counterForColorSwitch = 0;
				}
				
				//Set Matrix values back to default -777 (null)
				for (var columnMatrix: int = 0; columnMatrix < 7; columnMatrix++)
				{
					for(var rowMatrix: int = 0; rowMatrix < 6; rowMatrix++)
					{
						//All default buckets are -777 
						grid[columnMatrix][rowMatrix] = -777;
					}
				}
				
			}

  }//end class
}//end package
