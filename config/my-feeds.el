(provide 'my-feeds)

(defvar my-leader)

(use-package elfeed
  :ensure t
  :commands elfeed
  :general
  (:keymaps 'elfeed-search-mode-map
            :states 'normal
            "gr" #'elfeed-update)
  :init
  (setq elfeed-db-directory (expand-file-name "~/Dropbox/.elfeed"))
  (setq elfeed-feeds
        '("https://tech.fpcomplete.com/rss.xml"
          "https://blog.daml.com/daml-driven/rss.xml"
          "https://next.atlas.engineer/feed" "https://usehooks.com/rss.xml"
          "http://nullprogram.com/feed/"
          "https://www.darkchestnut.com/feed.xml"
          "https://www.nushell.sh/blog/feed.xml"
          "https://overreacted.io/rss.xml"
          "http://guix.gnu.org/feeds/blog.atom"
          "https://www.kill-the-newsletter.com/feeds/lxjuqglyyla7sauybbd0.xml"
          "https://blog.linuxserver.io/rss/"
          "https://racket-news.com/feeds/all.atom.xml"
          "https://rogryza.me/atom.xml"
          "http://www.joachim-breitner.de/blog_feed.rss"
          "https://medium.com/feed/dfinity"
          "https://lisp-journey.gitlab.io/index.xml"
          "https://rust-gamedev.github.io/feed.xml"
          "https://taskwarrior.org/feed.rss" "https://chrispenner.ca/atom.xml"
          "https://sourcehut.org/blog/index.xml" "https://pijul.org/index.xml"
          "https://propellor.branchable.com/news/index.rss"
          "https://propellor.branchable.com/posts/index.rss"
          "https://groups.google.com/forum/feed/ludumdare/topics/rss.xml?num=50"
          "http://www.archlinux.org/feeds/news/"
          "http://blog.rust-lang.org/feed.xml"
          "http://arsdnet.net/this-week-in-d/twid.rss"
          "http://conal.net/blog/feed"
          "http://feeds.feedburner.com/codinghorror/"
          "http://www.digitalrune.com/DesktopModules/Blog/API/RSS/Get?tabid=719&moduleid=1525"
          "http://squirrel.pl/blog/feed/" "http://danielwhittaker.me/rss"
          "http://feeds.feedburner.com/PlataformaBlog"
          "http://engineering.riotgames.com/rss.xml"
          "http://www.randygaul.net/feed/"
          "http://bitsquid.blogspot.com.br/feeds/posts/default?alt=rss"
          "http://blog.z3bra.org/rss/feed.xml"
          "http://lambda-the-ultimate.org/rss.xml"
          "http://planet.haskell.org/rss20.xml" "http://blog.erlware.org/rss/"
          "http://250bpm.com/feed/pages/pagename/start/category/blog/t/250bpm-blogs/h/http%3A%2F%2Fwww.250bpm.com%2Fblog"
          "http://bartoszmilewski.com/feed/"
          "http://blog.acolyer.org/feed/"
          "http://ourmachinery.com/index.xml"
          "http://haskellweekly.news/haskell-weekly.rss"
          "http://cs-syd.eu/rss.xml"
          "http://mypy-lang.blogspot.com/feeds/posts/default"
          "https://weekly.nixos.org/feeds/all.rss.xml"
          "https://github.com/trimstray/the-book-of-secret-knowledge/commits.atom"
          "http://www.indiegamejams.com/feed/"
          "https://blog.linuxserver.io/rss/"
          "https://blog.polymath.network/tech/home"
          "http://0pointer.net/blog/index.atom"
          "https://www.kill-the-newsletter.com/feeds/vbhbge3p0xf85tvgr3wy.xml"
          "https://blog.kellybrazil.com/feed/")))
