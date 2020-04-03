<?php

/***
**** This file is (c) Harry Metcalfe 2007.
****
**** This software was written under contract by Harry Metcalfe, who remains the
**** owner of the copyright in this work. All rights reserved.
****
**** Any copyright dispute arising over this software shall be resolved according
**** to the law of the United Kingdom.
****
***/

define("NUMBER", 1);         // Allows integers and floating point values
define("STRING_STRICT", 2);   // Alphanumeric characters and spaces only 
define("STRING_ENCODED", 3);  // Allows all characters. Replaces appropriate characters with their HTML entities, including quotes
define("ENUM", 5);            // An enumerated type -- requires an array of allowed values as a second parameter

//
// $variables should be an array in the format:
//
// "variable name" => TYPE
//
// Where type is one of the defined types above, and variable name is the name of the element in $_REQUEST.
//
// Some types require an extra parameter, in which case, the following input is expected:
//
// "variable name" => array(TYPE, <parameter>)
//

function sanitise($data, $variables, $defaults = array(), $warn = false)
{
   $valid = array();
   
   foreach($variables as $variable => $parameter)
   {
      if(!isset($data[$variable]))
      {
         if(isset($defaults[$variable]))
         {
            $data[$variable] = $defaults[$variable];
         }
         else
         {
            if($warn) 
            {
               trigger_error("Input data for variable $variable ('$data[$variable]') failed sanitisation\n", E_USER_WARNING);
            }
         
            $data[$variable] = '';
         }
      }
            
      if(is_array($parameter))
      {
         $type       = $parameter[0];
         $parameter  = $parameter[1];
      }
      else
      {
         $type = $parameter;
      }

      switch($type)
      {
         case NUMBER:         $valid[$variable] = sanitiseNumber($data[$variable]);                   break;
         case STRING_STRICT:  $valid[$variable] = sanitiseStringStrict($data[$variable]);             break;
         case STRING_ENCODED: $valid[$variable] = sanitiseStringEncoded($data[$variable]);            break;
         case ENUM:           $valid[$variable] = sanitiseEnum($parameter, $data[$variable]);         break;
      }
      
      //
      // If:
      //
      //   - there is a default value
      //   - the input data was set, but was not empty, or was unset
      //   - the validated input is empty
      //
      // Apply the default value.
      //
      
      if($data[$variable] != '' && $valid[$variable] == '' && isset($defaults[$variable]))
      {
         $valid[$variable] = $defaults[$variable];
      }      
   }

   return $valid;
}

function sanitiseEnum($allowedValues, $value)
{
   if(array_search($value, $allowedValues) !== false)
   {
      return $value;
   }

   return '';
}

function sanitiseNumber($value)
{
   if(is_numeric($value))
   {
      return $value;
   }

   return '';
}

function sanitiseStringStrict($value)
{
   if(preg_match("/^[0-9a-zA-Z ]+$/", $value))
   {
       return $value;
   }

   return '';
}

function sanitiseStringEncoded($value)
{
   return htmlentities($value, ENT_QUOTES);
}

