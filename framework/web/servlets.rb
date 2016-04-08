


#Servlets
class RootServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	#resp.body = File.new('index.html').sysread(1000)
    IO.foreach("#{$HTTP_VIEW}/index.html") do |line|
        resp.body += line
    end
  end
end

class ApiServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	#resp.body = "API"
    resp.body = req.body
  end
  def do_POST( req,resp )
    resp.status = 200
	resp.content_type = "text/plain"
	resp.body = "#{req.body.class}"
  end
end

class ResServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
    IO.foreach("#{$HTTP_VIEW}/style.css") do |line|
        resp.body += line
    end
  end
end

class ScriptServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
    IO.foreach("#{$HTTP_VIEW}/script.js") do |line|
        resp.body += line
    end
  end
end
