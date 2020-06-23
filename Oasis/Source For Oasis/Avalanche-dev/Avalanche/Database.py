from twisted.enterprise import adbapi

class Database(object):

	def __init__(self):
		self.dbpool = adbapi.ConnectionPool("MySQLdb", \
			user="root", passwd="coder123", db="oasis", \
			cp_noisy=True, cp_reconnect=True)

	def getColumns(self, *args, **kw):
		columns = ", ".join(args)

		if "id" in kw:
			return self.dbpool.runQuery("SELECT %s FROM accs WHERE ID = %s" % (columns, kw["id"]))
		else:
			return self.dbpool.runQuery("SELECT %s FROM accs WHERE name = \"%s\"" % (columns, kw["name"]))

	def updateColumn(self, *args, **kw):
		if "id" in kw:
			return self.dbpool.runQuery("UPDATE accs SET %s = \"%s\" WHERE ID = %s" % \
				(kw["column"], args[0], kw["id"]))
		else:
			return self.dbpool.runQuery("UPDATE accs SET %s = %s WHERE name = \"%s\"" % \
				kw["column"], args[0], kw["name"])