(* My beautiful function returns an interesting result *)  
Function Beautiful : Integer;  
The use of (* and *) as comment delimiters dates from the very first days of the Pascal language. It has been replaced mostly by the use of { and } as comment delimiters, as in the following example:

 
{ My beautiful function returns an interesting result }  
Function Beautiful : Integer;  
The comment can also span multiple lines:

 
{  
   My beautiful function returns an interesting result,  
   but only if the argument A is less than B.  
}  
Function Beautiful (A,B : Integer): Integer;
Single line comments can also be made with the // delimiter:

 
// My beautiful function returns an interesting result  
Function Beautiful : Integer;  
The comment extends from the // character till the end of the line. This kind of comment was introduced by Borland in the Delphi Pascal compiler.
Free Pascal supports the use of nested comments. The following constructs are valid comments:

(* This is an old style comment *)  
{  This is a Turbo Pascal comment }  
// This is a Delphi comment. All is ignored till the end of the line.
The following are valid ways of nesting comments:

{ Comment 1 (* comment 2 *) }  
(* Comment 1 { comment 2 } *)  
{ comment 1 // Comment 2 }  
(* comment 1 // Comment 2 *)  
// comment 1 (* comment 2 *)  
// comment 1 { comment 2 }

{agh 16/12/08 Ajout du type bull en param.
  // Appel d'une fonction pour construire l'édition en ReportMaker
  // 1er parametre  : numéro du poste opérateur
  // 2eme parametre :  Date du traitement
  // 3eme parametre : Heure du traitement
  // 4eme parametre : code société
  // 5eme parametre : ous-code
  // 6eme parametre : type bulletin
  // 7eme parametre : fichier global RM 0 : global 1 : par salarie
  // 8eme parametre : prépa edition recto verso des bull.RM 1 : oui 0 : non (option de l'edition bulletin) AGH 27/11/2009
  // 9eme parametre : Code correspondant pour envoi de bulletin par mail
  // 10eme parametre : duplicata (false par defaut) }

  // JBO le 23/05/2011
  if ((TypeBulletin = 'K') or (TypeBulletin = 'C') or (TypeBulletin = 'E'))then
	primobox := MpaiDbu.MdPaiDbu.QrPaiIdeIDEPX.AsBoolean;