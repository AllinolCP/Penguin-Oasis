import time
import re
class OasisCommands:

	def __init__(self, Oasis):
		self.parent = Oasis
	
	def runCommand(self, string, client):
		s = string.split(' ')
		cmd = s[0].upper()
		if cmd == '!GLOBAL':
			if client.crumb('isAdmin') != True:
				return False
			msg = string[7:]
			for i in client.parent.users:
				try:
					client.parent.users[i].nickname
				except:
					continue
				client.parent.users[i].sendBotMessage(msg)
			return True
		if cmd == '!GLOBAL_NOTE':
			if client.crumb('isAdmin') != True:
				return False
			msg = string[12:]
			for i in client.parent.users:
				try:
					client.parent.users[i].nickname
				except:
					continue
				client.parent.users[i].sendLine('%xt%note%-1%' + str(msg) + '%')
			return True
		if cmd == '!RELOAD_PATCH':
			client.parent.reloadClientFile ()
			return client.sendBotMessage('The client module has been RELOADED!')
		if cmd == '!TEST':
			return client.sendToRoom('%xt%tnbchslide%-1%' + str(client.ID) + '%' + str(s[1]) + '%')
		if cmd == '!MOD':
			if client.crumb('isAdmin') != True:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ' '.join(s)
			for i in client.parent.users:
				try:
					client.parent.users[i]
					client.parent.users[i].nickname
				except:
					continue
				if client.parent.users[i].nickname.lower() == user.lower():
					client.parent.users[i].crumb('isModerator', True)
					return True
			user = client.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs` FROM `accs` WHERE `name` = (%s)", (user))
			user.addCallback(client._mysqlGotUserForMod)
			return True
		if cmd == '!CLONE' or cmd == '!CLONEN':
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ''
			for i in s:
				user += ' ' + str(i)
			user = user[1:]
			for i in client.parent.users:
				try:
					client.parent.users[i]
					client.parent.users[i].nickname
				except:
					continue
				if client.parent.users[i].nickname.lower() == user.lower():
					client.setOutfit(client.parent.users[i].crumb('color'), client.parent.users[i].crumb('head'), client.parent.users[i].crumb('face'), client.parent.users[i].crumb('neck'), client.parent.users[i].crumb('body'), client.parent.users[i].crumb('hands'), client.parent.users[i].crumb('feet'), client.parent.users[i].crumb('pin'), client.parent.users[i].crumb('photo'), True)
					return True
			user = client.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs` FROM `accs` WHERE `name` = (%s)", (user))
			user.addCallback(client._mysqlGotUserForClone)
			return True
		if cmd == '!DEMOD' or cmd == '!DEMOTE' or cmd == '!UNMOD':
			if client.crumb('isAdmin') != True:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ' '.join(s)
			for i in client.parent.users:
				try:
					client.parent.users[i]
					client.parent.users[i].nickname
				except:
					continue
				if client.parent.users[i].nickname.lower() == user.lower():
					client.parent.users[i].crumb('isModerator', False)
					return True
			user = client.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs` FROM `accs` WHERE `name` = (%s)", (user))
			user.addCallback(client._mysqlGotUserForDemod)
			return True
		if cmd == '!UNBAN':
			if client.crumb('isAdmin') != True:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ' '.join(s)
			user = client.parent.MySQL.dbAPI.runQuery("SELECT `ID`,`crumbs` FROM `accs` WHERE `name` = (%s)", (user))
			user.addCallback(client._mysqlGotUserForUnban)
			return True
		if cmd == '!NICK':
			user = ' '.join(s)
			if user.lower() != client.nickname.lower():
				return False
			client.nickname = user
			client.hasNickChanged = True
			client.sendToRoom('%xt%upun%-1%' + str(client.ID) + '%' + str(user) + '%')
			return True
		if cmd == '!CC':
			try:
				s[1]
			except:
				return False
			valid = re.match('^[\w-]+$', s[1]) is not None
			if valid == False:
				return False
			if str(s[1])[0:2].lower() != '0x':
				s[1] = '0x' + str(s[1])
			client.crumb('color', str(s[1]))
			client.sendToRoom('%xt%upc%-1%' + str(client.ID) + '%' + str(s[1]) + '%')
			return True
		if cmd == '!USERS' or cmd == '!USER' or cmd == '!COUNT':
			return client.sendBotMessage('Online Users: ' + str(client.parent.onlineUsers))
		if cmd == '!PING':
			return client.sendLine('%xt%ping%-1%' + str(time.time()) + '%')
		if cmd == '!FIND':
			if client.crumb('isModerator') == False:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ''
			for i in s:
				user += ' ' + str(i)
			user = user[1:].lower()
			for i in client.parent.users:
				if client.parent.users[i].nickname.lower() == user:
					return client.handleGetPlayerLocationById({5: str(client.parent.users[i].ID)}, '')
			return False
		if cmd == '!GOTO':
			if client.crumb('isModerator') == False:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ''
			for i in s:
				user += ' ' + str(i)
			user = user[1:].lower()
			for i in client.parent.users:
				try:
					client.parent.users[i].nickname
				except:
					continue
				if client.parent.users[i].nickname.lower() == user:
					if int(client.parent.users[i].roomID) > 1000:
						client.sendLine('%xt%pg%-1%2%')
						client.handleGetPlayerIgloo({5:str((int(client.parent.users[i].roomID) - 1000))}, '')
						client.handleJoinPlayerIgloo({5:str(client.parent.users[i].roomID)}, '')
						return True
					return client.joinRoom(int(client.parent.users[i].roomID), 0, 0)
			return False
		if cmd == '!CLEANUP':
			if client.crumb('isModerator') == False:
				return False
			client.parent.runCleanup()
			return False
		if cmd == '!FAKE_BEAT':
			if client.crumb('isModerator') == False:
				return False
			client.lastHeartbeat = 0
			return False
		if cmd == '!CONN_COUNT' or cmd == '!CONNECTION_COUNT':
			return client.sendBotMessage('Connected Clients: ' + str(len(client.parent.users)))
		if cmd == '!SUMMON':
			if client.crumb('isModerator') == False:
				return False
			try:
				s[1]
			except:
				return False
			s.pop(0)
			user = ''
			for i in s:
				user += ' ' + str(i)
			user = user[1:].lower()
			for i in client.parent.users:
				if client.parent.users[i].nickname.lower() == user:
					if int(client.roomID) > 1000:
						client.parent.users[i].sendLine('%xt%pg%-1%2%')
						client.parent.users[i].handleGetPlayerIgloo({5:str((int(client.roomID) - 1000))}, '')
						client.parent.users[i].handleJoinPlayerIgloo({5:str(client.roomID)}, '')
						return True
					return client.parent.users[i].joinRoom(int(client.roomID), 0, 0)
			return False
		if cmd == '!AI':
			try:
				s[1]
			except:
				return False
			if client.is_numeric(s[1]) == False:
				return False
			client.addItem(s[1])
			return True
		if cmd == '!UI':
			try:
				s[1]
			except:
				return False
			if client.is_numeric(s[1]) == False:
				return False
			client.handleActivateIgloo({5: str(s[1])}, '')
			return True
		if cmd == '!AF':
			try:
				s[1]
			except:
				return False
			if client.is_numeric(s[1]) == False:
				return False
			client.addFurniture(s[1])
			return True
		if cmd == '!NG' or cmd == '!NC':
			if client.crumb('hasNG') == False:
				return False
			try:
				ng = s[1]
			except:
				ng = '0'
			try:
				nc = s[2]
			except:
				nc = '0'
			if ng == False:
				ng = '0'
			if nc == False:
				nc = '0'
			ng = ng.lower()
			nc = nc.lower()
			ng = ng.replace('0x', '')
			nc = nc.replace('0x', '')
			s1 = ng.__len__()
			s2 = nc.__len__()
			if s1 != 3 and s1 != 6 and ng != '0':
				return False
			if s2 != 3 and s2 != 6 and nc != '0':
				return False
			client.crumb('nameglow', '0' if ng == '0' else '0x' + ng)
			client.crumb('namecolor', '0' if nc == '0' else '0x' + nc)
			client.sendToRoom('%xt%ung%-1%' + str(client.ID) + '%' + str(client.crumb('nameglow')) + '%' + str(client.crumb('namecolor')) + '%')
			return True
		if cmd == '!BC':
			if client.crumb('hasBC') == False:
				return False
			try:
				bc = s[1]
			except:
				bc = '0'
			try:
				tc = s[2]
			except:
				tc = '0'
			if bc == False:
				bc = '0'
			if tc == False:
				tc = '0'
			bc = bc.lower()
			tc = tc.lower()
			try:
				pc = s[3].lower()
			except:
				pc = bc
			bc = bc.replace('0x', '')
			tc = tc.replace('0x', '')
			pc = pc.replace('0x', '')
			s1 = bc.__len__()
			s2 = tc.__len__()
			s3 = pc.__len__()
			if s1 != 3 and s1 != 6 and bc != '0':
				return False
			if s2 != 3 and s2 != 6 and tc != '0':
				return False
			if s3 != 3 and s3 != 6 and pc != '0':
				return False
			client.crumb('bubbleColor', '0' if bc == '0' else '0x' + bc)
			client.crumb('bubbleTextColor', '0' if tc == '0' else '0x' + tc)
			client.crumb('pointerColor', '0' if pc == '0' else '0x' + pc)
			client.sendToRoom('%xt%ubc%-1%' + str(client.ID) + '%' + str(client.crumb('bubbleColor')) + '%' + str(client.crumb('pointerColor')) + '%' + str(client.crumb('bubbleTextColor')) + '%')
			return True
		if cmd == '!REFRESH':
			if client.crumb('isAdmin') == False:
				return False
			client.parent.refreshServerSettings()
			return True
		if cmd == '!RC':
			if client.crumb('hasRC') == False:
				return False
			try:
				rc = s[1]
			except:
				rc = '0'
			if rc == False:
				rc = '0'
			rc = rc.lower()
			rc = rc.replace('0x', '')
			s1 = rc.__len__()
			if s1 != 3 and s1 != 6 and rc != '0':
				return False
			client.crumb('ringColor', '0' if rc == '0' else '0x' + rc)
			client.sendToRoom('%xt%umrc%-1%' + str(client.ID) + '%' + str(client.crumb('ringColor')) + '%')
			return True
		if cmd == '!SC':
			if client.crumb('hasSC') == False:
				return False
			try:
				sc = s[1]
			except:
				sc = '0'
			if sc == False:
				sc = '0'
			sc = sc.lower()
			sc = sc.replace('0x', '')
			s1 = sc.__len__()
			if s1 != 3 and s1 != 6 and sc != '0':
				return False
			client.crumb('snowballColor', '0' if sc == '0' else '0x' + sc)
			client.sendLine('%xt%umsc%-1%' + str(client.crumb('snowballColor')) + '%')
			return True
		if cmd == '!FAST':
			if client.crumb('hasSpeed') == False:
				return False
			client.crumb('speed', '1')
			client.sendLine('%xt%umps%-1%1%')
			return True
		if cmd == '!TELEPORT':
			if client.crumb('hasSpeed') == False:
				return False
			client.crumb('speed', '2')
			client.sendLine('%xt%umps%-1%2%')
			return True
		if cmd == '!NORMAL':
			if client.crumb('hasSpeed') == False:
				return False
			client.crumb('speed', '0')
			client.sendLine('%xt%umps%-1%0%')
			return True
		return 'NO_CMD'
