import threading
from copy import deepcopy
import time
import signal
import sys
import os

class OasisCleanUp ():
	
	def __init__ (self, parent):
		self.parent = parent
		self.timer = threading.Timer(300.0, self.__ThreadService)
		self.timer.start()
		signal.signal(signal.SIGINT, self.handleSignal)
		print '[OasisCleanUp] -> Thread Started .... Running every 5 minutes to prevent pile-ups'
		
	def handleSignal (self, _a2, _a3) :
		self.timer.cancel()
		try:
			sys.exit()
		except:
			print 'Forcefully cancelling thread..'
			os._exit(1)
		
	def __ThreadService (self) :
		userDict = deepcopy(self.parent.users)
		recentTime = time.time() - 420
		usersRemoved = 0
		for i in userDict :
			#assuming the client properly sends the heartbeat every (?) minutes - kills bots since nobody (kids with their php bots) has managed to send the heartbeat right
			if self.parent.users[i].lastHeartbeat < recentTime: #if the user's last sent heartbeat is more than 5 minutes ago...
				usersRemoved += 1
				self.parent.users[i].skipMe = True #...skip them from the sendToRoom func just in-case the server fails (?) to remove them properly...
				try:
					self.parent.roomMap[int(self.parent.users[i].roomID)]['clients'].pop(int(i)) #...attempt to remove them from the room...
				except:
					print "[OasisCleanUp] -> Failed removing a client from the ROOM dict - so setting it to False!"
					self.parent.roomMap[int(self.parent.users[i].roomID)]['clients'][int(i)] = False
				try:
					self.parent.users[i].connectionLost('') #...try to nicely remove them and properly save their crumbs...
				except:
					print "[OasisCleanUp] -> Failed removing a client from the USER dict - so setting it to False!"
					self.parent.users[i] = False
				try:
					self.parent.users.pop(i) #...and *attempt* to remove them from the users dictionary
				except:
					print "[OasisCleanUp] -> Failed popping a client from the USER dict - so setting it to False!"
					self.parent.users[i] = False
		print '[OasisCleanUp][__ThreadService] -> Removed ' + str(usersRemoved) + ' users...'
