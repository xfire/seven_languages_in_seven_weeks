trait Censor {
  private val curseWords: Map[String, String] = Map("Shoot" -> "Pucky", "Darn" -> "Beans")
  def replace(s: String): String = {
    curseWords.foldLeft(s)((acc, v) => acc.replaceAll(v._1, v._2))
  }
}

object Reader extends Censor {
  def yell() {
    println(replace("Shoot that Darn ..."))
  }
}

Reader.yell()

// vim: set ts=2 sw=2 et:
