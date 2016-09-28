grammar Shopify;
/**
 Generator grammar for shopify's specific json structure

 Copyright 2016 Terence Parr, Kalvin Eng

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

 Taken from "The Definitive ANTLR 4 Reference" by Terence Parr
 Modified to support Shopify's specific json structure
*/

// Derived from http://json.org

init
   :'{"products":' ('[' item (',' item)* ']' | '[' ']')
   ;

item
   : '{' pair (',' pair)* '}'
   | '{' '}'
   ;

object
   : '{' pair (',' pair)* '}'
   | '{' '}'
   ;

pair:
    '"product_type":' value #Producttype_
   |'"price":' value # Price_
   |'"available":' value # Availability_
   | STRING ':' value # Normal_
   ;

array
   : '[' value (',' value)* ']'
   | '[' ']'
   ;

value
   : STRING
   | NUMBER
   | object
   | array
   | 'true'
   | 'false'
   | 'null'
   ;


STRING
   : '"' (ESC | ~ ["\\])* '"'
   ;


fragment ESC
   : '\\' (["\\/bfnrt] | UNICODE)
   ;


fragment UNICODE
   : 'u' HEX HEX HEX HEX
   ;


fragment HEX
   : [0-9a-fA-F]
   ;


NUMBER
   : '-'? INT '.' [0-9] + EXP? | '-'? INT EXP | '-'? INT
   ;


fragment INT
   : '0' | [1-9] [0-9]*
   ;

// no leading zeros

fragment EXP
   : [Ee] [+\-]? INT
   ;

// \- since - means "range" inside [...]

WS
   : [ \t\n\r] + -> skip
   ;