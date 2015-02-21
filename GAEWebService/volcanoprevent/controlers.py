from render import Renderer
from models import *
from math import acos, sin, cos, exp , sqrt, radians
from webapp2_extras import json


def getGeoDistance(lat1, lon1, lat2, lon2 ):
    eRadius = 6371 # Earth Radius in km
    lat1 = radians(lat1)
    lat2 = radians(lat2)
    lon1 = radians(lon1)
    lon2 = radians(lon2)
    distance = acos(  sin(lat1) * sin(lat2)   +   cos(lat1) * cos(lat2) * cos(lon1 - lon2)      ) * eRadius

    return distance

class MeetingPts(Renderer):
    def post(self, ):
        meetPt = MeetingPt()

        meetPt.name = self.request.get('name')
        #lat = self.request.get('lat')
        #lat = self.request.get('lon')
        #meetPt.location = ndb.GeoPt(lat,lon)
        meetPt.location = ndb.GeoPt(self.request.get('location'))
        #meetPt.vName = self.request.get('vname')
        meetPt.put()

        meetpts = MeetingPt.query()

        self.render('index.html', message = meetPt.name + " saved succesfully" )
        
    def get(self, meetptname ):
        if meetptname == '*':
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
        else:
            meetpt = MeetingPt.query( MeetingPt.name == meetptname ).get()

            result = { 'name': meetpt.name, 'location': str(meetpt.location) }

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
        meetpts = MeetingPt.query()

        self.render('index.html', message = volcano.name + " saved succesfully" )

    def get(self, ):
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

        meetpts = MeetingPt.query()

        self.render('index.html', message = msg.type + " saved succesfully", meetpts = meetpts )

    def get(self, msgid ):
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
        evaRoute.meetPt = self.request.get('meetPt')
        allLocations = self.request.get('routePoints')
        auxAllLocations = allLocations.split(';')
        evaRoute.origin = ndb.GeoPt( auxAllLocations[0] )

        evaRoute.jsonRouteArray = allLocations

        evaRoute.put()

    def get(self, latlon ): #Returns the closest evacuation route to the specified  latlon
        latlon = latlon.split('_')
        myLat = float(latlon[0])
        myLon = float(latlon[1])
        shortestDistance = 21000 #reference of the earths half circunference

        evaRoutes = EvacuationRoute.query()

        for e in evaRoutes:

            edistance = getGeoDistance( myLat, myLon, e.origin.lat , e.origin.lon )

            if edistance < shortestDistance:
                shortestDistance = edistance
                result = e

        result = {'name':result.name ,'meetPt':result.meetPt , 'route': result.jsonRouteArray.split(';'),'origin': str(result.origin)}

        self.response.headers['Content-Type'] = 'application/json'
        self.response.write( json.encode(result) )
