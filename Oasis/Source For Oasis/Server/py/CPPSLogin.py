import socket
import select
import string
import hashlib
import pickle
import ConfigParser
import time
import sys
import CPPSMySQL
from Clients import CPPSLoginClient
from phpserialize import unserialize, serialize
from lxml import etree

config = ConfigParser.ConfigParser()
config.read('config.ini')


class CPPSLogin:
	
	def __init__(self, port):
		
		print "\t\t\tPython Login Server v2.0"
		print "\t\t \tWritten by Tybone10 "
		
		self.socket_server = None
		self.socket_arr = []
		self.clients = {}

		self.main_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		self.main_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
		self.main_sock.bind(("", port))
		self.main_sock.listen(5)

		self.socket_arr.append(self.main_sock)
		
		self.MySQL = CPPSMySQL.CPPSMySQL({'host': str(config.get('MySQL', 'host')), 'user': str(config.get('MySQL', 'user')), 'pass': str(config.get('MySQL', 'pass')), 'name': str(config.get('MySQL', 'name'))})
		
		print "Python CPPS login server started."
		
		while 1:
			rsock, wsock, esock = select.select(self.socket_arr,[],[])
			for sock in rsock:
				if sock == self.main_sock:
					sockfd, addr = self.main_sock.accept()
					self.socket_arr.append(sockfd)
					self.clients[sockfd] = CPPSLoginClient.CPPSLoginClient(self, addr, sockfd)#add the client to the clients dict
				else:
					try:
						data = sock.recv(8192)
					except socket.error:
						print 'Error receiving from %s:%s' % addr
						continue
					if data:
						data_args = data.split(chr(0)) #split by chr(0) because sometimes packets stick
						for l_data in data_args:#go through each packet
							if l_data:
								if l_data[0:1] is not '<':
									continue #basically, if the packet doesn't start with "<" we skip that because on login you only should have xml packets
								if l_data == '<policy-file-request/>':
									self.clients[sock].send('<cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>')
									continue
								try:
									data = etree.fromstring(l_data)
								except:
									print 'Bad XML packet ! \n'
									self.removeSocket(sock)
									continue
								try:
									data = data[0]
								except:
									continue
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
										print 'ascii error! failed to select user from database!\n'
									if user == False:
										self.clients[sock].send('%xt%e%-1%100%')
										continue
									if self.hashPassword(user[4], self.clients[sock].userInfo['rndK']) != password:
										self.clients[sock].send('%xt%e%-1%101%')
										continue
									try:
										crumbs = unserialize(user[3])
									except:
										print 'Client has no crumbs! ;o'
										self.clients[sock].send('%xt%e%-1%100%')
										continue
									set = False
									if bool(crumbs['isBanned']) == True:
										self.clients[sock].send('%xt%e%-1%603%')
										continue
									if bool(crumbs['isActive']) == False:
										self.clients[sock].send('%xt%e%-1%900%')
										continue
									if bool(crumbs['isPremium']) == False and str(crumbs['characterID']) != "12":
										crumbs['characterID'] = '12'
										set = 'PREM'
									if bool(crumbs['isModerator']) == True:
										MKEY = hashlib.md5((password) + str(username)).hexdigest()
										set = 'MOD'
									login_key = self.clients[sock].generateLoginKey(username)
									try:
										if set == "PREM":
											query = 'UPDATE `accs` SET `lastIP` = "' + str(self.clients[sock].userInfo['ip']) + '", `lastLogin` = "' + str(time.time()) + '", `loginKey` = "' + str(self.MySQL.escape(login_key)) + '", `crumbs` = "' + str(self.MySQL.escape(serialize(crumbs))) + '", `hasRedeemed`=1 WHERE `name` = "' + str(self.MySQL.escape(username)) + '"'
										elif set == 'MOD':
											query = 'UPDATE `accs` SET `lastIP` = "' + str(self.clients[sock].userInfo['ip']) + '", `lastLogin` = "' + str(time.time()) + '", `loginKey` = "' + str(self.MySQL.escape(login_key)) + '", `mKey`="'+str(MKEY)+'" WHERE `name` = "' + str(self.MySQL.escape(username)) + '"'
										else:
											query = 'UPDATE `accs` SET `lastIP` = "' + str(self.clients[sock].userInfo['ip']) + '", `lastLogin` = "' + str(time.time()) + '", `loginKey` = "' + str(self.MySQL.escape(login_key)) + '" WHERE `name` = "' + str(self.MySQL.escape(username)) + '"'
										self.MySQL.updateData(query)
									except:
										print 'AHHH!!!\n'
										continue
									try:
										querys = self.MySQL.selectData('SELECT * FROM `servers`', 'all')
									except:
										print 'wat\n'
										querys = False
									string = ''
									if querys != False:
										for row in querys:
											string += '|' + str(row[0]) + ','+str(row[1])+',?,'+str(row[2])+','+str(row[3])
									else:
										string = '|101,?,?,1,1|102,?,?,2,1'
									if bool(crumbs['isModerator']) == True:
										self.clients[sock].send('%xt%smkey%-1%' + MKEY + '%')
									print str(username) + ':' + str(self.clients[sock].userInfo['ip']) + ' successfully identified!\n'
									self.clients[sock].send('%xt%l%-1%' + str(user[0]) + '%' + str(login_key) + '%%101,1|102,0|%' + str(string) + '%' + str(crumbs['color']) + '%' + '%' + str(user[1]) + '%') 
					else:
						self.removeSocket(sock)
						continue
										
	def swapSHA256(self, password, sha = True): #Password Hashing Notice
		passwd = password
		if sha is True:
			passwd = hashlib.sha256(password).hexdigest()
		return passwd[32:] + passwd[:32]
	def hashPassword(self, password, random_key):
		hash = self.swapSHA256(password, False).upper()
		hash = hash + str(random_key) + "Y(02.>'H}t\":E1"
		hash = self.swapSHA256(hash)
		return hash
	def removeSocket(self, sock):
		try:
			self.clients[sock]
		except:
			return False
		if self.clients[sock] != None:
			try:
				self.clients[sock].sock.close()
			except:
				print 'Couldn\'t close a socket'
			self.socket_arr.remove(sock)
			self.clients.pop(sock)
			return True
		else:
			return False
	def __del__(self):
		self.main_sock.close() #close the main socket 
CPPSLogin(9875) # run the server on port 6112