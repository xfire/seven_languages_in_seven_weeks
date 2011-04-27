import scala.io.Source

trait Censor {
  private var curseWords: Map[String, String] = Map()

  def loadFromFile(name: String) {
    Source.fromFile(name).getLines.toList.foreach { line =>
      line.split(",") match {
        case Array(word, alt) => curseWords += (word.trim -> alt.trim)
        case _ => // ignore
      }
    }
  }

  def replace(s: String): String = {
    curseWords.foldLeft(s)((acc, v) => acc.replaceAll(v._1, v._2))
  }
}

object Reader extends Censor {
  def yell() {
    println(replace("Shoot that Darn ..."))
  }
}

Reader.loadFromFile("censor_v2.txt")
Reader.yell()

// vim: set ts=2 sw=2 et:
