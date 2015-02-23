from google.appengine.ext import ndb


class Message(ndb.Model):

    created = ndb.DateTimeProperty(auto_now_add = True )
    type = ndb.StringProperty()
    desc = ndb.StringProperty()
    location = ndb.GeoPtProperty()
    vName = ndb.StringProperty()

class Volcano(ndb.Model):

    name = ndb.StringProperty()
    country = ndb.StringProperty()
    location = ndb.GeoPtProperty()
    size = ndb.IntegerProperty()


class MeetingPt(ndb.Model):

    name = ndb.StringProperty()
    location = ndb.GeoPtProperty()
    #vName = ndb.StringProperty()

class EvacuationRoute(ndb.Model):
    meetPt = ndb.StringProperty()
    name = ndb.StringProperty()
    jsonRouteArray = ndb.StringProperty()
    origin = ndb.GeoPtProperty()
