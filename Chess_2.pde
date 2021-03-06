import java.util.Map;

// constants
final int WIDTH = 640;
final int HEIGHT = 640;
int UNIT = WIDTH/8;

// globals
Game game;
boolean started;
PImage outlineImg, blackKnightImg, chessSetImg, piece0_1;

// these containers group the various sprites then they are put into the sprites multi container
//ArrayList<Sprite> missileGroup = new ArrayList<Sprite>();

// army types

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
  size(WIDTH, HEIGHT);
  noLoop();
  frameRate(1);
  initGame();
  play();
}

void initGame() {
  init_images();
  choose_armies();
  Player p1 = new Player(0, 0);
  Player p2 = new Player(0, 1);
  game = new Game(p1, p2);
  game.setup_board();
  started = true;
}

// init helpers    
void init_images() {
  blackKnightImg = loadImage("black_knight.png");
  piece0_1 = loadImage("black_pawn.png");
  outlineImg = loadImage("square_outline.png");
}

//// players select their army types
void choose_armies() {
  //p0Army = 0;
  //p1Army = 1;
}

void play() {
}

void draw() {
  game.display();
}

class Game {
  //ArrayList<Moves> moves;
  Board board;
  Player p1, p2;
  Player[] players = new Player[2];
  int playerTurn;

  Game(Player p1, Player p2) {
    this.players[0] = p1;
    this.players[1] = p2;
  }

  Player getPlayer(int i) {
    return players[i];
  }

  void setPlayer(Player p, int i) {
    players[i] = p;
  }

  void setup_board() {
    this.board = new Board();
    board.add_army(players[0].armyType, players[0].turnOrder);
  }

  void setBoard(Board board) {
    this.board = board;
  }

  void display() {
    board.display();
  }
}

// Board has an image and a Hashmap<PVector (col, row), ArrayList<Piece>>
// each key represents a square on the board and uses an arraylist to contain a Piece
class Board {
  PImage boardImg = loadImage("chessboard.png");
  Map<PVector, ArrayList<Piece>> board = new HashMap<PVector, ArrayList<Piece>>();
  Board() {
    // create a new board with no Pieces
    for (int row=0; row<9; row++) {
      for (int col=0; col<9; col++) {
        PVector location = new PVector(col, row);
        ArrayList<Piece> container = new ArrayList<Piece>();
        board.put(location, container);
      }
    }
  }

  void add_army(int type, int turnOrder) {
    ArrayList<Piece> result = new ArrayList<Piece>();
    switch(type) {
    case 0:
      addClassicArmy(turnOrder);
    default:
    }
  }

  // classic army init    
  void addClassicArmy(int turnOrder) {

    // create pawns
    int row;
    if (turnOrder == 0) {
      row = 6;
    } 
    else {
      row = 1;
    }

    for (int col=0; col<8; col++) {
      PVector square = new PVector(col, row);
      Piece newPiece = new ClassicPawn(0, 0);
      board.get(square).add(newPiece);
    }
  }

  void display() {
    image(boardImg, 0, 0, WIDTH, HEIGHT);
    display_pieces();
  }

  void display_pieces() {
    for (Map.Entry entry : board.entrySet()) {
      println("square: " + entry.getKey());
      println("value: " + entry.getValue());
      ArrayList<Piece> square = (ArrayList<Piece>) entry.getValue();
      println("isEmpty: " + square.isEmpty()); 
      if (!square.isEmpty()) {      
        PVector boardVector = (PVector) entry.getKey();
        PVector pos = convertBoardToScreen(boardVector);
        PImage img = square.get(0).image;
        image(img, pos.x, pos.y, UNIT, UNIT);
      }
    }
  }
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

class Piece {
  int player, type, armyType;
  PImage image;
  Piece() {
    this.type = type;
  }
} 

class ClassicPawn extends Piece {
  int type;
  ClassicPawn(int player, int armyType) {
    //super(player);
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
      } 
      else {
        newRow = currentPosition.row - 1;
      }
      BoardPosition newPos = new BoardPosition(currentPosition.col, newRow);
    }
    return moves;
  }
}

PVector convertBoardToScreen(PVector pv) {
  PVector screenPosition = new PVector(pv.x*UNIT, pv.y*UNIT);
  println(pv + "->" + screenPosition);
  return screenPosition;
}

