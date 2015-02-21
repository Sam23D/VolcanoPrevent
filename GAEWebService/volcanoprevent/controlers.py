from render import Renderer
from models import *

from webapp2_extras import json

class MeetingPts(Renderer):
    def post(self,):
        meetPt = MeetingPt()

        meetPt.name = self.request.get('name')
        #lat = self.request.get('lat')
        #lat = self.request.get('lon')
        #meetPt.location = ndb.GeoPt(lat,lon)
        meetPt.location = ndb.GeoPt(self.request.get('location'))
        #meetPt.vName = self.request.get('vname')
        meetPt.put()



        self.render('index.html', message = meetPt.name + " saved succesfully" )
    def get(self,  ):

        result = {'meetingpoints':[]}
        meetPts = MeetingPt.query()

        for m in meetPts:
            x = {}
            x['name'] = m.name
            x['location'] = str(m.location)
            #x['vname'] = m.vname

            result['meetingpoints'].append(x)

        self.response.headers['Content-Type'] = 'application/json'
        self.response.write( json.encode(result) )


class Volcanoes(Renderer):
    def post(self,):
        volcano = Volcano()

        volcano.name = self.request.get('name')
        volcano.country = self.request.get('country')

        volcano.location = ndb.GeoPt(self.request.get('location'))

        volcano.size = int(self.request.get('size'))
        volcano.put()

        self.render('index.html', message = volcano.name + " saved succesfully" )

    def get(self ):
        result = {'volcanoes': []}

        volcanoes = Volcano.query()


        for v in volcanoes:
            x = {}
            x['name'] = v.name
            x['country'] = v.country
            x['location'] = str(v.location)
            x['size'] = int(v.size)

            result['volcanoes'].append(x)

        self.response.headers['Content-Type'] = 'application/json'

        self.response.write( json.encode(result) )

class Messages(Renderer):
    def post(self,):
        msg = Message()

        msg.type = self.request.get('type')
        msg.desc = self.request.get('desc')

        msg.location = ndb.GeoPt(self.request.get('location'))

        msg.put()

        self.render('index.html', message = msg.type + " saved succesfully" )

    def get(self, ):
        result = {'messages': []}

        messages = Message.query()

        for m in messages:
            x = {}
            x['type'] = m.type
            x['desc'] = m.desc
            x['location'] = str(m.location)
            x['hour'] = str(m.created)

            result['messages'].append(x)

        self.response.headers['Content-Type'] = 'application/json'
        self.response.write( json.encode(result) )

class EvacuationRoutes(Renderer):
    def post(self):
        evaRoute = EvacuationRoute()

        evaRoute.name = self.request.get('name')

        allLocations = self.request.get('routePoints')
        auxAllLocations = allLocations.split(';')
        evaRoute.origin = ndb.GeoPt( auxAllLocations[0] )

        evaRoute.jsonRouteArray = allLocations

        evaRoute.put()

    def get(self, ):
        result = {'evacuationRoutes': []}

        evaRoutes = EvacuationRoute.query()

        for e in evaRoutes:
            x = {}
            x['name'] = e.name

            x['route'] = e.jsonRouteArray.split(';')

            x['origin'] = str(e.origin)

            result['evacuationRoutes'].append(x)

        self.response.headers['Content-Type'] = 'application/json'
        self.response.write( json.encode(result) )
