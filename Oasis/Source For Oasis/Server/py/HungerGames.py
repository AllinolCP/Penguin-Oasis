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
from Clients import HungerGamesClient
from lxml import etree
import threading

config = ConfigParser.ConfigParser()
config.read('config.ini')

class HungerGames:
    
    def __init__(self, port, id):
        
        print "\t\t\tPython Game Server v2.0 "
        
        self.ID = id
        self.socket_server = None
        self.socket_arr = []
        self.clients = {}
        self.timer = None
        
        self.config = config #store the config stuff for CPPSGameClient
        
        self.cached_users = {}#instead of executing a query to fetch the user's name for someone's buddy list every single time they login, we cache the id => name
        
        self.main_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.main_sock.bind(("", port))
        self.main_sock.listen(5)
        self.shuttingDown = False
        self.socket_arr.append(self.main_sock)
        
        signal.signal(signal.SIGINT, self.close)
        self.teams = { 
            '1': {'name': 'District 1', 'players' : {}, 'base': 555},
            '2': {'name': 'District 2', 'players' : {}, 'base': 556},
            '3': {'name': 'District 3', 'players' : {}, 'base': 557}
        }
        self.game = {'baseLocked': False, 'isOn': False, 'totalPlayers': 0, 'snowballs': {'l1' : 3, 'l2' : 2, 'l3': 2}, 'canGetBalls': False, 'isTimer': False}
        self.MySQL = CPPSMySQL.CPPSMySQL({'host': str(config.get('MySQL', 'host')), 'user': str(config.get('MySQL', 'user')), 'pass': str(config.get('MySQL', 'pass')), 'name': str(config.get('MySQL', 'name'))})
                
        print "Python CPPS game server started"
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
            'u#sj'    : 'handleSendJoke',
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
            'os#hgs'  : 'handleGetSupplies',
            }
        self.rooms = {
                        "0": {"name": "default", "int_id": 0, "game": False, "clients": {}},
                        "558": {"name": "bar", "int_id": 1, "game": False, "clients": {}},
                        "555": {"name": "base1", "int_id": 2, "game": False, "clients": {}},
                        "556": {"name": "base2", "int_id": 3, "game": False, "clients": {}},
                        "557": {"name": "base3", "int_id": 4, "game": False, "clients": {}}
                    }
        num = 4
        lr = 557
        while i < 20:
            lr += 1
            num += 1
            self.rooms[str(lr)] = {"name": "forest" + str(num), "int_id": int(num), "game": False, "clients": {}}
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
                                        hash = self.hashPassword(user[4], self.clients[sock].userInfo['rndK'])
                                        if hash != password:
                                            self.clients[sock].send('%xt%e%-1%101%')
                                            continue
                                        try:
                                            userCrumbs = unserialize(user[2])
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
    def returnRandTeam(self):
        if len(self.teams['1']) == 0:
            return '1'
        if len(self.teams['2']) == 0:
            return '2'
        if len(self.teams['3']) == 0:
            return '3'
        if len(self.teams['3']) < 3:
            return '3'
        if len(self.teams['2']) < 3:
            return '2'
        if len(self.teams['1']) < 3:
            return '1'
        goodTeams = []
        if len(self.teams['1']) < 5:
            goodTeams.append('1')
        if len(self.teams['2']) < 5:
            goodTeams.append('2')
        if len(self.teams['3']) < 5:
            goodTeams.append('3')
        try:
            rteam = random.choice(goodTeams)
        except:
            return 'none left'
        return rteam
    def handleJoinServer(self, socket, pack_arr):
        user = self.clients[socket]
        user.send('%xt%js%-1%0%1%' + str(int(user.userInfo['crumbs']['isModerator'])) + '%0%')
        user.send('%xt%gps%-1%%')
        user.send('%xt%mg%-1%%')
        user.send('%xt%lp%-1%' +  user.generateString() +'%' + str(user.userInfo['crumbs']['coins']) + '%0%1440%' + str(time.time()) + '%999%4%233%0%%7%')
        roomID = 323
        if self.game['isOn'] == False:
            room = self.returnRandTeam()
            if str(room) != 'none left':
                try: 
                    self.teams[str(room)]
                except:
                self.game['totalPlayers'] += 1
                self.teams[str(room)]['players'][socket] = user
                user.myTeam = room
                roomID = self.teams[str(room)]['base']
                if(self.game['totalPlayers'] == 9 and self.game['isTimer'] == False):
                    self.timer = threading.Timer(60.0, self.startNewGame)
                    self.timer.start()
                    self.game['isTimer'] = True
                    for x in self.clients:
                        try:
                            self.clients[x].id
                        except:
                            continue
                        self.clients[x].sendNotification('There is a total of 9 players, which is enough to start the game. The game will start in 60 seconds. This will allow others to join the game before it starts.')
                        continue
            else:
                roomID = 323
        user.joinRoom(roomID, 0, 0)
        user.canSwitchRooms = False
        return True
    def startNewGame(self):
        self.game['isOn'] = True
        for x in self.clients:
            try:
                self.clients[x].id
            except:
                continue
            if self.clients[x].myTeam != None:
                self.clients[x].sendNotification('The 60 seconds is up - you now have 2 minutes to talk to your teammates and figure out how you\'re going to play.')
        self.timer = threading.Timer(120.0, self.startNewGameTwo)
        self.timer.start()
    def startNewGameTwo(self):
        self.game['baseLocked'] = True
        for x in self.clients:
            try:
                self.clients[x].id
            except:
                continue
            if self.clients[x].myTeam != None:
                self.clients[x].sendNotification('It\'s time! Make your way to the bar to get your supplies! Happy Hunger Games! And may the odds be ever in your favor.')
                self.clients[x].canSwitchRooms = True
    def handleGetInventory(self, socket, pack_arr):
        user = self.clients[socket]
        items = ''
        for id in user.userInfo['crumbs']['items']:
            items +=  str(user.userInfo['crumbs']['items'][id]) + '%'
        user.send('%xt%gi%-1%' + str(items))
        return True
    def handleGetBuddies(self, socket, pack_arr):
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.send('%xt%gb%-1%%')
        return True
    def handleGetIgnored(self, socket, pack_arr):
        user = self.clients[socket]
        try:
            user.id
        except:
            return False
        user.send('%xt%gn%-1%%')
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
    def handleGetSupplies(self, socket, pack_arr):
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
        if(user.myTeam == None):
            return False
        if(user.userInfo['room_id'] != 558)
            return False
        if pack_arr[5] != 1 or pack_arr[5] != 2 or pack_arr[5] != 3:
            return False
        try:
            self.game.snowballs['l' + str(pack_arr[5])]
        except:
            return False
        if self.game.snowballs['l' + str(pack_arr[5])] == 0:
            return user.send('%xt%gs%-1%normal%Sorry! We\'re all out of those ones!%Okay%OUT%')
        else:
            self.game.snowballs['l' + str(pack_arr[5])] -= 1
            user.snowballType = pack_arr[5]
            user.send('%xt%uwt%-1%' + str(pack_arr[5]) + '%')
            self.sendToRoom(True, user.id, user.userInfo['room_id'], '%xt%hgsa%-1%' + str(pack_arr[5]) + '%' + str(self.game.snowballs['l' + str(pack_arr[5])]))
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
        if str(pack_arr[5]) == '555' or str(pack_arr[5]) == '556' or str(pack_arr[5]) == '557':
            if self.game['baseLocked'] == True:
                pack_arr[5] = 558
        user.joinRoom(pack_arr[5], pack_arr[6], pack_arr[7])
        return True
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
            if user.myTeam != None:
                team = None
                try:
                    team = self.teams[Number(myTeam)]
                except:
                    print 'wow.'
                if team != None:
                    self.game['totalPlayers'] -= 1
                    team['players'].pop(sock)
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
HungerGames(9842, 104) # run the game server on 9875
