<?php

include "mysqlexception.class.php";

class MySQL
{
   private $linkId;
   private $lastResult;
   private $lastQuery;

   private $server;
   private $username;
   private $password;
   private $database;

   function __construct($server, $username, $password, $database, $persistent = false, $newLink = false, $clientFlags = 0)
   {
      if($persistent)
      {
         $this->linkId = mysql_pconnect($server, $username, $password, $newLink, $clientFlags);
      }
      else
      {
         $this->linkId = mysql_connect($server, $username, $password, $newLink, $clientFlags);
      }

      if($this->linkId === false)
      {
         throw new MySQLException();
      }

      if(!mysql_select_db($database, $this->linkId))
      {
         throw new MySQLException();
      }

      // Save logon information in case the object is cloned later
      $this->server   = $server;
      $this->username = $username;
      $this->password = $password;
      $this->database = $database;
   }

   function __destruct()
   {
      //mysql_close($this->linkId);
   }

   function __clone()
   {
      // If the object is cloned, a new link is needed, otherwise the original MySQL link will be closed
      // when the cloned object is destroyed.

      $this->linkId = mysql_connect($this->server, $this->username, $this->password, true);

      if(!mysql_select_db($this->database, $this->linkId))
      {
         throw new MySQLException();
      }
   }

   public function query($query, $printQuery = false)
   {
      if($printQuery)
      {
         echo $query;
      }

      $this->lastQuery = $query;
      $this->lastResult = mysql_query($query, $this->linkId);

      if($this->lastResult == false)
      {
         throw new MySQLException($query);
      }

      return $this->lastResult;
   }
   
   public function unbuffered_query($query, $printQuery = false)
   {
      if($printQuery)
      {
         echo $query;
      }

      $this->lastQuery = $query;
      $this->lastResult = mysql_unbuffered_query($query, $this->linkId);

      if($this->lastResult == false)
      {
         throw new MySQLException($query);
      }

      return $this->lastResult;
   }
     
   public function singleValueQuery($query, $printQuery = false)
   {
      if($printQuery)
      {
         echo $query;
      }

      $result = mysql_query($query, $this->linkId);
      
      if($result == false)
      {
         throw new MySQLException($query);
      }

      if(mysql_num_fields($result) > 1)
      {
         trigger_error("Multiple fields are present in the result set for a single value query", E_USER_WARNING);
      }

      if($this->numRows($result) > 1)
      {
         trigger_error("Multiple rows are present in the result set for a single value query", E_USER_WARNING);
      }
      
      if($this->numRows($result) == 0)
      {
         return '';
      }

      return mysql_result($result, 0);
   }

   public function fetchArray($result = 0)
   {
      if(!$result)
      {
         $result = $this->lastResult;
      }                                                                               

      $row = mysql_fetch_array($result);

      if($row === false)
      {
         mysql_free_result($result);
      }

      return $row;
   }

   public function fetchObject($result = 0)
   {
      if(!$result)
      {
         $result = $this->lastResult;
      }

      $row = mysql_fetch_object($result);


      if($row === false)
      {
         mysql_free_result($result);
      }

      return $row;
   }

   public function affectedRows()
   {
      return mysql_affected_rows($this->linkId);
   }

   public function numRows($result = 0)
   {
      if(!$result)
      {
         $result = $this->lastResult;
      }

      return mysql_num_rows($result);
   }

   public function insertId()
   {
      return mysql_insert_id($this->linkId);
   }

   public function seek($index)
   {
      return mysql_data_seek($this->lastResult, $index);
   }
}

?>