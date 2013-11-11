
// constants
final int WIDTH = 640;
final int HEIGHT = 640;
int UNIT = WIDTH/8;


// globals
boolean started;
PImage chessboardImg, outlineImg, blackKnightImg, chessSetImg, piece0_1;

// these containers group the various sprites then they are put into the sprites multi container
//ArrayList<Sprite> missileGroup = new ArrayList<Sprite>();

// army types
String[] armyTypes = {"classic"};

// classic

// piece types
// 0 - pawn
// 1 - knight
// 2 - bishop
// 3 - rook
// 4 - queen
// 5 - king
// 6 - nemesis
// 7 - nemesis pawn
// 8 - empowered knight
// 9 - empowered bishop
// 10 - empowered rook


void setup() {
  size(WIDTH,HEIGHT);
  frameRate(1);
  init_images();
  choose_armies();
  Player p1 = new Player(0,0);
  Player p2 = new Player(0,1);
  Game myGame = new Game(p1, p2);
  setup_board();
  started = true;
  play();
}

// init helpers    
void init_images() {
  chessboardImg = loadImage("chessboard.png");
  blackKnightImg = loadImage("black_knight.png");
  piece0_1 = loadImage("black_pawn.png");
  outlineImg = loadImage("square_outline.png");
}

// players select their army types
void choose_armies() {
  //p0Army = 0;
  //p1Army = 1;  
}

void setup_board() {
  
}

void play() {
  
}

void draw() {
  image(chessboardImg, 0, 0, WIDTH, HEIGHT);
  image(piece0_1, 0, 0, UNIT, UNIT);
  image(piece0_1, UNIT, 0, UNIT, UNIT);
  image(piece0_1, UNIT, UNIT, UNIT, UNIT);

  image(piece0_1, UNIT*7, UNIT, UNIT, UNIT);

  image(piece0_1, UNIT*7, UNIT*7, UNIT, UNIT);
  image(outlineImg, UNIT*7, UNIT*7, UNIT, UNIT);

}

class Game {
  //ArrayList<Moves> moves;
  Player p1, p2;
  Player[] players = new Player[2];
  PImage boardImg;
  int playerTurn;

  Game(Player p1, Player p2) {
    this.players[0] = p1;
    this.players[1] = p2;
    this.boardImg = boardImg;
  }  
}

class Board {
  PImage image = chessboardImg;
  BoardSquare[][] board;
}

class BoardSquare {
  ArrayList<Piece> pieces = new ArrayList<Piece>();
  
  void setPiece(Piece piece) {
    pieces.add(piece);
  }
  
  void removePiece() {
  }
  
  Piece getPiece() {
    return pieces.get(0); 
  }
}

class Player {
  int armyType, turnOrder;
  ArrayList<Piece> pieces;
  String name;
  
  Player(int armyType, int turnOrder) {
    this.turnOrder = turnOrder;
    this.armyType = armyType;
    pieces = createArmy(armyType, turnOrder);
  }  
}

class BoardPosition {
  int row, col;
  BoardPosition(int c, int r) {
    row = r;
    col = c;
  }  
  
  int getRow() {
    return row;
  }
}

ArrayList<Piece> createArmy(int type, int turnOrder) {
  ArrayList<Piece> result = new ArrayList<Piece>();
  switch(type) {
    case 0:
      return createClassicArmy(turnOrder);
    default:
      return result;      
  }
}
    
// classic army init    
ArrayList<Piece> createClassicArmy(int turnOrder) {
  ArrayList<Piece> pieces = new ArrayList<Piece>();
  
  // create pawns
  int rowPos;
  if (turnOrder == 0) {
    rowPos = 2;
  } else {
    rowPos = 7;
  }
  
  for (int col=1; col<9; col++) {
    BoardPosition bp = new BoardPosition(col, rowPos);
    PVector position = convertBoardToScreen(bp);
    Piece newPiece = new ClassicPawn(0);
    pieces.add(newPiece);      
  }
  
  return pieces;
}    

class Piece {
  int player, type;
  PImage image;
  Piece(int player) {
    this.type = type;
  }
} 

class ClassicPawn extends Piece {
  int type;
  int player;
  ClassicPawn(int player) {
    super(player);
    type = 1;
    this.player = player;
    image = piece0_1;
  }

    
  ArrayList<int[]> generateValidMoves(BoardPosition currentPosition, ArrayList<BoardPosition> boardSetup) {
    ArrayList<int[]> moves = new ArrayList<int[]>();
    switch (type) {
      case 0:
        // one space forward
        int newRow, newCol;
        if (player == 0) {
          newRow = currentPosition.row + 1;
        } else {
          newRow = currentPosition.row - 1;
        }
        BoardPosition newPos = new BoardPosition(currentPosition.col, newRow);
    }
    return moves;
  }
}

PVector convertBoardToScreen(BoardPosition bp) {
  PVector screenPosition = new PVector((bp.row-1)*UNIT, (bp.col-1)*UNIT);
  return screenPosition;
}
