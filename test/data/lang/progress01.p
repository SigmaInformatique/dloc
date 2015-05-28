/*==========================================================================*/
/* Gestion de la participation des salaries                      CPAPP551.P */
/*                                                                          */
/*                          CONSULTATION FICHE SITUATION                    */
/*                            (Gestion du scroll)                    MODULE */
/* AUTEUR           : DV                                                    */
/* DATE DE CREATION : 21/04/1995                        PROGRAMME PRINCIPAL */
/*==========================================================================*/
/*V-4.0150998/2096-0001/ Conversion  de la monnaie affichee    AGH-010798   */
/*V-5.0010999/2511-0004/ 06/07/99 OPERATEUR : EL                            */
/*V-5.0010999/2511-0004/ Passage du numero d'emploi de 5 a 7 positions      */

/*==========================================================================*/
/*                    DEFINITION DES VARIABLES GLOBALES                     */
/*==========================================================================*/
 
DEFINE INPUT  PARAMETER W-INTERR    AS LOGICAL                      NO-UNDO.
DEFINE OUTPUT PARAMETER ABANDON     AS LOGICAL                      NO-UNDO.
 
{ cstdi002.i }
 
/*==========================================================================*/
/*                    DEFINITION DES VARIABLES DU PROGRAMME                 */
/*==========================================================================*/
  
DEFINE SHARED VARIABLE WDATE       AS DATE      FORMAT "99/99/9999"  NO-UNDO.
DEFINE SHARED VARIABLE WHEURE      AS INTEGER                        NO-UNDO.
 /*el 06/07/99*/
DEFINE SHARED VARIABLE WPER-CODE   AS CHARACTER FORMAT "X(07)"       NO-UNDO.
DEFINE SHARED VARIABLE WSOCIETE    AS CHARACTER FORMAT "X(04)"       NO-UNDO.
 
/*==========================================================================*/
/*                        PROCEDURE PRINCIPALE                              */
/*==========================================================================*/
 
/*==== VERIFICATION PERMISSION =============================================*/
 
WNOM-PRG = "CPAPP551".
 
RUN VALUE(WNOM-PERM).
IF NOT WPRO-EXE THEN DO :
   RUN VALUE(WNOM-MES)("M",001).
   RETURN.
END.
 
/*================== PROCEDURE GENERALE ====================================*/
/*=== AGH-0100798 : changer le sstdisrl.i en cpapi441.i pour recuperer la 
                    gestion de la touche F6 */
                    
{ cpapi441.i
   &frame     = "cpapp551.f"
               }
 
/*=========== FIN DE LA TRANSACTION PRINCIPALE ==> TRAITTRANSAC ============*/
 
END.
 
IF AVAILABLE CPAPTFST THEN RELEASE CPAPTFST.
STATUS DEFAULT.
CLEAR FRAME FSCROLL ALL NO-PAUSE.
HIDE  FRAME FSCROLL     NO-PAUSE.
WCOL-NUM = WCOL-NUM - 1.
WNOM-PRG = "CPAPP551".

&COD-DER11 = "/*"