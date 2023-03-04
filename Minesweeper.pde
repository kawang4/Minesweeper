import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(1600, 1600);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++) {
      for (int j = 0; j < NUM_COLS; j++) {
        buttons[i][j] = new MSButton(i, j);
      }
    }
    setMines();
   
}
public void setMines()
{
   mines = new ArrayList<MSButton>();
  for (int i = 0; i < NUM_COLS*NUM_ROWS*1/5; i++){
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
      if (mines.contains(buttons[row][col]) != true) {
      mines.add(buttons[row][col]);
    }}
   
}

public void draw ()
{
    background( 0 );
   
}
public boolean isWon()
{
    int flaggedcount = 0;
    for (int i = 0; i < mines.size(); i++) {
      if (mines.get(i).isFlagged())
        flaggedcount += 1;
      }
     return flaggedcount == mines.size();
}

public boolean isValid(int r, int c)
{
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
      return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])) {
      numMines += 1;
    }
    if (isValid(row-1, col) && mines.contains(buttons[row-1][col])) {
      numMines += 1;
    }
    if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1])) {
      numMines += 1;
    }
    if (isValid(row, col-1) && mines.contains(buttons[row][col-1])) {
      numMines += 1;
    }
    if (isValid(row, col+1) && mines.contains(buttons[row][col+1])) {
      numMines += 1;
    }
    if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1])) {
      numMines += 1;
    }
    if (isValid(row+1, col) && mines.contains(buttons[row+1][col])) {
      numMines += 1;
    }
    if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1])) {
      numMines += 1;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
    {
        width = 1600/NUM_COLS;
        height = 1600/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed ()
    {
      clicked = true;
      //int firstclick = 1;
      //if (firstclick == 1) {
      //  firstrow = myRow;
      //  firstcol = myCol;
      //firstclick += 1;}
        if (mouseButton == RIGHT) {
          flagged = !flagged;
          if (flagged == false)
            clicked = false;
       
          }
        else if( clicked && mines.contains(this) && !flagged ) {
          displayLosingMessage();
          }
         
        else if ( clicked && countMines(myRow, myCol) > 0 && !flagged) {
          setLabel(countMines(myRow, myCol));}
 
        else {
          for (int n = myRow-1; n <= myRow+1; n++) {
            for (int m = myCol-1; m <= myCol+1; m++) {
              if (isValid(n,m) && buttons[n][m].clicked == false) {
                buttons[n][m].mousePressed();
              }}}}
   
   
    }
    public void displayLosingMessage()
{
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0 ; j < NUM_COLS; j++) {
      buttons[i][j].setLabel("YOU LOST");}}
   for (int i = 0; i < mines.size(); i++) {
             mines.get(i).clicked = true;}
            noLoop();

}
public void displayWinningMessage()
{
   for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0 ; j < NUM_COLS; j++) {
      buttons[i][j].setLabel("YOU WON");}}
}
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public void draw ()
    {    
 
        if (flagged) {
            fill(0);}
        else if( clicked && mines.contains(this)) {
            fill(255,0,0);
            }
        else if( clicked && countMines(myRow, myCol) >= 0 ){
            fill( 200 );
          }
        else {
            fill(100);}
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        if(isWon() == true)
        displayWinningMessage();
    }

    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

