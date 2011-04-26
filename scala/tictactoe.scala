sealed abstract class Cell(c: String) {
  override def toString: String = c
}
case object CellEmpty extends Cell(" ")
case object CellX extends Cell("X")
case object CellO extends Cell("O")

sealed case class Position(x: Int, y: Int)

sealed abstract trait GameState
case object Drawn extends GameState
case object InProgress extends GameState
case class Won(winner: Cell) extends GameState

object Board {
  val SIZE = 3
  val LABEL_X = List('A', 'B', 'C')
  val LABEL_Y = List('1', '2', '3')
  def apply() = new Board(Vector.fill(SIZE)(Vector.fill(SIZE)(CellEmpty)))
}

class Board private (_board: Vector[Vector[Cell]]) {

  override def toString: String = {
    val h = "    " + Board.LABEL_X.mkString(" ")
    val h2 = "  *******"
    val lines = for(line <- _board) yield line.mkString("|")
    val b = Board.LABEL_Y.zip(lines).map(l => l._1 + " * " + l._2)
    (h :: h2 :: b).mkString("\n")
  }

  def set(value: Cell, pos: Position): Option[Board] = {
    if(pos.x >= 0 && pos.x < Board.SIZE &&
       pos.y >= 0 && pos.y < Board.SIZE &&
       _board(pos.y)(pos.x) == CellEmpty) {
      Some(new Board(_board.updated(pos.y, _board(pos.y).updated(pos.x, value))))
    } else {
      None
    }
  }

  def state: GameState = {
    def isDrawn: Boolean = _board.flatten.forall(_ != CellEmpty)

    def checkList(l: Seq[Cell]): Option[Cell] = {
      if(l.size > 0 && l(0) != CellEmpty) {
        l.foldLeft(Some(l(0)): Option[Cell])((acc, v) => acc.filter(_ == v))
      } else None
    }

    def getDiag(b: Vector[Vector[Cell]]): Seq[Cell] = for(x <- 0 until Board.SIZE) yield b(x)(x)

    def hs = for(l <- _board) yield checkList(l)
    def vs = for(l <- _board.transpose) yield checkList(l)

    lazy val dl = checkList(getDiag(_board))
    lazy val dr = checkList(getDiag(_board.reverse))
    lazy val h = hs.filter(_.isDefined).headOption.getOrElse(None)
    lazy val v = vs.filter(_.isDefined).headOption.getOrElse(None)

    if(isDrawn) {
      Drawn
    } else (dl orElse dr orElse h orElse v) match {
      case Some(winner) => Won(winner)
      case None => InProgress
    }
  }
}

object ConsoleController {

  def read(player: Cell): Option[Position] = {
    print("Player %s: ".format(player))
    Option(Console.readLine) flatMap { line =>
      val input = (line.replaceAll(" ", "") + "  ").toUpperCase.toList.sorted.reverse
      (Board.LABEL_X.indexOf(input(0)),
       Board.LABEL_Y.indexOf(input(1))) match {
        case (x, y) if x > -1 && y > -1 => Some(Position(x, y))
        case                          _ => None
      }
    }
  }

  def nextPlayer(player: Cell) = player match {
    case CellX => CellO
    case CellO => CellX
    case     _ => throw new IllegalStateException()
  }

  def nextMove(board: Board, player: Cell): Unit = {
    println
    println(board)
    board.state match {
      case InProgress =>
        read(player).flatMap(board.set(player, _)) match {
          case Some(newBoard) =>
            nextMove(newBoard, nextPlayer(player))
          case None =>
            println("invalid move")
            nextMove(board, player)
        }
      case Won(who) =>
        println("\n--> game over, %s winns".format(who))
      case Drawn =>
        println("\n--> game over, drawn")
    }
  }
}

ConsoleController.nextMove(Board(), CellX)

// vim: set ts=2 sw=2 et:
