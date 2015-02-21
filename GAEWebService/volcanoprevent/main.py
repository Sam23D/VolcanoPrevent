from render import Renderer
import webapp2
from controlers import *

class MainHandler(Renderer):
    def get(self):

        volcanoes = Volcano.query()
        meetpts = MeetingPt.query()
        self.render('index.html', message = "todo bien", meetpts = meetpts)

app = webapp2.WSGIApplication([
    ('/volcanoes',Volcanoes),
    ('/msg',Messages),
    ('/meetpt',MeetingPts),
    ('/evaRoute',EvacuationRoutes),
    ('/volcanoes/(.*)',Volcanoes),
    ('/msg/(.*)',Messages),
    ('/meetpt/(.*)',MeetingPts),
    ('/evaRoute/(.*)',EvacuationRoutes),
    ('/', MainHandler)
], debug=True)
