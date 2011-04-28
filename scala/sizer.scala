import scala.io._
import scala.actors._
import Actor._

sealed case class Message(url: String, pageSize: Int)

object PageLoader {
  def getPageSize(url: String) = Source.fromURL(url, "iso-8859-1").mkString.length
}

val urls = List( "http://www.amazon.com/"
               , "http://www.twitter.com/"
               , "http://www.google.com/"
               , "http://www.cnn.com/"
               )

def timeMethod(method: () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime
  println("Method took " + (end - start) / 1000000000.0 + " seconds." )
}

def getPageSizeSeq() = {
  for(url <- urls) {
    println("Size for " + url + ": " + PageLoader.getPageSize(url))
  }
}

def getPageSizeConc() = {
  val caller = self

  for(url <- urls) {
    actor { caller ! Message(url, PageLoader.getPageSize(url)) }
  }

  for(i <- 1 to urls.size) {
    receive {
      case Message(url, size) => println("Size for " + url + ": " + size)
    }
  }
}

println("Sequential run: ")
timeMethod { getPageSizeSeq }

println("Concurrent run: ")
timeMethod { getPageSizeConc }

// vim: set ts=2 sw=2 et:
