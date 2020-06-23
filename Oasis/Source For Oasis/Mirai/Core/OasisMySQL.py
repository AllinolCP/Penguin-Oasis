from twisted.enterprise import adbapi
import sys

class OasisMySQL:

	def __init__(self, config):
		self.config = config
		try:
			self.dbAPI = adbapi.ConnectionPool("MySQLdb", db = config['name'], port = 3306, user=config['user'], passwd = config['pass'], host = config['host'], cp_reconnect=True)
		except:
			print "\033[91m[Mirai] -> Unable to connect to the MySQL database on " + config['host'] + '\033[0m'
			sys.exit()
		if self.dbAPI == False:
			print "\033[91m[Mirai] -> Unable to connect to the MySQL database on " + config['host'] + '\033[0m'
			sys.exit()
		print "\033[92m[Mirai] -> Successfully connected to database on: " + config['host'] + '\033[0m'
	def updateData(self, query):
		return self.dbAPI.runQuery(query)
