new MySQL: SQL;


 #define		MYSQL_HOST			"localhost"
 #define		MYSQL_USER			"root"
 #define		MYSQL_PASS			""
 #define		MYSQL_DBNAME		"rdm_db"

#define 		users_table			"users"

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL: handle) {
	breaker errorid of
		_case CR_SERVER_GONE_ERROR)
			printf("Lost connection to server");
		_case ER_SYNTAX_ERROR)
			printf("Syntax error: %s",query);
		_case ER_UNKNOWN_TABLE)
			printf("Unknown table error: %s",query);		
	esac
	echo > OnQueryError: Error: %s | Query: %s | Callback: %s, error, query, callback
	return 1;
}
