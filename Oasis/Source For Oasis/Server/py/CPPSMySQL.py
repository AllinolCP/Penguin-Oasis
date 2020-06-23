import MySQLdb
import sys

class CPPSMySQL:

	def __init__(self, config):
		self.config = config
		try:
			self.MySQL = MySQLdb.connect(config['host'], config['user'], config['pass'], config['name'])
			print "Successfully connected to MySQL on " + config['host']
		except:
			print "Unable to connect to the MySQL database on " + config['host']
			sys.exit()
	def updateData(self, query):
		cursor = self.MySQL.cursor()
		try:
			cursor.execute(query)
		except:
			print "Error updating data: " + str(query)
			self.MySQL.close()
			self.reconnect()
			return True
		self.MySQL.commit()
		return True
	def selectData(self, query, amount = 'one'):
		cursor = self.MySQL.cursor()
		try:
			cursor.execute(query)
		except:
			print "Error selecting data: " + str(query)
			self.MySQL.close()
			self.reconnect()
			return False
		if cursor.rowcount == 0:
			return False
		if amount == 'one':
			return cursor.fetchone()
		else:
			return cursor.fetchall()
	def escape(self, string):
		return self.MySQL.escape_string(string)
	def reconnect(self):
		config = self.config
		try:
			self.MySQL = MySQLdb.connect(config['host'], config['user'], config['pass'], config['name'])
			print "Successfully connected to MySQL on " + config['host']
		except:
			print "Unable to connect to the MySQL database on " + config['host']
			sys.exit()
