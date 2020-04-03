<?php

class MySQLException extends Exception
{
   private $m_number;
   private $messasge;
   
	function __construct($query = '', $message = '')
	{
      $this->m_number = mysql_errno();
        
		$msg = "MySQL Error #" . mysql_errno() . " occurred: " . mysql_error() . ".";
		
		if($query)
		{
			$msg .= "\n\nFor query: $query.";
		}
		
		if($message)
		{
			$msg .= "\n\nApplication reported: $message";
		}
      
      parent::__construct($msg);
	}
	
	public function getMessageHTML()
	{
		return nl2br($this->getMessage());
	}
   
   function number()
   {
      return $this->m_number;
   }
}

?>