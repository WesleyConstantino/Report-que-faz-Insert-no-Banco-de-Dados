REPORT ztrwc_exercio_01.

*&---------------------------------------------------------------------*
*                           Workareas                                  *
*&---------------------------------------------------------------------*
DATA: wa_zewes_boletim TYPE zewes_boletim.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
PARAMETERS: s_nome  TYPE zewes_boletim-nome,
            s_nota1 TYPE zewes_boletim-nota1,
            s_nota2 TYPE zewes_boletim-nota2,
            s_nota3 TYPE zewes_boletim-nota3,
            s_nota4 TYPE zewes_boletim-nota4.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  PERFORM zf_insert.

*&---------------------------------------------------------------------*
*                          FORM zf_insert                              *
*&---------------------------------------------------------------------*
FORM zf_insert.

  CLEAR: wa_zewes_boletim.
  wa_zewes_boletim-nome  = s_nome.
  wa_zewes_boletim-nota1 = s_nota1.
  wa_zewes_boletim-nota2 = s_nota2.
  wa_zewes_boletim-nota3 = s_nota3.
  wa_zewes_boletim-nota4 = s_nota4.

  INSERT zewes_boletim FROM wa_zewes_boletim.

  IF sy-subrc IS INITIAL.
    COMMIT WORK AND WAIT. "COMMIT WORK AND WAIT dá commit no banco de dados

    MESSAGE s208(00) WITH 'SALVO COM SUCESSO!'.
  ELSE.
    ROLLBACK WORK. "ROLLBACK WORK desfaz tudo o que aconteceu na operação
    MESSAGE s208(00) WITH 'ERRO AO GRAVAR!'DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
