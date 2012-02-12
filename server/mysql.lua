push([[
-----------------------------------------------------------
--- /server/mysql_class.lua                             ---
--- Part of openFrame project                           ---
--- Written by Orange                                   ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: MySQL Class
-- MySQL Class allows you to use MySQL database easily.
MySQL = Class:Create();

--	Function: MySQL:Connect
--	Creates a MySQL connection object
--	
--	Required Arguments:
--	   host - (string) Hostname/IP address of MySQL server to connect.
--	   user - (string) Username used to connect to MySQL server.
--	   password - (string) Password used to connect to MySQL server.
--	   db - (string) Name of database to select after connecting.
--
--  Optional Arguments:
--	   reconnect - (bool) If true, reconnects every connection timeout.
--
--	Returns:
--		Returns MySQL connection object
function MySQL:Connect(host, user, pass, db, reconnect, socket)
	local object = Class:Create(self);
	object.connection = mysql_connect(host, user, pass, db, 3306, socket);
	if reconnect == true then
		object.reconnect = true;
	end
	
	object.host = host;
	object.user = user;
	object.pass = pass;
	object.db = db;

	if object.connection then
		return object;	
	end
	
	outputDebugString(mysql_error(object.connection))
	return false;
end

--	Function: MySQL:Reconnect
--	Reconnects to database.
--	
--	Returns:
--		Returns true if reconnected, false if not.
function MySQL:Reconnect()
	self.connection = mysql_connect(self.host, self.user, self.pass, self.db);
	if self:Ping() then
		return true;
	end
	return false;
end

--	Function: MySQL:Query
--	Sends a query to database and makes a object from result.
--	
--	Required Arguments:
--	   str - (string) Query string.
--
--	Returns:
--		Returns MySQL result object.
function MySQL:Query(str)
	if self.reconnect then
		if self:Ping() ~= true then
			self:Reconnect()
		end
	end
	
	local object = Class:Create(MySQL.ret);
	object.query = mysql_query(self.connection, str);
	
	if object.query then
		return object;
	end
	
	outputDebugString(self:Error())
	
	return false;
end

function MySQL:Escape(str)
	if self.reconnect then
		if self:Ping() ~= true then
			self:Reconnect()
		end
	end
	
	return mysql_escape_string(self.connection, str);
end

--	Function: MySQL:Error
--	Returns last error string.
--	
--	Returns:
--		Returns string with last error.
function MySQL:Error()
	return mysql_error(self.connection)
end

--	Function: MySQL:Ping
--	Pings the server (checks the connection)
--	
--	Returns:
--		Returns true if connection is alive, false if not.
function MySQL:Ping()
	return mysql_ping(self.connection)
end

--	Function: MySQL:Errno
--	Returns last error number.
--	
--	Returns:
--		Returns last error number.
function MySQL:Errno()
	return mysql_errno(self.connection)
end

-- Class: MySQL.ret Class
-- Result extension of MySQL Class
MySQL.ret = Class:Create();

--	Function: MySQL.ret:fetchAssoc
--	Returns an associative table containing the current row of the query. You can call this function repeatedly to retreive all the result rows. When there aren't more rows in the result it returns nil.
--	
--	Returns:
--		Returns table with current row.
function MySQL.ret:fetchAssoc()
	return mysql_fetch_assoc(self.query)
end

--	Function: MySQL.ret:freeResult
--	Frees the last query result. This function should be called after every query, specially when these queries return any data. 
--	
--	Returns:
--		Returns true if freed, false if not.
function MySQL.ret:freeResult()
	return mysql_free_result(self.query)
end

--	Function: MySQL.ret:numRows
--	Returns the number of rows in the result.
--	
--	Returns:
--		Returns the number of rows in the result.
function MySQL.ret:numRows()
	return mysql_num_rows(self.query)
end

function MySQL.ret:itTable()
	local tab = {}
	
	local i = 0
	for k,v in mysql_rows(self.query) do
		i = i + 1
		tab[i] = {}
		for k2, v2 in ipairs(v) do
			tab[i][mysql_field_name(self.query, k2)] = v2
		end
	end

	return tab;
end
]])