import socket
import re
import signal
import sys
import select
import string
import hashlib
from phpserialize import unserialize
from phpserialize import serialize
import time
import random
import ConfigParser
import CPPSMySQL
from Clients import CPPSGameClient
from lxml import etree
import threading

config = ConfigParser.ConfigParser()
config.read('config.ini')

class CPPSGame:
    
    def __init__(self, port, id):
        
        print "\t\t\tPython Game Server v2.0 "
        print "\t\t \tWritten by Tybone10 "
        
        self.ID = id
        self.socket_server = None
        self.socket_arr = []
        self.clients = {}
        self.timer = None
        
        self.config = config #store the config stuff for CPPSGameClient
        
        self.cached_users = {}#instead of executing a query to fetch the user's name for someone's buddy list every single time they login, we cache the id => name
        
        self.main_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.main_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.main_sock.bind(("", port))
        self.main_sock.listen(5)
        self.shuttingDown = False
        self.socket_arr.append(self.main_sock)
        
        signal.signal(signal.SIGINT, self.close)
        
        self.MySQL = CPPSMySQL.CPPSMySQL({'host': str(config.get('MySQL', 'host')), 'user': str(config.get('MySQL', 'user')), 'pass': str(config.get('MySQL', 'pass')), 'name': str(config.get('MySQL', 'name'))})
                
        print "Python CPPS game server started"
        self.game = { 'isOn' : False, 'hider' : '', 'riddle' : '', 'canFind': False, 'room' : 'UNDEFINED' }
        self.handlers = {
            'j#js'    : 'handleJoinServer',
            'j#jr'    : 'handleJoinRoom',
            'j#jg'    : 'handleJoinRoom',
            'm#sm'      : 'handleMessage',
            'i#qpp'      : 'handleQueryPlayerPins',
            'i#qpa'      : 'handleQPA',
            'i#gi'      : 'handleGetInventory',
            'i#ai'    : 'handleAddItem',
            'b#gb'       : 'handleGetBuddies',
            'b#bf'       : 'handleBuddyFind',
            'b#br'       : 'handleBuddyRequest',
            'b#ba'       : 'handleBuddyAccept',
            'b#rb'       : 'handleBuddyRemove',
            'n#gn'    : 'handleGetIgnored',
            'u#h'       : 'handleHeartBeat',
            'l#mst'   : 'handleMailStart',
            'f#epfga' : 'handleEPFGa',
            'f#epfgf' : 'handleEPFGf',
            'f#epfgr' : 'handleEPFGr',
            'f#epfsa' : 'handleEPFSa',
            'u#glr'   : 'handleGetLastRevision',
            'p#pgu'   : 'handleGetUserPuffles',
            'u#sp'    : 'handleSendPlayer',
            'u#sb'    : 'handleSendBall',
            'u#sa'    : 'handleSetAction',
            'u#sf'    : 'handleSetFrame',
            'u#ss'    : 'handleSendSafeMessage',
            'u#se'    : 'handleSendEmote',
            'u#gp'    : 'handleDummyGP',
            'l#mg'    : 'handleDummyMG',
            's#upb'   : 'handleUpdateClothes',
            's#upc'   : 'handleUpdateClothes',
            's#uph'   : 'handleUpdateClothes',
            's#upf'   : 'handleUpdateClothes',
            's#upn'   : 'handleUpdateClothes',
            's#upe'   : 'handleUpdateClothes',
            's#upa'   : 'handleUpdateClothes',
            's#upp'   : 'handleUpdateClothes',
            's#upl'   : 'handleUpdateClothes',
            'po#cfc'  : 'handleCheckFoundClaim',
            'o#k'  : 'handleKick',
            }
        self.rooms = {
                        "0": {"name": "default", "int_id": 0, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "100": {"name": "town", "int_id": 1, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "110": {"name": "coffee", "int_id": 2, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "111": {"name": "book", "int_id": 3, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "120": {"name": "dance", "int_id": 4, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "121": {"name": "lounge", "int_id": 5, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "122": {"name": "eco", "int_id": 6, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "130": {"name": "shop", "int_id": 7, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "200": {"name": "village", "int_id": 8, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "211": {"name": "agentlobbysolo", "int_id": 9, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "212": {"name": "agentlobbymulti", "int_id": 10, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "213": {"name": "agentvr", "int_id": 105, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "220": {"name": "lodge", "int_id": 11, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "221": {"name": "attic", "int_id": 12, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "230": {"name": "mtn", "int_id": 13, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "300": {"name": "plaza", "int_id": 14, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "310": {"name": "pet", "int_id": 15, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "320": {"name": "dojo", "int_id": 16, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "321": {"name": "dojoext", "int_id": 17, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "322": {"name": "dojohide", "int_id": 18, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "323": {"name": "agentcom", "int_id": 19, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "330": {"name": "pizza", "int_id": 20, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "340": {"name": "stage", "int_id": 21, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "400": {"name": "beach", "int_id": 22, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "410": {"name": "light", "int_id": 23, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "411": {"name": "beacon", "int_id": 24, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "420": {"name": "ship", "int_id": 25, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "421": {"name": "shiphold", "int_id": 26, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "422": {"name": "shipquarters", "int_id": 27, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "423": {"name": "shipnest", "int_id": 28, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "430": {"name": "puffle1", "int_id": 114, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "431": {"name": "puffle2", "int_id": 115, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "432": {"name": "puffle3", "int_id": 116, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "433": {"name": "puffle4", "int_id": 117, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "800": {"name": "dock", "int_id": 29, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "801": {"name": "forts", "int_id": 30, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "802": {"name": "rink", "int_id": 31, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "803": {"name": "agent", "int_id": 32, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "804": {"name": "boiler", "int_id": 33, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "805": {"name": "berg", "int_id": 34, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "806": {"name": "cave", "int_id": 35, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "807": {"name": "shack", "int_id": 36, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "808": {"name": "mine", "int_id": 37, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "809": {"name": "forest", "int_id": 38, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "810": {"name": "cove", "int_id": 39, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "811": {"name": "boxdimension", "int_id": 40, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "812": {"name": "dojofire", "int_id": 41, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "813": {"name": "cavemine", "int_id": 42, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "814": {"name": "lake", "int_id": 43, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "815": {"name": "underwater", "int_id": 44, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "851": {"name": "party1", "int_id": 45, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "852": {"name": "party2", "int_id": 46, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "853": {"name": "party3", "int_id": 47, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "854": {"name": "party4", "int_id": 48, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "855": {"name": "party5", "int_id": 49, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "856": {"name": "party6", "int_id": 50, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "857": {"name": "party7", "int_id": 51, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "858": {"name": "party8", "int_id": 52, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "859": {"name": "party9", "int_id": 53, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "860": {"name": "party10", "int_id": 54, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "861": {"name": "party11", "int_id": 55, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "862": {"name": "party12", "int_id": 56, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "863": {"name": "party13", "int_id": 57, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "864": {"name": "party14", "int_id": 58, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "865": {"name": "party15", "int_id": 59, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "866": {"name": "party16", "int_id": 60, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "867": {"name": "party17", "int_id": 61, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "868": {"name": "party18", "int_id": 62, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "869": {"name": "party19", "int_id": 105, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "870": {"name": "party20", "int_id": 106, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "871": {"name": "party21", "int_id": 107, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "872": {"name": "party22", "int_id": 108, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "873": {"name": "party23", "int_id": 109, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "874": {"name": "party24", "int_id": 110, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "875": {"name": "party25", "int_id": 111, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "876": {"name": "party26", "int_id": 112, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "877": {"name": "party27", "int_id": 113, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "899": {"name": "party", "int_id": 63, "game": False, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "900": {"name": "astro", "int_id": 64, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "901": {"name": "beans", "int_id": 65, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "902": {"name": "roundup", "int_id": 66, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "903": {"name": "hydro", "int_id": 67, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "904": {"name": "fish", "int_id": 68, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "905": {"name": "cart", "int_id": 69, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "906": {"name": "jetpack", "int_id": 70, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "907": {"name": "mission1", "int_id": 71, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "908": {"name": "mission2", "int_id": 72, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "909": {"name": "thinice", "int_id": 73, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "910": {"name": "pizzatron", "int_id": 74, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "911": {"name": "mission3", "int_id": 75, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "912": {"name": "waves", "int_id": 76, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "913": {"name": "mission4", "int_id": 77, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "914": {"name": "mission5", "int_id": 78, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "915": {"name": "mission6", "int_id": 79, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "916": {"name": "aqua", "int_id": 80, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "917": {"name": "book1", "int_id": 81, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "918": {"name": "book2", "int_id": 82, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "919": {"name": "book3", "int_id": 83, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "920": {"name": "mission7", "int_id": 84, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "921": {"name": "mission8", "int_id": 85, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "922": {"name": "mission9", "int_id": 86, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "923": {"name": "mission10", "int_id": 87, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "926": {"name": "mixmaster", "int_id": 88, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "927": {"name": "mission11", "int_id": 89, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "941": {"name": "soaker", "int_id": 90, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "942": {"name": "balloon", "int_id": 91, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "943": {"name": "bell", "int_id": 92, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "944": {"name": "feed", "int_id": 93, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "945": {"name": "memory", "int_id": 94, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "946": {"name": "paddle", "int_id": 95, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "947": {"name": "shuffle", "int_id": 96, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "948": {"name": "spin", "int_id": 97, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "949": {"name": "rescue", "int_id": 98, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "951": {"name": "sensei", "int_id": 99, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "952": {"name": "dancing", "int_id": 100, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "953": {"name": "firesensei", "int_id": 101, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "997": {"name": "fire", "int_id": 102, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "998": {"name": "card", "int_id": 103, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''},
                        "999": {"name": "sled", "int_id": 104, "game": True, "clients": {}, 'containsHiddenPlayer': False, 'hiddenPlayer' : ''}
                    }
        
        print "CPPS Game Server started"
        
        while 1:
            rsock, wsock, esock = select.select(self.socket_arr,[],[])
            for sock in rsock:
                if sock == self.main_sock:
                    try:
                        sockfd, addr = self.main_sock.accept()
                    except:
                        print 'erorr doin dat\n'
                        continue
                    self.socket_arr.append(sockfd)
                    self.clients[sockfd] = CPPSGameClient.CPPSGameClient(self, addr, sockfd)
                else:
                    try:
                        data = sock.recv(8192)
                    except socket.error:
                        print 'error receiving from %s:%s' % addr
                        continue
                    if data:
                        data_args = data.split(chr(0)) #split by chr(0) because sometimes packets stick
                        for l_data in data_args:
                            if l_data:
                                if l_data[0:1] == '<':
                                    if l_data == '<policy-file-request/>':
                                        self.clients[sock].send('<cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>')
                                        continue
                                    try:
                                        data = etree.fromstring(l_data)
                                    except:
                                        continue
                                    data = data[0]
                                    if data is None:
                                        continue
                                    if data.get('action') == 'verChk':
                                        self.clients[sock].send("<msg t='sys'><body action='apiOK' r='0'></body></msg>")
                                        continue
                                    elif data.get('action') == 'rndK':
                                        self.clients[sock].send("<msg t='sys'><body action='rndK'r='-1'><k>%s</k></body></msg>" % self.clients[sock].userInfo['rndK'])
                                        continue
                                    elif data.get('action') == 'login':
                                        username = list(data)[0][0].text
                                        password = list(data)[0][1].text
                                        if username is None or password is None:
                                            continue
                                        try:
                                            user = self.MySQL.selectData("SELECT * FROM `accs` WHERE `name` = '%s'" % self.MySQL.escape(username))
                                        except:
                                            continue
                                        if user == False:
                                            self.clients[sock].send('%xt%e%-1%100%')
                                            continue
                                        hash = self.hashPassword(user[5], self.clients[sock].userInfo['rndK'])
                                        if hash != password:
                                            self.clients[sock].send('%xt%e%-1%101%')
                                            continue
                                        try:
                                            userCrumbs = unserialize(user[3])
                                        except:
                                            continue
                                        if userCrumbs == False:
                                            self.clients[sock].send('%xt%e%-1%100%')
                                            continue
                                        if bool(userCrumbs['isBanned']) == True:
                                            self.clients[sock].send('%xt%e%-1%603%')
                                            continue
                                        try:
                                            for d in self.clients:
                                                if self.clients[d].is_authenticated==False:
                                                    continue
                                                if self.clients[d].username == user[1]:
                                                    self.removeSocket(d)
                                        except:
                                            print 'dict siowe change\n'
                                        self.clients[sock].send('%xt%l%-1%')
                                        self.clients[sock].id = str(user[0])
                                        self.rooms['0']['clients'][sock] = self.clients[sock]
                                        self.clients[sock].setupPlayer(userCrumbs, user[1])
                                        print str(user[1]) + ':' + str(addr[0]) + ' identified\n'
                                        try:
                                            self.MySQL.updateData('UPDATE servers SET onlineUsers = "'+str(self.MySQL.escape(str(len(self.clients))))+'" WHERE serverID="'+str(self.MySQL.escape(str(self.ID)))+'"')
                                        except:
                                            print 'st\n'
                                            continue
                                elif l_data[0:1] == '%':
                                    if self.clients.has_key(sock) == False:
                                        continue
                                    if self.clients[sock].is_authenticated is False:
                                        if l_data.find('epfgf%') is None or l_data.find('epfgf%') is False:
                                            print 'Client ' + str(self.clients[sock].id) + ' tried sending game packets before they were logged in: ' + str(l_data)
                                            self.removeSocket(sock)
                                            continue
                                    try:
                                        self.clients[sock].id
                                    except:
                                        continue
                                    pack_arr = l_data.split('%')
                                    try:    
                                        str(pack_arr[3])
                                    except:
                                        print 'bad packet from ' + str(addr[0]) + '\n'
                                        continue
                                        
                                    if self.handlers.has_key(str(pack_arr[3])) == False:
                                        print "Unknown packet: " + str(l_data)
                                        continue
                                    try:
                                        func = getattr(self, self.handlers[str(pack_arr[3])], self.handleNoFunction)
                                    except:
                                        print 'error\n'
                                        continue
                                    if func == False:
                                        continue
                                    func(sock, pack_arr)
                                    continue
                    else:
                        self.removeSocket(sock)
                        continue
    def handleNoFunction(self, socket, pack_arr):
        print "Error: \"" + str(pack_arr[3]) + "\" in handler dict, but no function exists for it"
        return False
    def handleJoinServer(self, socket, pack_arr):
        user = self.clients[socket]
        user.send('%xt%js%-1%0%1%' + str(int(user.userInfo['crumbs']['isModerator'])) + '%0%')
        user.send('%xt%gps%-1%%')
        user.send('%xt%mg%-1%%')
        user.send('%xt%lp%-1%' +  user.generateString() +'%' + str(user.userInfo['crumbs']['coins']) + '%0%1440%' + str(time.time()) + '%999%4%233%0%%7%')
        user.joinRoom(random.choice([100, 800]), 0, 0)
        if self.game['isOn'] == False:
            self.game['hider'] = str(user.username)
            self.game['riddle'] = ''
            self.game['isOn'] = True
            self.game['canFind'] = False
            for index in self.clients:
                self.clients[index].send('%xt%pong%-1%1%' + str(self.game['hider']) + '%The game will start soon%')
            self.timer = threading.Timer(60.0, self.startNewGame)
            self.timer.start()
        user.send('%xt%jgm%-1%1%' + str(int(self.game['isOn'])) + '%' + str(self.game['hider'])+'%'+str(self.game['riddle'])+'%')
        return True
    def handleGetInventory(self, socket, pack_arr):
        user = self.clients[socket]
        items = ''
        for id in user.userInfo['crumbs']['items']:
            items +=  str(user.userInfo['crumbs']['items'][id]) + '%'
        user.send('%xt%gi%-1%' + str(items))
        user.send('%xt%pouh%-1%1%' + str(self.game['hider']) + '%')
        user.send('%xt%pour%-1%1%' + str(self.game['riddle']) + '%')
        return True
    def handleGetBuddies(self, socket, pack_arr):
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.send('%xt%gb%-1%' + user.getBuddies() + '%')
        return True
    def handleGetIgnored(self, socket, pack_arr):
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.send('%xt%gn%-1%' + user.getIgnored() + '%')
        return True
    def handleHeartBeat(self, socket, pack_arr):
        user = self.clients[socket]
        user.send('%xt%h%-1%')
        return True
    def handleMailStart(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%mst%-1%0%0%")
        return True
    def handleMailGet(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%mg%-1%" + user.getPostcards() + "%")
        return True
    def handleEPFGa(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xtepfga%-1%1%")
        return True
    def handleEPFSa(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xtepfsa%-1%1%")
        return True
    def handleEPFGf(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%epfgf%-1%1%")
        return True
    def handleEPFGr(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%epfgr%-1%1%1%")
        return True
    def handleGetLastRevision(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%glr%-1%3555%")
        return True
    def handleGetUserPuffles(self, socket, pack_arr):
        user = self.clients[socket]
        user.send("%xt%pgu%-1%%")
        return True
    def handleCheckFoundClaim(self, socket, pack_arr):
        user = self.clients[socket]
        try:
            user.id
            pack_arr[5]
            pack_arr[6]
        except:
            return False
        if self.game['isOn'] == False:
            return False
        if self.game['canFind'] == False:
            return False
        if pack_arr[5].isdigit() == False or pack_arr[6].isdigit() == False:
            return False
        if user.username.lower() == self.game['hider'].lower():
            return False
        if self.rooms.has_key(str(user.userInfo['room_id'])):
            if self.rooms[str(user.userInfo['room_id'])]['containsHiddenPlayer'] == True:
                huser = self.rooms[str(user.userInfo['room_id'])]['hiddenPlayer'] 
                try:
                    huser.username
                    huser.id
                except:
                    huser = user
                if huser.username != self.game['hider']:
                    self.rooms[str(user.userInfo['room_id'])]['containsHiddenPlayer'] = False
                    return False
                found = False
                found2 = False
                x = int(huser.userInfo['pos']['x'])
                y = int(huser.userInfo['pos']['y'])
                pack_arr[5] = int(pack_arr[5])
                pack_arr[6] = int(pack_arr[6])
                if int(pack_arr[5]) < int(x+30) and int(pack_arr[5]) > int(x-30):
                    found = True
                if int(pack_arr[6]) < int(y+30) and int(pack_arr[6]) > int(y-30):
                    found2 = True
                if found == True and found2 == True:
                    if(str(user.ip) == str(huser.ip)):
                        return False
                    print str(user.username) + ':' + str(user.ip) + ' found ' + str(huser.username) + ':' + str(huser.ip)
                    rndp = self.chooseRandPlayer(str(huser.id))
                    ruser = self.clients[rndp]
                    try:
                        user.userInfo['crumbs']['credits'] = int(user.userInfo['crumbs']['credits']) + 100
                    except:
                        print 'no credits for ' + str(user.username)
                    try:
                        ruser.username
                        user.username
                        ruser.id
                        user.id
                    except:
                        return False
                    for index in self.clients:
                        if self.clients[index].is_authenticated==False:
                            continue
                        self.clients[index].sendBotMsg(str(user.username) + ' has found ' + str(huser.username) + ' in room ' + str(user.userInfo['room_id']) + '! The next game will start in 60 seconds with ' + str(ruser.username) + ' as the hider! [RANDOM]')
                        self.clients[index].send('%xt%pong%-1%1%' + str(self.game['hider']) + '%The game will start soon%')
                        if self.clients[index].username == self.game['hider']:
                            self.clients[index].invisible = False
                            self.clients[index].canSwitchRooms = True
                    self.game['isOn'] = True
                    self.game['hider'] = str(ruser.username)
                    self.game['riddle'] = ''
                    self.game['canFind'] = False
                    self.rooms[str(ruser.userInfo['room_id'])]['containsHiddenPlayer'] = True
                    self.rooms[str(ruser.userInfo['room_id'])]['hiddenPlayer'] = ruser
                    self.timer = threading.Timer(60.0, self.startNewGame)
                    self.timer.start()
        return True
    def chooseRandPlayer(self, myId):
        key = random.choice(self.clients.keys())
        try:
            self.clients[key].id
        except:
            key = random.choice(self.clients.keys())
            try:
                self.clients[key].id
            except:
                for i in self.clients:
                    try: 
                        self.clients[i].id
                    except:
                        continue
                    if str(self.clients[i].id) == str(myId):
                        continue
                    return key
        if str(self.clients[key].id) != str(myId):
            return key
        for i in self.clients:
            try: 
                self.clients[i].id
            except:
                continue
            if str(self.clients[i].id) == str(myId):
                continue
            return key
    def startNewGame(self):
        for index in self.clients:
            if self.clients[index].is_authenticated==False:
                continue
            self.clients[index].send('%xt%pong%-1%1%' + str(self.game['hider']) + '%' + str(self.game['riddle']) + '%')
            self.clients[index].send('%xt%pouh%-1%1%' + str(self.game['hider']) + '%')
            if self.clients[index].username == self.game['hider']:
                self.clients[index].sendBotMsg('You are now invisible! You can use the command !RIDDLE [riddle] to set a riddle to help users out. Good luck! 60 seconds left to hide!')
                self.sendToRoom(True, self.clients[index].id, self.clients[index].userInfo['room_id'], '%xt%rp%-1%' + str(self.clients[index].id) + '%')
                self.clients[index].invisible = True
                self.game['isOn'] = True
                self.game['canFind'] = False
                self.timer = threading.Timer(60.0, self.setVisible)
                self.timer.start()
            else:
                self.clients[index].sendBotMsg('The match is about to begin! ' + str(self.game['hider']) + ' will now go invisible and have 60 seconds to hide! Good luck to all!')

        return True
    def setVisible(self):
        if self.game['isOn'] == False:
            return False
        self.game['canFind'] = True
        for index in self.clients:
            if self.clients[index].is_authenticated==False:
                continue
            if self.clients[index].username == self.game['hider']:
                self.clients[index].invisible = False
                self.clients[index].canSwitchRooms = False
                self.rooms[str(self.clients[index].userInfo['room_id'])]['containsHiddenPlayer'] = True
                self.rooms[str(self.clients[index].userInfo['room_id'])]['hiddenPlayer'] = self.clients[index]
                self.clients[index].sendBotMsg('You are now visible for all! Good luck! Don\'t forget about !RIDDLE [riddle]...') 
            else:
                self.clients[index].sendBotMsg(str(self.game['hider']) + ' is ready! Happy searching and good luck to all!')
            
    def handleSendPlayer(self, socket, pack_arr):
        try:
            pack_arr[5]
            pack_arr[6]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        if pack_arr[6].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.userInfo['pos']['x'] = pack_arr[5] or 0
        user.userInfo['pos']['y'] = pack_arr[6] or 0
        self.sendToRoom(False, user.id, user.userInfo['room_id'], '%xt%sp%-1%' + str(user.id) + '%' + str(pack_arr[5]) + '%' + str(pack_arr[6]) + '%')
        return True
    def handleSendBall(self, socket, pack_arr):
        try:
            pack_arr[5]
            pack_arr[6]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        if pack_arr[6].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%sb%-1%'+str(user.id)+'%'  + str(pack_arr[5]) + '%' + str(pack_arr[6]) + '%')
        return True
    def handleSetAction(self, socket, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.userInfo['frame'] = pack_arr[5]
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%sa%-1%'+str(user.id)+'%'  + str(pack_arr[5]) + '%')
        return True
    def handleSendSafeMessage(self, socket, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%ss%-1%'+str(user.id)+'%'  + str(pack_arr[5]) + '%')
        return True
    def handleSendEmote(self, socket, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%se%-1%'+str(user.id)+'%'  + str(pack_arr[5]) + '%')
        return True
    def handleSendJoke(self, socket, pack_arr):
        return False
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%sj%-1%'+str(user.id)+'%' + str(pack_arr[5]) + '%')
        return True
    def handleSetFrame(self, socket, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.userInfo['frame'] = pack_arr[5]
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%sf%-1%' +str(user.id)+'%' + str(pack_arr[5]) + '%')
        return True
    def handleAddItem(self, socket, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False: 
            return False
        return True
    def handleJoinRoom(self, socket, pack_arr):
        try:
            pack_arr[5]
            pack_arr[6]
            pack_arr[7]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        if pack_arr[6].isdigit() == False:
            return False
        if pack_arr[7].isdigit() == False:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        if self.game['hider'] == user.username:
            self.game['room'] = pack_arr[5]
        user.joinRoom(pack_arr[5], pack_arr[6], pack_arr[7])
        return True
    def handleKick(self, socket, pack_arr):
        try:
            pack_arr[5]
            self.clients[socket].id
        except:
            return False
        if(self.clients[socket].userInfo['crumbs']['isModerator'] != True):
            return False
        for sock in self.clients:
            try:
                self.clients[sock].id
            except:
                continue
            if self.clients[sock].is_authenticated==False:
                continue
            if self.clients[sock].id == pack_arr[5]:
                self.clients[sock].send('%xt%e%-1%5%')
                self.removeSocket(sock)
                return True
        return False
    def handleUpdateClothes(self, socket, pack_arr):
        try:
            pack_arr[3]
            pack_arr[5]
        except:
            return False
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        valid = re.match('^[\w-]+$', pack_arr[5]) is not None
        if valid == False:
            return False
        if pack_arr[3] == 's#upc':
            return user.updateClothes('color', pack_arr[5])
        if pack_arr[3] == 's#uph':
            return user.updateClothes('head', pack_arr[5])
        if pack_arr[3] == 's#upf':
            return user.updateClothes('face', pack_arr[5])
        if pack_arr[3] == 's#upn': 
            return user.updateClothes('neck', pack_arr[5])
        if pack_arr[3] == 's#upa': 
            return user.updateClothes('hands', pack_arr[5])
        if pack_arr[3] == 's#upe': 
            return user.updateClothes('feet', pack_arr[5])
        if pack_arr[3] == 's#upp': 
            return user.updateClothes('photo', pack_arr[5])
        if pack_arr[3] == 's#upl': 
            return user.updateClothes('pin', pack_arr[5])
        if pack_arr[3] == 's#upb': 
            return user.updateClothes('body', pack_arr[5])
        return True
    def handleMessage(self, socket, pack_arr):
        try:
            pack_arr[5]
            pack_arr[6]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        if pack_arr[6] is None or pack_arr[6].__len__ < 1:
            return False
        user = self.clients[socket]
        if user.userInfo['isMuted'] == True:
            return False
        message = pack_arr[6]
        commandPrefixes = ['!', ':', '/']
        if message[0:1] in commandPrefixes:
            exp = message[1:].split(' ')
            cmd = exp[0].lower()
            if cmd == 'id':
                user.sendBotMsg('Your ID: ' + str(user.id))
                return True
            if cmd == 'ping':
                user.sendBotMsg('Pong, you\'re connected!')
                return True
            if cmd == 'users':
                user.sendBotMsg('Online Users:' + str(len(self.clients)))
                return True
            if cmd == 'jr':
                if len(exp) == 1:
                    return False
                if exp[1].isdigit() == True:
                    user.joinRoom(exp[1], 0, 0)
                    return True
            if cmd == 'pass':
                if self.game['hider'] == user.username or user.userInfo['crumbs']['isModerator'] == True:
                    self.game['canFind'] = False
                    self.game['isOn'] = False
                    self.game['riddle'] = ''
                    if len(self.clients) > 1:
                        notMe = True
                    else:
                        notMe = False
                    search4user = False
                    usr = ''
                    if len(exp) > 1:
                        search4user = True
                        exp.remove(exp[0])
                        usr = ' '.join(exp)
                        if usr == self.game['hider']:
                            search4user = False
                    for l in self.clients:
                        try:
                            self.clients[l].id
                        except:
                            continue
                        if self.clients[l].is_authenticated==False:
                            continue
                        if self.clients[l].username == self.game['hider']:
                            self.clients[l].invisible = False
                            self.clients[l].canSwitchRooms = True
                            self.rooms[str(self.clients[l].userInfo['room_id'])]['containsHiddenPlayer'] = False
                            self.rooms[str(self.clients[l].userInfo['room_id'])]['hiddenPlayer'] = False
                        if self.game['isOn'] == False:
                            if notMe and self.clients[l].username == self.game['hider']:
                                continue
                            if search4user == True and usr.lower() != self.clients[l].username.lower():
                                continue
                            self.game['isOn'] = True
                            self.game['hider'] = str(self.clients[l].username)
                            self.rooms[str(user.userInfo['room_id'])]['containsHiddenPlayer'] = True
                            self.rooms[str(user.userInfo['room_id'])]['hiddenPlayer'] = user
                            try:
                                self.timer.cancel()
                            except:
                                print 'no tiemr~~'
                            self.timer = threading.Timer(60.0, self.startNewGame)
                            self.timer.start()
                            self.clients[l].sendBotMsg('Congrats! You\'re the next hider! Wait 60 seconds until the bot tells you when to start hiding!')
                        else:
                            self.clients[l].send('%xt%pouh%-1%1%' + str(self.game['hider']) + '%')
                            self.clients[l].sendBotMsg('The hider has decided to pass their turn. The next hider is: ' + str(self.game['hider']) + '.')
                    return True
            if cmd == 'global':
                if len(exp) == 1:
                    return False
                if user.userInfo['crumbs']['isModerator'] == True:
                    exp.remove(exp[0])
                    msg = ' '.join(exp)
                    self.sendToRoom(False, user.id, user.userInfo['room_id'], '%xt%sm%-1%0%' + str(msg) + '%')
                    return True
            if cmd == 'ban':
                if len(exp) == 1:
                    return False
                if user.userInfo['crumbs']['isModerator'] == True:
                    exp.remove(exp[0])
                    msg = ' '.join(exp)
                    for j in self.clients:
                        try:
                            self.clients[j].id
                        except:
                            continue
                        if self.clients[j].username.lower() == msg.lower():
                            self.clients[j].userInfo['crumbs']['isBanned'] = True
                            query = 'UPDATE `accs` SET `crumbs` = "' + self.MySQL.escape(serialize(self.clients[j].userInfo['crumbs'])) + '"  WHERE `ID` = "' + self.MySQL.escape(self.clients[j].id) + '"'
                            try:
                                self.MySQL.updateData(query)
                                self.removeSocket(j)
                            except:
                                print 'no'
                            return True
                    return True
            if cmd == 'cc':
                if len(exp) == 1:
                    return False
                valid = re.match('^[\w-]+$', exp[1]) is not None
                if valid == False:
                    return False
                if str(exp[1])[0:2].lower() != '0x':
                    exp[1] = '0x' + str(exp[1])
                self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upc', '-1', str(exp[1])])
                return True
            if cmd == 'up':
                if len(exp) == 1:
                    return False
                if exp[1].lower() == '0':
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#uph', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upf', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upn', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upa', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upp', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upe', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upl', '-1', '0'])
                    self.handleUpdateClothes(socket, ['', 'xt', 's', 's#upb', '-1', '0'])
                    return True
                return True
            if cmd == 'riddle':
                if len(exp) == 1:
                    return False
                if self.game['hider'] == user.username or user.userInfo['crumbs']['isModerator'] == True:
                    exp.remove(exp[0])
                    msg = ' '.join(exp)
                    self.game['riddle'] = msg
                    print 'New riddle by ' + str(user.username) + ': ' + str(msg) + '\n'
                    if self.game['hider'] == user.username and user.invisible == True:
                        user.invisible = False
                        user.canSwitchRooms = False
                        self.game['canFind'] = True
                        self.rooms[str(user.userInfo['room_id'])]['containsHiddenPlayer'] = True
                        self.rooms[str(user.userInfo['room_id'])]['hiddenPlayer'] = user
                        sendREADY = True
                        try:
                            self.timer.cancel()
                        except:
                            print 'o timer erore\n'
                        user.sendBotMsg('Since you\'ve used !RIDDLE, you\'re now visible for everyone! You can no longer switch rooms.')
                    else:
                        sendREADY = False
                        user.sendBotMsg('Riddle updated & logged to make sure you aren\'t absuing!')
                    for sock in self.clients:
                        if self.clients[sock].is_authenticated==False:
                            continue    
                        self.clients[sock].send('%xt%pour%-1%1%' + msg + '%')
                        if sendREADY == True and self.clients[sock].username != self.game['hider']:
                            self.clients[sock].sendBotMsg(str(self.game['hider']) + ' is ready! Happy searching and good luck to all!')
                    return True
            if cmd == 'kick':
                if len(exp) == 1:
                    return False
                if user.userInfo['crumbs']['isModerator'] == True:
                    exp.remove(exp[0])
                    user = ' '.join(exp)
                    for sock in self.clients:
                        if self.clients[sock].is_authenticated==False:
                            continue
                        if self.clients[sock].username.lower() == user.lower():
                            self.clients[sock].send('%xt%e%-1%5%')
                            self.removeSocket(sock)
                            return True
                    return True
            if cmd == 'cheat':
                if user.userInfo['crumbs']['isModerator'] == True:
                    user.send('%xt%sm%-1%0%' + str(self.game['room']) + '%')
                    return True
        self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%sm%-1%' + str(user.id) + '%' + str(pack_arr[6]) + '%')
        return True
    def handleBuddyFind(self, sock, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        if pack_arr[5].isdigit() == False:
            return False
        user = self.clients[sock]
        user.send('%xt%bf%-1%322%')
        return True
    def handleQPA(self, sock, pack_arr):
        try:
            pack_arr[5]
        except:
            return False
        user = self.clients[sock]
        user.send('%xt%qpa%-1%' + str(pack_arr[5]) + '%')
        return True
    def handleDummyGP(self, sock, pack_arr):
        user = self.clients[sock]
        try:
            user.send('%xt%gp%-1%' + str(user.generateString()) + '%')
        except:
            print 'ugh\n'
        return True
    def handleDummyMG(self, sock, pack_arr):
        user = self.clients[sock]
        user.send('%xt%mg%-1%%')
        return True
    def isOnline(self, playerID):
        if playerID.isdigit() == False:
            return False
        online = False
        for csock in self.clients:
            if self.clients[csock].is_authenticated==False:
                continue
            if self.clients[csock].id == playerID:
                return csock
        return False
    def sendToRoom(self, excludeMe, myID, room_id, packet):
        if self.rooms.has_key(str(room_id)):
            for sock in self.rooms[str(room_id)]['clients']:
                try:
                    self.clients[sock].id
                except:
                    continue
                if self.clients[sock].username == '':
                    continue
                if str(self.clients[sock].id) == str(myID) and bool(excludeMe) == True:
                    continue
                else:
                    self.clients[sock].send(packet)
        return True
    def swapSHA256(self, password, sha = True):
        passwd = password
        if sha == True:
            passwd = hashlib.sha256(password).hexdigest()
        return passwd[32:] + passwd[:32]
    def hashPassword(self, password, random_key):
        hash = self.swapSHA256(password + str(random_key))
        hash = hash + password
        return hash.lower()
    def removeSocket(self, sock):
        if self.clients.has_key(sock) == False:
            print 'Error! Client has no sock key!'
            return False
        print "Client removed"
        if self.clients[sock].is_authenticated == True:
            try:
                self.MySQL.updateData('UPDATE servers SET onlineUsers = "'+str(self.MySQL.escape(str(len(self.clients))))+'" WHERE serverID="'+str(self.MySQL.escape(str(self.ID)))+'"')
            except:
                print 'st\n'
            self.rooms[str(self.clients[sock].userInfo['room_id'])]['clients'].pop(self.clients[sock].sock)
            self.sendToRoom(True, self.clients[sock].id, self.clients[sock].userInfo['room_id'], '%xt%rp%-1%' + str(self.clients[sock].id) + '%')
            try:
                self.clients[sock].sock.close()
            except socket.error:
                print "Couldn\'t close a socket"
            user = self.clients[sock]
            user.sendToBuddies('%xt%bof%-1%' + str(user.id) + '%')
            if self.game['hider'] == user.username and self.shuttingDown == False:
                print 'ahah the hider is leaving the game!\n'
                try:
                    self.timer.cancel()
                except:
                    print 'Oh! No timer!\n'
                try:
                    self.rooms[user.userInfo['room_id']]['containsHiddenPlayer'] = False
                except:
                    print 'n0p3'
                self.game['isOn'] = False
                self.game['hider'] = ''
                self.game['canFind'] = False
                for sok in self.clients:    
                    try:
                        idd = self.clients[sok].id
                    except:
                        continue
                    if self.clients[sok].id == user.id:
                        continue
                    if self.game['isOn'] != True:
                        self.game['hider'] = self.clients[sok].username
                        self.game['riddle'] = ''
                        self.game['isOn'] = True
                        self.timer = threading.Timer(60.0, self.startNewGame)
                        self.timer.start()
                    self.clients[sok].sendBotMsg('It seems the hider left the server! Oh well! ' + str(self.game['hider']) + ' is the next hider...')
            query = 'UPDATE `accs` SET `crumbs` = "' + self.MySQL.escape(serialize(user.userInfo['crumbs'])) + '"  WHERE `ID` = "' + self.MySQL.escape(user.id) + '"'
            self.MySQL.updateData(query)
        self.socket_arr.remove(sock)
        self.clients.pop(sock)
        return True
    def close(self, signal, frame):
        try:
            self.MySQL.updateData('UPDATE servers SET onlineUsers = "'+str(self.MySQL.escape(str(len(self.clients))))+'" WHERE serverID="'+str(self.MySQL.escape(str(self.ID)))+'"')
        except:
            print 'st\n'
        print '\n\nShutting down...\n\n'
        self.shuttingDown = True
        self.timer.cancel()
        self.__del__()
    def __del__(self):
        for sock in self.clients:
            self.removeSocket(sock)
        print 'Goodbye!'
CPPSGame(9875, 102) # run the game server on 9875
