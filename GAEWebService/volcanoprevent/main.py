from render import Renderer
import webapp2
from controlers import *

class MainHandler(Renderer):
    def get(self):

        volcanoes = Volcano.query()

        self.render('index.html', message = "todo bien", volcanoes = volcanoes)

app = webapp2.WSGIApplication([
    ('/volcanoes',Volcanoes),
    ('/msg',Messages),
    ('/meetpt',MeetingPts),
    ('/evaRoute',EvacuationRoutes),
    ('/', MainHandler)
], debug=True)
