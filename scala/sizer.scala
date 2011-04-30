import java.net.URL

import scala.io._
import scala.actors._
import Actor._
import scala.util.matching.Regex

case class PageSize(url: String, pageSize: Int)
case class PageLinkCount(url: String, links: Int)
case class PageLinks(url: String, links: Seq[String])

case class PageData(pageSize: Option[Int], links: Option[Int])

object PageLoader {
  val RE_URL = new Regex("""<a .*?href\s*=\s*\"([^\"]*)\"""", "url")

  def readURL(url: String): String = try {
    Source.fromURL(url, "iso-8859-1").mkString
  } catch {
    case e: Exception => ""
  }
  def getPageSize(url: String): Int = readURL(url).length
  def getLinkCount(url: String): Int = getLinks(url).length
  def getLinks(url: String): Seq[String] = RE_URL.findAllIn(readURL(url))
                                                 .matchData
                                                 .map(_.group("url"))
                                                 .toSeq
                                                 .filter(_.startsWith("http://"))
                                                 .distinct
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
  def showURLs(urls: Seq[String]) = {
    var foundURLs: List[String] = Nil
    for(url <- urls) {
      println("  Size for %s: %s [%s Links]".format(url, PageLoader.getPageSize(url), PageLoader.getLinkCount(url)))
      foundURLs ++= PageLoader.getLinks(url)
    } 
    foundURLs.distinct
  }
  showURLs(showURLs(urls))
}

def getPageSizeConc() = {
  val caller = self

  def showURLs(urls: Seq[String]) = {
    for(url <- urls) {
      actor {
        caller ! PageSize(url, PageLoader.getPageSize(url))
        caller ! PageLinkCount(url, PageLoader.getLinkCount(url))
        caller ! PageLinks(url, PageLoader.getLinks(url))
      }
    }

    var foundURLs: List[String] = Nil
    var urlData: Map[String, PageData] = Map().withDefaultValue(PageData(None, None))

    def addPageSize(url: String, pageSize: Int) = {
      urlData = urlData.updated(url, urlData(url) match {
        case PageData(_, x) => PageData(Some(pageSize), x)
      })
      urlData(url)
    }
    def addLinkCount(url: String, linkCount: Int) = {
      urlData = urlData.updated(url, urlData(url) match {
        case PageData(x, _) => PageData(x, Some(linkCount))
      })
      urlData(url)
    }
    def showURL(url: String, data: PageData) = data match {
      case PageData(Some(pageSize), Some(linkCount)) =>
        println("  Size for %s: %s [%s Links]".format(url, pageSize, linkCount))
      case _ =>
    }

    for(i <- 1 to urls.size * 3) {
      receive {
        case PageSize(url, size) => showURL(url, addPageSize(url, size))
        case PageLinkCount(url, links) => showURL(url, addLinkCount(url, links))
        case PageLinks(url, links) =>
          foundURLs ++= links
      }
    }

    foundURLs.distinct
  }

  showURLs(showURLs(urls))
}

println("Sequential run: ")
timeMethod { getPageSizeSeq }

println("Concurrent run: ")
timeMethod { getPageSizeConc }

// vim: set ts=2 sw=2 et:
