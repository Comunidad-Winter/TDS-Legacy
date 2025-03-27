Attribute VB_Name = "Extra"
Option Explicit

Public Const INVALID_INDEX As Integer = 0

Public MaxClientPerSerial As Byte
Public MaxWorkersPerIP As Byte
Public MaxWorkersPerPC As Byte

Public Enum e_Mensajes
    Mensaje_1 = 1
    Mensaje_2
    Mensaje_3
    Mensaje_4
    Mensaje_5
    Mensaje_6
    Mensaje_7
    Mensaje_8
    Mensaje_9
    Mensaje_10
    Mensaje_11
    Mensaje_12
    Mensaje_13
    Mensaje_14
    Mensaje_15
    Mensaje_16
    Mensaje_17
    Mensaje_18
    Mensaje_19
    Mensaje_20
    Mensaje_21
    Mensaje_22
    Mensaje_23
    Mensaje_24
    Mensaje_25
    Mensaje_26
    Mensaje_27
    Mensaje_28
    Mensaje_29
    Mensaje_30
    Mensaje_31
    Mensaje_32
    Mensaje_33
    Mensaje_34
    Mensaje_35
    Mensaje_36
    Mensaje_37
    Mensaje_38
    Mensaje_39
    Mensaje_40
    Mensaje_41
    Mensaje_42
    Mensaje_43
    Mensaje_44
    Mensaje_45
    Mensaje_46
    Mensaje_47
    Mensaje_48
    Mensaje_49
    Mensaje_50
    Mensaje_51
    Mensaje_52
    Mensaje_53
    Mensaje_54
    Mensaje_55
    Mensaje_56
    Mensaje_57
    Mensaje_58
    Mensaje_59
    Mensaje_60
    Mensaje_61
    Mensaje_62
    Mensaje_63
    Mensaje_64
    Mensaje_65
    Mensaje_66
    Mensaje_67
    Mensaje_68
    Mensaje_69
    Mensaje_70
    Mensaje_71
    Mensaje_72
    Mensaje_73
    Mensaje_74
    Mensaje_75
    Mensaje_76
    Mensaje_77
    Mensaje_78
    Mensaje_79
    Mensaje_80
    Mensaje_81
    Mensaje_82
    Mensaje_83
    Mensaje_84
    Mensaje_85
    Mensaje_86
    Mensaje_87
    Mensaje_88
    Mensaje_89
    Mensaje_90
    Mensaje_91
    Mensaje_92
    Mensaje_93
    Mensaje_94
    Mensaje_95
    Mensaje_96
    Mensaje_97
    Mensaje_98
    Mensaje_99
    Mensaje_100
    Mensaje_101
    Mensaje_102
    Mensaje_103
    Mensaje_104
    Mensaje_105
    Mensaje_106
    Mensaje_107
    Mensaje_108
    Mensaje_109
    Mensaje_110
    Mensaje_111
    Mensaje_112
    Mensaje_113
    Mensaje_114
    Mensaje_115
    Mensaje_116
    Mensaje_117
    Mensaje_118
    Mensaje_119
    Mensaje_120
    Mensaje_121
    Mensaje_122
    Mensaje_123
    Mensaje_124
    Mensaje_125
    Mensaje_126
    Mensaje_127
    Mensaje_128
    Mensaje_129
    Mensaje_130
    Mensaje_131
    Mensaje_132
    Mensaje_133
    Mensaje_134
    Mensaje_135
    Mensaje_136
    Mensaje_137
    Mensaje_138
    Mensaje_139
    Mensaje_140
    Mensaje_141
    Mensaje_142
    Mensaje_143
    Mensaje_144
    Mensaje_145
    Mensaje_146
    Mensaje_147
    Mensaje_148
    Mensaje_149
    Mensaje_150
    Mensaje_151
    Mensaje_152
    Mensaje_153
    Mensaje_154
    Mensaje_155
    Mensaje_156
    Mensaje_157
    Mensaje_158
    Mensaje_159
    Mensaje_160
    Mensaje_161
    Mensaje_162
    Mensaje_163
    Mensaje_164
    Mensaje_165
    Mensaje_166
    Mensaje_167
    Mensaje_168
    Mensaje_169
    Mensaje_170
    Mensaje_171
    Mensaje_172
    Mensaje_173
    Mensaje_174
    Mensaje_175
    Mensaje_176
    Mensaje_177
    Mensaje_178
    Mensaje_179
    Mensaje_180
    Mensaje_181
    Mensaje_182
    Mensaje_183
    Mensaje_184
    Mensaje_185
    Mensaje_186
    Mensaje_187
    Mensaje_188
    Mensaje_189
    Mensaje_190
    Mensaje_191
    Mensaje_192
    Mensaje_193
    Mensaje_194
    Mensaje_195
    Mensaje_196
    Mensaje_197
    Mensaje_198
    Mensaje_199
    Mensaje_200
    Mensaje_201
    Mensaje_202
    Mensaje_203
    Mensaje_204
    Mensaje_205
    Mensaje_206
    Mensaje_207
    Mensaje_208
    Mensaje_209
    Mensaje_210
    Mensaje_211
    Mensaje_212
    Mensaje_213
    Mensaje_214
    Mensaje_215
    Mensaje_216
    Mensaje_217
    Mensaje_218
    Mensaje_219
    Mensaje_220
    Mensaje_221
    Mensaje_222
    Mensaje_223
    Mensaje_224
    Mensaje_225
    Mensaje_226
    Mensaje_227
    Mensaje_228
    Mensaje_229
    Mensaje_230
    Mensaje_231
    Mensaje_232
    Mensaje_233
    Mensaje_234
    Mensaje_235
    Mensaje_236
    Mensaje_237
    Mensaje_238
    Mensaje_239
    Mensaje_240
    Mensaje_241
    Mensaje_242
    Mensaje_243
    Mensaje_244
    Mensaje_245
    Mensaje_246
    Mensaje_247
    Mensaje_248
    Mensaje_249
    Mensaje_250
    Mensaje_251
    Mensaje_252
    Mensaje_253
    Mensaje_254
    Mensaje_255
    Mensaje_256
    Mensaje_257
    Mensaje_258
    Mensaje_259
    Mensaje_260
    Mensaje_261
    Mensaje_262
    Mensaje_263
    Mensaje_264
    Mensaje_265
    Mensaje_266
    Mensaje_267
    Mensaje_268
    Mensaje_269
    Mensaje_270
    Mensaje_271
    Mensaje_272
    Mensaje_273
    Mensaje_274
    Mensaje_275
    Mensaje_276
    Mensaje_277
    Mensaje_278
    Mensaje_279
    Mensaje_280
    Mensaje_281
    Mensaje_282
    Mensaje_283
    Mensaje_284
    Mensaje_285
    Mensaje_286
    Mensaje_287
    Mensaje_288
    Mensaje_289
    Mensaje_290
    Mensaje_291
    Mensaje_292
    Mensaje_293
    Mensaje_294
    Mensaje_295
    Mensaje_296
    Mensaje_297
    Mensaje_298
    Mensaje_299
    Mensaje_300
    Mensaje_301
    Mensaje_302
    Mensaje_303
    Mensaje_304
    Mensaje_305
    Mensaje_306
    Mensaje_307
    Mensaje_308
    Mensaje_309
    Mensaje_310
    Mensaje_311
    Mensaje_312
    Mensaje_313
    Mensaje_314
    Mensaje_315
    Mensaje_316
    Mensaje_317
    Mensaje_318
    Mensaje_319
    Mensaje_320
    Mensaje_321
    Mensaje_322
    Mensaje_323
    Mensaje_324
    Mensaje_325
    Mensaje_326
    Mensaje_327
    Mensaje_328
    Mensaje_329
    Mensaje_330
    Mensaje_331
    Mensaje_332
    Mensaje_333
    Mensaje_334
    Mensaje_335
    Mensaje_336
    Mensaje_337
    Mensaje_338
    Mensaje_339
    Mensaje_340
    Mensaje_341
    Mensaje_342
    Mensaje_343
    Mensaje_344
    Mensaje_345
    Mensaje_346
    Mensaje_347
    Mensaje_348
    Mensaje_349
    Mensaje_350
    Mensaje_351
    Mensaje_352
    Mensaje_353
    Mensaje_354
    Mensaje_355
    Mensaje_356
    Mensaje_357
    Mensaje_358
    Mensaje_359
    Mensaje_360
    Mensaje_361
    Mensaje_362
    Mensaje_363
    Mensaje_364
    Mensaje_365
    Mensaje_366
    Mensaje_367
    Mensaje_368
    Mensaje_369
    Mensaje_370
    Mensaje_371
    Mensaje_372
    Mensaje_373
    Mensaje_374
    Mensaje_375
    Mensaje_376
    Mensaje_377
    Mensaje_378
    Mensaje_379
    Mensaje_380
    Mensaje_381
    Mensaje_382
    Mensaje_383
    Mensaje_384
    Mensaje_385
    Mensaje_386
    Mensaje_387
    Mensaje_388
    Mensaje_389
    Mensaje_390
    Mensaje_391
    Mensaje_392
    Mensaje_393
    Mensaje_394
    Mensaje_395
    Mensaje_396
    Mensaje_397
    Mensaje_398
    Mensaje_399
    Mensaje_400
    Mensaje_401
    Mensaje_402
    Mensaje_403
    Mensaje_404
    Mensaje_405
    Mensaje_406
    Mensaje_407
    Mensaje_408
    Mensaje_409
    Mensaje_410
    Mensaje_411
    Mensaje_412
    Mensaje_413
    Mensaje_414
    Mensaje_415
    Mensaje_416
    Mensaje_417
    Mensaje_418
    Mensaje_419
    Mensaje_420
    Mensaje_421
    Mensaje_422
    Mensaje_423
    Mensaje_424
    Mensaje_425
    Mensaje_426
    Mensaje_427
    Mensaje_428
    Mensaje_429
    Mensaje_430
    Mensaje_431
    Mensaje_432
    Mensaje_433
    Mensaje_434
    Mensaje_435
    Mensaje_436
    Mensaje_437
    Mensaje_438
    Mensaje_439
    Mensaje_440
    Mensaje_441
    Mensaje_442
    Mensaje_443
    Mensaje_444
    Mensaje_445
    Mensaje_446
    Mensaje_447
    Mensaje_448
    Mensaje_449
    
    Mensaje_450
End Enum

Public Function EsNewbie(ByVal UserIndex As Integer) As Boolean
    EsNewbie = UserList(UserIndex).Stats.ELV <= LimiteNewbie
End Function
Public Function PersonajeBaneado(ByVal UserName As String) As Boolean
    If PersonajeExiste(PersonajeBaneado) Then PersonajeBaneado = val(GetVar(CharPath & UCase$(UserName) & ".chr", "FLAGS", "BAN")) > 0
End Function
Public Function EsQuince(ByVal UserIndex As Integer) As Boolean
    EsQuince = UserList(UserIndex).Stats.ELV > 14
End Function
Public Function EsVeinte(ByVal UserIndex As Integer) As Boolean
    EsVeinte = UserList(UserIndex).Stats.ELV > 19
End Function
Public Function EsVeinticinco(ByVal UserIndex As Integer) As Boolean
    EsVeinticinco = UserList(UserIndex).Stats.ELV > 24
End Function
Public Function EsCuarenta(ByVal UserIndex As Integer) As Boolean
    EsCuarenta = UserList(UserIndex).Stats.ELV > 39
End Function

Public Function EsArmada(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: Pablo (ToxicWaste)
'Last Modification: 23/01/2007
'***************************************************

    EsArmada = (UserList(UserIndex).faccion.ArmadaReal = 1)
End Function

Public Function EsCaos(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: Pablo (ToxicWaste)
'Last Modification: 23/01/2007
'***************************************************

    EsCaos = (UserList(UserIndex).faccion.FuerzasCaos = 1)
End Function

Public Function EsGM(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: Pablo (ToxicWaste)
'Last Modification: 23/01/2007
'***************************************************

    EsGM = (UserList(UserIndex).flags.Privilegios > PlayerType.RoleMaster)
End Function

Public Sub DoTileEvents(ByVal UserIndex As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)
'***************************************************
'Autor: Pablo (ToxicWaste) & Unknown (orginal version)
'Last Modification: 06/03/2010
'Handles the Map passage of Users. Allows the existance
'of exclusive maps for Newbies, Royal Army and Caos Legion members
'and enables GMs to enter every map without restriction.
'Uses: Mapinfo(map).Restringir = "NEWBIE" (newbies), "ARMADA", "CAOS", "FACCION" or "NO".
' 06/03/2010 : Now we have 5 attemps to not fall into a map change or another teleport while going into a teleport. (Marco)
'***************************************************

    Dim nPos As WorldPos
    Dim FxFlag As Boolean
    Dim DestPos As WorldPos
    Dim isNavegando As Boolean, isTierra As Boolean, checkExitTile As Boolean

    isNavegando = UserList(UserIndex).flags.Navegando    'Or EsGM(UserIndex)
    isTierra = (Not UserList(UserIndex).flags.Navegando = 1)    'Or EsGM(UserIndex)
    checkExitTile = True    'And Not EsGM(UserIndex)

    On Error GoTo Errhandler
    'Controla las salidas
    If InMapBounds(Map, X, Y) Then
        With MapData(Map, X, Y)
            If .ObjInfo.ObjIndex > 0 Then
                FxFlag = ObjData(.ObjInfo.ObjIndex).OBJType = eOBJType.otTeleport

            End If

            If .TileExit.Map > 0 And .TileExit.Map <= NumMaps Then

                ' Es un teleport, entra en una posicion random, acorde al radio (si es 0, es pos fija)
                ' We have 5 attempts to not falling into another teleport or a map exit.. If we get to the fifth attemp,
                ' the teleport will act as if its radius = 0.
                If FxFlag And .TileExit.Radio > 0 Then
                    Dim attemps As Long
                    Dim exitMap As Boolean
                    Do
                        DestPos.X = .TileExit.X + RandomNumber(.TileExit.Radio * (-1), .TileExit.Radio)
                        DestPos.Y = .TileExit.Y + RandomNumber(.TileExit.Radio * (-1), .TileExit.Radio)

                        attemps = attemps + 1

                        exitMap = MapData(.TileExit.Map, DestPos.X, DestPos.Y).TileExit.Map > 0 And _
                                  MapData(.TileExit.Map, DestPos.X, DestPos.Y).TileExit.Map <= NumMaps
                    Loop Until (attemps >= 5 Or exitMap = False)

                    If attemps >= 5 Then
                        DestPos.X = .TileExit.X
                        DestPos.Y = .TileExit.Y
                    End If
                    ' Posicion fija
                Else
                    DestPos.X = .TileExit.X
                    DestPos.Y = .TileExit.Y
                End If

                DestPos.Map = .TileExit.Map

                '¿Es mapa de newbies?
                If UCase$(MapInfo(DestPos.Map).Restringir) = "NEWBIE" Then
                    '¿El usuario es un newbie?
                    If EsNewbie(UserIndex) Or EsGM(UserIndex) Then
                        If LegalPos(DestPos.Map, DestPos.X, DestPos.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, DestPos.Map, DestPos.X, DestPos.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(DestPos, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else        'No es newbie

                        WriteMensajes UserIndex, e_Mensajes.Mensaje_38
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, False)
                        End If
                    End If
                ElseIf UCase$(MapInfo(DestPos.Map).Restringir) = "ARMADA" Then        '¿Es mapa de Armadas?
                    '¿El usuario es Armada?
                    If EsArmada(UserIndex) Or EsGM(UserIndex) Then
                        If LegalPos(DestPos.Map, DestPos.X, DestPos.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, DestPos.Map, DestPos.X, DestPos.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(DestPos, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else        'No es armada
                        Call WriteMensajes(UserIndex, Mensaje_398)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                        End If
                    End If
                ElseIf UCase$(MapInfo(DestPos.Map).Restringir) = "CAOS" Then        '¿Es mapa de Caos?
                    '¿El usuario es Caos?
                    If EsCaos(UserIndex) Or EsGM(UserIndex) Then
                        If LegalPos(DestPos.Map, DestPos.X, DestPos.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, DestPos.Map, DestPos.X, DestPos.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(DestPos, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else        'No es caos

                        Call WriteMensajes(UserIndex, Mensaje_399)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                        End If
                    End If
                ElseIf UCase$(MapInfo(DestPos.Map).Restringir) = "FACCION" Then        '¿Es mapa de faccionarios?
                    '¿El usuario es Armada o Caos?
                    If EsArmada(UserIndex) Or EsCaos(UserIndex) Or EsGM(UserIndex) Then
                        If LegalPos(DestPos.Map, DestPos.X, DestPos.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, DestPos.Map, DestPos.X, DestPos.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(DestPos, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else        'No es Faccionario
                        Call WriteMensajes(UserIndex, Mensaje_400)

                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                        End If
                    End If

                    'Quince
                ElseIf UCase$(MapInfo(.TileExit.Map).Restringir) = "QUINCE" Then
                    If UserList(UserIndex).Stats.ELV >= 15 Or EsGM(UserIndex) Then
                        If LegalPos(.TileExit.Map, .TileExit.X, .TileExit.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, .TileExit.Map, .TileExit.X, .TileExit.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(.TileExit, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else
                        Call WriteMensajes(UserIndex, Mensaje_428)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, False)
                        End If
                    End If
                    'VEINTE
                ElseIf UCase$(MapInfo(.TileExit.Map).Restringir) = "VEINTE" Then
                    If UserList(UserIndex).Stats.ELV >= 20 Or EsGM(UserIndex) Then
                        If LegalPos(.TileExit.Map, .TileExit.X, .TileExit.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, .TileExit.Map, .TileExit.X, .TileExit.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(.TileExit, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else
                        Call WriteMensajes(UserIndex, Mensaje_429)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, False)
                        End If
                    End If
                    'VEINTICINCO
                ElseIf UCase$(MapInfo(.TileExit.Map).Restringir) = "VEINTICINCO" Then
                    If UserList(UserIndex).Stats.ELV >= 25 Or EsGM(UserIndex) Then
                        If LegalPos(.TileExit.Map, .TileExit.X, .TileExit.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, .TileExit.Map, .TileExit.X, .TileExit.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(.TileExit, nPos)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else
                        Call WriteMensajes(UserIndex, Mensaje_401)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, False)
                        End If
                    End If
                    'VEINTICINCO FIN
                    'CUARENTA
                ElseIf UCase$(MapInfo(.TileExit.Map).Restringir) = "CUARENTA" Then
                    If UserList(UserIndex).Stats.ELV >= 40 Or EsGM(UserIndex) Then
                        If LegalPos(.TileExit.Map, .TileExit.X, .TileExit.Y, PuedeAtravesarAgua(UserIndex)) Then
                            Call WarpUserChar(UserIndex, .TileExit.Map, .TileExit.X, .TileExit.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(.TileExit, nPos, isNavegando)
                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    Else
                        Call WriteMensajes(UserIndex, Mensaje_401)
                        Call ClosestStablePos(UserList(UserIndex).Pos, nPos)

                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, False)
                        End If
                    End If
                    'CUARENTA FIN
                Else        'No es un mapa de newbies, ni Armadas, ni Caos, ni faccionario.
                    If LegalPos(DestPos.Map, DestPos.X, DestPos.Y, PuedeAtravesarAgua(UserIndex)) Then

                        Call WarpUserChar(UserIndex, DestPos.Map, DestPos.X, DestPos.Y, FxFlag, False)

                    Else
                        Call ClosestLegalPos(DestPos, nPos, isNavegando, isTierra, checkExitTile)
                        If nPos.X <> 0 And nPos.Y <> 0 Then
                            Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                        Else
                            Call ClosestLegalPos(DestPos, nPos, isNavegando, True, checkExitTile)

                            If nPos.X <> 0 And nPos.Y <> 0 Then
                                Call WarpUserChar(UserIndex, nPos.Map, nPos.X, nPos.Y, FxFlag)
                            End If
                        End If
                    End If
                End If

                'Te fusite del mapa. La criatura ya no es más tuya ni te reconoce como que vos la atacaste.
                Dim aN As Integer

                aN = UserList(UserIndex).flags.AtacadoPorNpc
                If aN > 0 Then
                    Npclist(aN).Movement = Npclist(aN).flags.OldMovement
                    Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
                    Npclist(aN).flags.TargetUserID = 0
                End If
                aN = UserList(UserIndex).flags.NPCAtacado
                If aN > 0 Then
                    If Npclist(aN).flags.AttackedFirstBy = UserList(UserIndex).Name Then
                        Npclist(aN).flags.AttackedFirstBy = vbNullString
                    End If
                End If
                UserList(UserIndex).flags.AtacadoPorNpc = 0
                UserList(UserIndex).flags.NPCAtacado = 0
            End If
        End With
    End If
    Exit Sub

Errhandler:
    Call LogError("Error en DotileEvents. Error: " & Err.Number & " - Desc: " & Err.Description)
End Sub

Public Function InVisionRangeAndMap(ByVal UserIndex As Integer, ByRef OtherUserPos As WorldPos) As Boolean

    With UserList(UserIndex)
        ' Same map?
        If .Pos.Map <> OtherUserPos.Map Then Exit Function
        ' In x range?
        If OtherUserPos.X < .Pos.X - MinXBorder Or OtherUserPos.X > .Pos.X + MinXBorder Then Exit Function
        ' In y range?
        If OtherUserPos.Y < .Pos.Y - MinYBorder And OtherUserPos.Y > .Pos.Y + MinYBorder Then Exit Function
    End With

    InVisionRangeAndMap = True

End Function

Function InRangoVision(ByVal UserIndex As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If X > UserList(UserIndex).Pos.X - MinXBorder And X < UserList(UserIndex).Pos.X + MinXBorder Then
        If Y > UserList(UserIndex).Pos.Y - MinYBorder And Y < UserList(UserIndex).Pos.Y + MinYBorder Then
            InRangoVision = True
            Exit Function
        End If
    End If
    InRangoVision = False

End Function

Function InRangoVisionNPC(ByVal NpcIndex As Integer, X As Integer, Y As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If X > Npclist(NpcIndex).Pos.X - MinXBorder And X < Npclist(NpcIndex).Pos.X + MinXBorder Then
        If Y > Npclist(NpcIndex).Pos.Y - MinYBorder And Y < Npclist(NpcIndex).Pos.Y + MinYBorder Then
            InRangoVisionNPC = True
            Exit Function
        End If
    End If
    InRangoVisionNPC = False

End Function


Function InMapBounds(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If (Map <= 0 Or Map > NumMaps) Or X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
        InMapBounds = False
    Else
        InMapBounds = True
    End If

    If (Map <= 0 Or Map > NumMaps) Or (X = 92 And Y = 7) Or (X = 9 And Y = 7) Or (X = 9 And Y = 94) Or (X = 92 And Y = 94) Then
        InMapBounds = False
    End If


End Function

Function InMapBounds_Force(ByRef X As Integer, ByRef Y As Integer) As Boolean

    If X < MinXBorder Then
        X = MinXBorder
        InMapBounds_Force = True
    End If

    If X > MaxXBorder Then
        X = MaxXBorder
        InMapBounds_Force = True
    End If

    If Y < MinYBorder Then
        Y = MinYBorder
        InMapBounds_Force = True
    End If

    If Y > MaxYBorder Then
        Y = MaxYBorder
        InMapBounds_Force = True
    End If

End Function

Sub ClosestLegalPos(Pos As WorldPos, ByRef nPos As WorldPos, Optional PuedeAgua As Boolean = False, _
                    Optional PuedeTierra As Boolean = True, Optional ByVal checkExitTile As Boolean = False, Optional ByVal DifPos As Boolean = False)
'*****************************************************************
'Author: Unknownn (original version)
'Last Modification: 10/07/2012 - ^[GS]^
'History:
' - 01/24/2007 (ToxicWaste)
'Encuentra la posicion legal mas cercana y la guarda en nPos
'*****************************************************************

    Dim found As Boolean
    Dim LoopC As Integer
    Dim tX As Long
    Dim tY As Long

1   On Error GoTo ClosestLegalPos_Error

2   nPos = Pos
3   tX = Pos.X
4   tY = Pos.Y

5   LoopC = 1

    ' La primera posicion es valida?
6   If LegalPos(Pos.Map, nPos.X, nPos.Y, PuedeAgua, PuedeTierra, checkExitTile) Then
7       found = True
8   Else
9       While (Not found) And LoopC <= 12
10          If RhombLegalPos(Pos, tX, tY, LoopC, PuedeAgua, PuedeTierra, checkExitTile, DifPos) Then
11              nPos.X = tX
12              nPos.Y = tY
13              found = True
14          End If

15          LoopC = LoopC + 1
16      Wend
17  End If

    '18  If Not InMapBounds(nPos.map, nPos.x, nPos.y) Then Exit Sub

19  If Not found Then    'Or MapData(nPos.map, nPos.x, nPos.y).TileExit.map > 0 Then
20      nPos.X = 0
21      nPos.Y = 0
22  End If

23  Exit Sub

ClosestLegalPos_Error:

24  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure ClosestLegalPos of Módulo modExtra" & Erl & ".")

End Sub

Sub ClosestLegalPosNPC(Pos As WorldPos, ByRef nPos As WorldPos, Optional PuedeAgua As Boolean = False, _
                       Optional PuedeTierra As Boolean = True, Optional PuedeOscuro As Boolean = True)

    Dim found As Boolean
    Dim LoopC As Integer
    Dim tX As Long
    Dim tY As Long

1   On Error GoTo ClosestLegalPosNPC_Error

2   nPos = Pos
3   tX = Pos.X
4   tY = Pos.Y

5   LoopC = 1

    ' La primera posicion es valida?
6   If LegalPos(Pos.Map, nPos.X, nPos.Y, PuedeAgua, PuedeTierra, True, PuedeOscuro) Then
7       found = True

        ' Busca en las demas posiciones, en forma de "rombo"
8   Else
9       While (Not found) And LoopC <= 90
10          If RhombLegalPos(Pos, tX, tY, LoopC, PuedeAgua, PuedeTierra, True, PuedeOscuro) Then
11              nPos.X = tX
12              nPos.Y = tY
13              found = True
14          End If

15          LoopC = LoopC + 1
16      Wend
17  End If

18  If Not InMapBounds(nPos.Map, nPos.X, nPos.Y) Then Exit Sub

19  If Not found Then
20      nPos.X = 0
21      nPos.Y = 0
22  End If

23  Exit Sub

ClosestLegalPosNPC_Error:

24  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure ClosestLegalPosNPC of Módulo modExtra" & Erl & ".")

End Sub

Private Function RhombLegalPos(ByRef Pos As WorldPos, _
                               ByRef vX As Long, _
                               ByRef vY As Long, _
                               ByVal Distance As Long, _
                               Optional PuedeAgua As Boolean = False, _
                               Optional PuedeTierra As Boolean = True, _
                               Optional ByVal checkExitTile As Boolean = False, Optional ByVal PuedeOscuro As Boolean = True) As Boolean
'***************************************************
'Author: Marco Vanotti (Marco)
'Last Modification: -
' walks all the perimeter of a rhomb of side  "distance + 1",
' which starts at Pos.x - Distance and Pos.y
'***************************************************

    Dim i As Long

100 vX = Pos.X - Distance
102 vY = Pos.Y

104 For i = 0 To Distance - 1

106     If (LegalPos(Pos.Map, vX + i, vY - i, PuedeAgua, PuedeTierra, checkExitTile)) Then
108         vX = vX + i
110         vY = vY - i
112         RhombLegalPos = True

            Exit Function

        End If

    Next

114 vX = Pos.X
116 vY = Pos.Y - Distance

118 For i = 0 To Distance - 1

120     If (LegalPos(Pos.Map, vX + i, vY + i, PuedeAgua, PuedeTierra, checkExitTile)) Then
122         vX = vX + i
124         vY = vY + i
126         RhombLegalPos = True

            Exit Function

        End If

    Next

128 vX = Pos.X + Distance
130 vY = Pos.Y

132 For i = 0 To Distance - 1

134     If (LegalPos(Pos.Map, vX - i, vY + i, PuedeAgua, PuedeTierra, checkExitTile)) Then
136         vX = vX - i
138         vY = vY + i
140         RhombLegalPos = True

            Exit Function

        End If

    Next

142 vX = Pos.X
144 vY = Pos.Y + Distance

146 For i = 0 To Distance - 1

148     If (LegalPos(Pos.Map, vX - i, vY - i, PuedeAgua, PuedeTierra, checkExitTile)) Then
150         vX = vX - i
152         vY = vY - i
154         RhombLegalPos = True

            Exit Function

        End If

    Next

156 RhombLegalPos = False



    Exit Function


    vX = Pos.X - Distance
    vY = Pos.Y

    For i = 0 To Distance - 1

        If (LegalPos(Pos.Map, vX + i, vY - i, PuedeAgua, PuedeTierra, checkExitTile, PuedeOscuro)) And Not (vX + i = 92 And vY - i = 7) And Not (vX + i = 9 And vY - i = 7) And Not (vX + i = 9 And vY - i = 94) And Not (vX + i = 92 And vY - i = 94) Then
            vX = vX + i
            vY = vY - i
            RhombLegalPos = True
            Exit Function

        End If

    Next

    vX = Pos.X
    vY = Pos.Y - Distance

    For i = 0 To Distance - 1

        If (LegalPos(Pos.Map, vX + i, vY + i, PuedeAgua, PuedeTierra, checkExitTile, PuedeOscuro)) And Not (vX + i = 92 And vY + i = 7) And Not (vX + i = 9 And vY + i = 7) And Not (vX + i = 9 And vY + i = 94) And Not (vX + i = 92 And vY + i = 94) Then
            vX = vX + i
            vY = vY + i
            RhombLegalPos = True
            Exit Function

        End If

    Next

    vX = Pos.X + Distance
    vY = Pos.Y

    For i = 0 To Distance - 1

        If (LegalPos(Pos.Map, vX - i, vY + i, PuedeAgua, PuedeTierra, checkExitTile, PuedeOscuro)) And Not (vX - i = 92 And vY + i = 7) And Not (vX - i = 9 And vY + i = 7) And Not (vX - i = 9 And vY + i = 94) And Not (vX - i = 92 And vY + i = 94) Then
            vX = vX - i
            vY = vY + i
            RhombLegalPos = True
            Exit Function

        End If

    Next

    vX = Pos.X
    vY = Pos.Y + Distance

    For i = 0 To Distance - 1

        If (LegalPos(Pos.Map, vX - i, vY - i, PuedeAgua, PuedeTierra, checkExitTile, PuedeOscuro)) And Not (vX - i = 92 And vY - i = 7) And Not (vX - i = 9 And vY - i = 7) And Not (vX - i = 9 And vY - i = 94) And Not (vX - i = 92 And vY - i = 94) Then
            vX = vX - i
            vY = vY - i
            RhombLegalPos = True
            Exit Function

        End If

    Next

    RhombLegalPos = False

End Function

Public Function RhombLegalTilePos(ByRef Pos As WorldPos, ByRef vX As Long, ByRef vY As Long, _
                                  ByVal Distance As Long, ByVal ObjIndex As Integer, ByVal ObjAmount As Long, _
                                  ByVal PuedeAgua As Boolean, ByVal PuedeTierra As Boolean) As Boolean        ' 0.13.3
'***************************************************
'Author: ZaMa
'Last Modification: 10/07/2012 - ^[GS]^
' walks all the perimeter of a rhomb of side  "distance + 1",
' which starts at Pos.x - Distance and Pos.y
' and searchs for a valid position to drop items
'***************************************************

    Dim i As Long
    Dim X As Integer
    Dim Y As Integer

    vX = Pos.X - Distance
    vY = Pos.Y

    For i = 0 To Distance - 1

        X = vX + i
        Y = vY - i

        If (LegalPos(Pos.Map, X, Y, PuedeAgua, PuedeTierra, True)) Then

            ' No hay obj tirado o la suma de lo que hay + lo nuevo <= 10k
            If Not HayObjeto(Pos.Map, X, Y, ObjIndex, ObjAmount) Then
                vX = X
                vY = Y

                RhombLegalTilePos = True
                Exit Function
            End If

        End If
    Next

    vX = Pos.X
    vY = Pos.Y - Distance

    For i = 0 To Distance - 1

        X = vX + i
        Y = vY + i

        If (LegalPos(Pos.Map, X, Y, PuedeAgua, PuedeTierra, True)) Then

            ' No hay obj tirado o la suma de lo que hay + lo nuevo <= 10k
            If Not HayObjeto(Pos.Map, X, Y, ObjIndex, ObjAmount) Then
                vX = X
                vY = Y

                RhombLegalTilePos = True
                Exit Function
            End If
        End If
    Next

    vX = Pos.X + Distance
    vY = Pos.Y

    For i = 0 To Distance - 1

        X = vX - i
        Y = vY + i

        If (LegalPos(Pos.Map, X, Y, PuedeAgua, PuedeTierra, True)) Then

            ' No hay obj tirado o la suma de lo que hay + lo nuevo <= 10k
            If Not HayObjeto(Pos.Map, X, Y, ObjIndex, ObjAmount) Then
                vX = X
                vY = Y

                RhombLegalTilePos = True
                Exit Function
            End If
        End If
    Next

    vX = Pos.X
    vY = Pos.Y + Distance

    For i = 0 To Distance - 1

        X = vX - i
        Y = vY - i

        If (LegalPos(Pos.Map, X, Y, PuedeAgua, PuedeTierra, True)) Then
            ' No hay obj tirado o la suma de lo que hay + lo nuevo <= 10k
            If Not HayObjeto(Pos.Map, X, Y, ObjIndex, ObjAmount) Then
                vX = X
                vY = Y

                RhombLegalTilePos = True
                Exit Function
            End If
        End If
    Next

    RhombLegalTilePos = False

End Function


Public Function HayObjeto(ByVal mapa As Integer, ByVal X As Long, ByVal Y As Long, _
                          ByVal ObjIndex As Integer, ByVal ObjAmount As Long) As Boolean        ' 0.13.3
'***************************************************
'Author: ZaMa
'Last Modification: 10/07/2012 - ^[GS]^
'Checks if there's space in a tile to add an itemAmount
'***************************************************
    Dim MapObjIndex As Integer
    MapObjIndex = MapData(mapa, X, Y).ObjInfo.ObjIndex

    ' Hay un objeto tirado?
    If MapObjIndex <> 0 Then
        ' Es el mismo objeto?
        If MapObjIndex = ObjIndex Then
            ' La suma es menor a 10k?
            HayObjeto = (MapData(mapa, X, Y).ObjInfo.Amount + ObjAmount > MAX_INVENTORY_OBJS)
        Else
            HayObjeto = True
        End If
    Else
        HayObjeto = False
    End If

End Function
Public Sub ClosestStablePos(Pos As WorldPos, ByRef nPos As WorldPos)
'***************************************************
'Author: Unknown
'Last Modification: -
'Encuentra la posicion legal mas cercana que no sea un portal y la guarda en nPos
'*****************************************************************

    Call ClosestLegalPos(Pos, nPos, , , True)
    Exit Sub
    Dim Notfound As Boolean
    Dim LoopC As Integer
    Dim tX As Long
    Dim tY As Long

    nPos.Map = Pos.Map

    Do While Not LegalPos(Pos.Map, nPos.X, nPos.Y)
        If LoopC > 12 Then
            Notfound = True
            Exit Do
        End If

        For tY = Pos.Y - LoopC To Pos.Y + LoopC
            For tX = Pos.X - LoopC To Pos.X + LoopC

                If LegalPos(nPos.Map, tX, tY) And MapData(nPos.Map, tX, tY).TileExit.Map = 0 Then
                    nPos.X = tX
                    nPos.Y = tY
                    '¿Hay objeto?

                    tX = Pos.X + LoopC
                    tY = Pos.Y + LoopC
                End If
            Next tX
        Next tY

        LoopC = LoopC + 1
    Loop

    If Notfound = True Then
        nPos.X = 0
        nPos.Y = 0
    End If

End Sub
Public Sub ClosestStablePos1(Pos As WorldPos, ByRef nPos As WorldPos)
'***************************************************
'Author: Unknown
'Last Modification: -
'Encuentra la posicion legal mas cercana que no sea un portal y la guarda en nPos
'*****************************************************************

    Dim Notfound As Boolean
    Dim LoopC As Integer
    Dim tX As Long
    Dim tY As Long

    nPos.Map = Pos.Map

    Do While Not LegalPos1(Pos.Map, nPos.X, nPos.Y)
        If LoopC > 12 Then
            Notfound = True
            Exit Do
        End If

        For tY = Pos.Y - LoopC To Pos.Y + LoopC
            For tX = Pos.X - LoopC To Pos.X + LoopC

                If LegalPos1(nPos.Map, tX, tY) And MapData(nPos.Map, tX, tY).TileExit.Map = 0 Then
                    nPos.X = tX
                    nPos.Y = tY
                    '¿Hay objeto?

                    tX = Pos.X + LoopC
                    tY = Pos.Y + LoopC
                End If
            Next tX
        Next tY

        LoopC = LoopC + 1
    Loop

    If Notfound = True Then
        nPos.X = 0
        nPos.Y = 0
    End If

End Sub
Function NameIndex(ByVal Name As String) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim UserIndex As Long

    '¿Nombre valido?
    If LenB(Name) = 0 Then
        NameIndex = 0
        Exit Function
    End If

    Name = UCase$(Replace(Name, "+", " "))

    UserIndex = 1
    Do Until UCase$(UserList(UserIndex).Name) = Name

        UserIndex = UserIndex + 1

        If UserIndex > LastUser Then
            NameIndex = 0
            Exit Function
        End If
    Loop

    NameIndex = UserIndex
End Function

Function CheckForSameIP(ByVal UserIndex As Integer, ByVal UserIP As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    For LoopC = 1 To maxUsers
        If UserList(LoopC).flags.UserLogged = True Then
            If UserList(LoopC).IP = UserIP And UserIndex <> LoopC Then
                CheckForSameIP = True
                Exit Function
            End If
        End If
    Next LoopC

    CheckForSameIP = False
End Function

Function CheckForSameName(ByVal Name As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'Controlo que no existan usuarios con el mismo nombre
    Dim LoopC As Long

    For LoopC = 1 To LastUser
        If UserList(LoopC).flags.UserLogged Then

            If UCase$(UserList(LoopC).Name) = UCase$(Name) Then
                CheckForSameName = True
                Exit Function
            End If
        End If
    Next LoopC

    CheckForSameName = False
End Function

Sub HeadtoPos(ByVal Head As eHeading, ByRef Pos As WorldPos)
'***************************************************
'Author: Unknown
'Last Modification: -
'Toma una posicion y se mueve hacia donde esta perfilado
'*****************************************************************

    Dim X As Integer
    Dim Y As Integer
    Dim tempVar As Single
    Dim nX As Integer
    Dim nY As Integer

    X = Pos.X
    Y = Pos.Y

    If Head = NORTH Then
        nX = X
        nY = Y - 1
    End If

    If Head = SOUTH Then
        nX = X
        nY = Y + 1
    End If

    If Head = EAST Then
        nX = X + 1
        nY = Y
    End If

    If Head = WEST Then
        nX = X - 1
        nY = Y
    End If

    'Devuelve valores
    Pos.X = nX
    Pos.Y = nY

    Exit Sub

    Select Case Head
    Case eHeading.NORTH
        Pos.Y = Pos.Y - 1

    Case eHeading.SOUTH
        Pos.Y = Pos.Y + 1

    Case eHeading.EAST
        Pos.X = Pos.X + 1

    Case eHeading.WEST
        Pos.X = Pos.X - 1
    End Select
End Sub

Function LegalPos(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ByVal PuedeAgua As Boolean = False, Optional ByVal PuedeTierra As Boolean = True, Optional ByVal checkExitTile As Boolean = False, Optional ByVal PuedeOscuro As Boolean = True) As Boolean
'***************************************************
'Autor: Pablo (ToxicWaste) & Unknown (orginal version)
'Last Modification: 27/12/2012 - ^[GS]^
'Checks if the position is Legal.
'***************************************************

'¿Es un mapa valido?


    If (Map <= 0 Or Map > NumMaps) Or (X = 92 And Y = 7) Or (X = 9 And Y = 7) Or (X = 9 And Y = 94) Or (X = 92 And Y = 94) Then
        LegalPos = False
    End If

    If (Map < 1 Or Map > NumMaps) Or (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then
        LegalPos = False
    Else
        With MapData(Map, X, Y)
            If PuedeAgua And PuedeTierra Then
                LegalPos = (.Blocked <> 1) And (.UserIndex = 0) And (.NpcIndex = 0)
            ElseIf PuedeTierra And Not PuedeAgua Then
                LegalPos = (.Blocked <> 1) And (.UserIndex = 0) And (.NpcIndex = 0) And (Not HayAgua(Map, X, Y))
            ElseIf PuedeAgua And Not PuedeTierra Then
                LegalPos = (.Blocked <> 1) And (.UserIndex = 0) And (.NpcIndex = 0) And (HayAgua(Map, X, Y))
            Else
                LegalPos = False
            End If
        End With

        If checkExitTile Then
            LegalPos = LegalPos And (MapData(Map, X, Y).TileExit.Map = 0)
        End If

        If Not PuedeOscuro Then
            LegalPos = LegalPos And (MapData(Map, X, Y).Graphic(4) = 0)
        End If
    End If

End Function

Function LegalPosMistic(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean

    If (Map < 1 Or Map > NumMaps) Or (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then
        LegalPosMistic = True
    Else
        If MapData(Map, X, Y).TileExit.Map > 0 Then
            LegalPosMistic = True
        End If
    End If

End Function

Function LegalPos1(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ByVal PuedeAgua As Boolean = False, Optional ByVal PuedeTierra As Boolean = True) As Boolean

'¿Es un mapa valido?
    If (Map <= 0 Or Map > NumMaps) Or _
       (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then
        LegalPos1 = False
    Else
        With MapData(Map, X, Y)
            LegalPos1 = (.UserIndex = 0) And _
                        (.NpcIndex = 0)
        End With
    End If

End Function

Function MoveToLegalPos(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ByVal PuedeAgua As Boolean = False, Optional ByVal PuedeTierra As Boolean = True, Optional ByVal tIndex As Integer = 0) As Boolean
'***************************************************
'Autor: ZaMa
'Last Modification: 27/12/2012 - ^[GS]^
'Checks if the position is Legal, but considers that if there's a casper, it's a legal movement.
'***************************************************

    Dim UserIndex As Integer
    Dim IsDeadChar As Boolean
    Dim IsAdminInvisible As Boolean

    '¿Es un mapa valido?
    If (Map < 1 Or Map > NumMaps) Or (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then
        MoveToLegalPos = False
    Else
        With MapData(Map, X, Y)
            UserIndex = .UserIndex

            If UserIndex > 0 Then
                IsDeadChar = (UserList(UserIndex).flags.Muerto = 1)
                IsAdminInvisible = (UserList(UserIndex).flags.AdminInvisible = 1)
            Else
                IsDeadChar = False
                IsAdminInvisible = False
            End If

            If tIndex Then
                If Not UserList(tIndex).flags.Privilegios = PlayerType.User Then
                    PuedeAgua = True
                    PuedeTierra = True
                End If
            End If
            If PuedeAgua And PuedeTierra Then
                MoveToLegalPos = (.Blocked <> 1) And (UserIndex = 0 Or IsDeadChar Or IsAdminInvisible) And (.NpcIndex = 0)
            ElseIf PuedeTierra And Not PuedeAgua Then
                MoveToLegalPos = (.Blocked <> 1) And (UserIndex = 0 Or IsDeadChar Or IsAdminInvisible) And (.NpcIndex = 0) And (Not HayAgua(Map, X, Y))
            ElseIf PuedeAgua And Not PuedeTierra Then
                MoveToLegalPos = (.Blocked <> 1) And (UserIndex = 0 Or IsDeadChar Or IsAdminInvisible) And (.NpcIndex = 0) And (HayAgua(Map, X, Y))
            Else
                MoveToLegalPos = False
            End If

        End With
    End If

End Function

Public Sub FindLegalPos(ByVal UserIndex As Integer, ByVal Map As Integer, ByRef X As Integer, ByRef Y As Integer, Optional ByVal NotCheckTileExit As Boolean = False)
'***************************************************
'Autor: ZaMa
'Last Modification: 26/12/2012 - ^[GS]^
'Search for a Legal pos for the user who is being teleported.
'***************************************************

1   On Error GoTo FindLegalPos_Error

2   If MapData(Map, X, Y).UserIndex <> 0 Or MapData(Map, X, Y).NpcIndex <> 0 Or (MapData(Map, X, Y).TileExit.Map <> 0 And NotCheckTileExit = True) Then

        ' Se teletransporta a la misma pos a la que estaba
3       If MapData(Map, X, Y).UserIndex = UserIndex Then Exit Sub

        Dim FoundPlace As Boolean
        Dim tX As Long
        Dim tY As Long
        Dim Rango As Long
        Dim OtherUserIndex As Integer

4       For Rango = 1 To 5
5           For tY = Y - Rango To Y + Rango
6               For tX = X - Rango To X + Rango
                    'Reviso que no haya User ni NPC
7                   If MapData(Map, tX, tY).UserIndex = 0 And MapData(Map, tX, tY).NpcIndex = 0 Then
8                       If InMapBounds(Map, tX, tY) Then FoundPlace = True
9                       Exit For
10                  End If
11              Next tX

12              If FoundPlace Then Exit For
13          Next tY

14          If FoundPlace Then Exit For
15      Next Rango


16      If FoundPlace Then        'Si encontramos un lugar, listo, nos quedamos ahi
17          X = tX
18          Y = tY
19      Else
            'Muy poco probable, pero..
            'Si no encontramos un lugar, sacamos al usuario que tenemos abajo, y si es un NPC, lo pisamos.
20          OtherUserIndex = MapData(Map, X, Y).UserIndex
21          If OtherUserIndex <> 0 Then
                'Si no encontramos lugar, y abajo teniamos a un usuario, lo pisamos y cerramos su comercio seguro
22              If UserList(OtherUserIndex).ComUsu.DestUsu > 0 Then
                    'Le avisamos al que estaba comerciando que se tuvo que ir.
23                  If UserList(UserList(OtherUserIndex).ComUsu.DestUsu).flags.UserLogged Then
24                      Call FinComerciarUsu(UserList(OtherUserIndex).ComUsu.DestUsu)
25                      Call WriteMensajes(UserList(OtherUserIndex).ComUsu.DestUsu, e_Mensajes.Mensaje_129)        '"Comercio cancelado. El otro usuario se ha desconectado."
27                  End If
                    'Lo sacamos.
28                  If UserList(OtherUserIndex).flags.UserLogged Then
29                      Call FinComerciarUsu(OtherUserIndex)
30                      Call WriteErrorMsg(OtherUserIndex, "Alguien se ha conectado donde te encontrabas, por favor reconéctate...")
32                  End If
33              End If

34              Call CloseSocket(OtherUserIndex)
35          End If
36      End If
37  End If

38  Exit Sub

FindLegalPos_Error:

39  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure FindLegalPos of Módulo modExtra" & Erl & ".")

End Sub
Function LegalPosNPC(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal AguaValida As Byte, Optional ByVal IsPet As Boolean = False) As Boolean
'***************************************************
'Autor: Unkwnown
'Last Modification: 09/23/2009
'Checks if it's a Legal pos for the npc to move to.
'09/23/2009: Pato - If UserIndex is a AdminInvisible, then is a legal pos.
'***************************************************
    Dim IsDeadChar As Boolean
    Dim UserIndex As Integer
    Dim IsAdminInvisible As Boolean


    If (Map <= 0 Or Map > NumMaps) Or _
       (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then
        LegalPosNPC = False
        Exit Function
    End If

    With MapData(Map, X, Y)
        UserIndex = .UserIndex
        If UserIndex > 0 Then
            IsDeadChar = UserList(UserIndex).flags.Muerto = 1
            IsAdminInvisible = (UserList(UserIndex).flags.AdminInvisible = 1)
        Else
            IsDeadChar = False
            IsAdminInvisible = False
        End If

        If AguaValida = 0 Then
            LegalPosNPC = (.Blocked <> 1) And _
                          (.UserIndex = 0 Or IsDeadChar Or IsAdminInvisible) And _
                          (.NpcIndex = 0) And _
                          (.trigger <> eTrigger.POSINVALIDA Or IsPet) _
                          And Not HayAgua(Map, X, Y)
        Else
            LegalPosNPC = (.Blocked <> 1 And .TileExit.Map <= 0) And _
                          (.UserIndex = 0 Or IsDeadChar Or IsAdminInvisible) And _
                          (.NpcIndex = 0) And _
                          (.trigger <> eTrigger.POSINVALIDA Or IsPet)
        End If
    End With
End Function

Sub SendHelp(ByVal Index As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim NumHelpLines As Integer
    Dim LoopC As Integer

    NumHelpLines = val(GetVar(DatPath & "Help.dat", "INIT", "NumLines"))

    For LoopC = 1 To NumHelpLines
        Call WriteConsoleMsg(Index, GetVar(DatPath & "Help.dat", "Help", "Line" & LoopC), FontTypeNames.FONTTYPE_INFO)
    Next LoopC

End Sub

Public Sub Expresar(ByVal NpcIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If Npclist(NpcIndex).NroExpresiones > 0 Then
        Dim randomi
        randomi = RandomNumber(1, Npclist(NpcIndex).NroExpresiones)
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(Npclist(NpcIndex).Expresiones(randomi), Npclist(NpcIndex).Char.CharIndex, vbWhite))
    End If
End Sub

Sub LookatTile(ByVal UserIndex As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ByVal LanzaSpell As Byte = 0)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 26/03/2009
'13/02/2009: ZaMa - EL nombre del gm que aparece por consola al clickearlo, tiene el color correspondiente a su rango
'***************************************************

    On Error GoTo Errhandler

    'Responde al click del usuario sobre el mapa
    Dim FoundChar As Byte
    Dim FoundSomething As Byte
    Dim TempCharIndex As Integer
    Dim Stat As String
    Dim ft As FontTypeNames

    With UserList(UserIndex)
        '¿Rango Visión? (ToxicWaste)
        If (Abs(.Pos.Y - Y) > RANGO_VISION_Y) Or (Abs(.Pos.X - X) > RANGO_VISION_X) Then
            Exit Sub
        End If

        '¿Posicion valida?
        If InMapBounds(Map, X, Y) Then
            With .flags
                .TargetMap = Map
                .TargetX = X
                .TargetY = Y
                '¿Es un obj?
                If MapData(Map, X, Y).ObjInfo.ObjIndex > 0 Then
                    'Informa el nombre
                    .TargetObjMap = Map
                    .TargetObjX = X
                    .TargetObjY = Y
                    FoundSomething = 1
                ElseIf MapData(Map, X + 1, Y).ObjInfo.ObjIndex > 0 Then
                    'Informa el nombre
1                   If ObjData(MapData(Map, X + 1, Y).ObjInfo.ObjIndex).OBJType = eOBJType.otPuertas Then
2                       .TargetObjMap = Map
                        .TargetObjX = X + 1
                        .TargetObjY = Y
                        FoundSomething = 1
                    End If
                ElseIf MapData(Map, X + 1, Y + 1).ObjInfo.ObjIndex > 0 Then
3                   If ObjData(MapData(Map, X + 1, Y + 1).ObjInfo.ObjIndex).OBJType = eOBJType.otPuertas Then
                        'Informa el nombre
                        .TargetObjMap = Map
                        .TargetObjX = X + 1
                        .TargetObjY = Y + 1
                        FoundSomething = 1
                    End If
                ElseIf MapData(Map, X, Y + 1).ObjInfo.ObjIndex > 0 Then
4                   If ObjData(MapData(Map, X, Y + 1).ObjInfo.ObjIndex).OBJType = eOBJType.otPuertas Then
                        'Informa el nombre
5                       .TargetObjMap = Map
                        .TargetObjX = X
                        .TargetObjY = Y + 1
                        FoundSomething = 1
                    End If
                End If

6               If FoundSomething = 1 Then
7                   .TargetObj = MapData(Map, .TargetObjX, .TargetObjY).ObjInfo.ObjIndex

8                   If EsGM(UserIndex) Then
9                       If ObjData(.TargetObj).OBJType = eOBJType.otTeleport Then

                            Dim destino_mapa As String

10                          If .TargetObjMap > 0 Then
11                              If MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Map > 0 Then
12                                  destino_mapa = MapInfo(MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Map).Name & " - " & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Map
                                End If
                            End If

13                          If Len(destino_mapa) > 0 Then
14                              Call WriteConsoleMsg(UserIndex, "Teleport a " & destino_mapa & " " & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.X & "-" & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Y)

                            Else
15                              Call WriteConsoleMsg(UserIndex, "Teleport a " & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Map & "-" & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.X & "-" & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).TileExit.Y)
                            End If

                        Else
16                          Call WriteConsoleMsg(UserIndex, ObjData(.TargetObj).Name & " - Cantidad: " & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).ObjInfo.Amount & " - Num: " & .TargetObj & "", FontTypeNames.FONTTYPE_INFO)
                        End If
                    Else
17                      If MostrarCantidad(.TargetObj) And UserList(UserIndex).Stats.UserSkills(eSkill.Supervivencia) = 100 Then
                            'Call WriteConsoleMsg(UserIndex, ObjData(.TargetObj).Name, FontTypeNames.FONTTYPE_INFO)
                            Call WriteConsoleMsg(UserIndex, ObjData(.TargetObj).Name & " - " & MapData(.TargetObjMap, .TargetObjX, .TargetObjY).ObjInfo.Amount, FontTypeNames.FONTTYPE_INFO)
                        Else
                            Call WriteConsoleMsg(UserIndex, ObjData(.TargetObj).Name, FontTypeNames.FONTTYPE_INFO)
                        End If
                    End If

                End If
                '¿Es un personaje?
19              If Y + 1 <= YMaxMapSize Then
18                  If MapData(Map, X, Y + 1).UserIndex > 0 Then
20                      TempCharIndex = MapData(Map, X, Y + 1).UserIndex
                        FoundChar = 1
                    End If
21                  If MapData(Map, X, Y + 1).NpcIndex > 0 Then
22                      TempCharIndex = MapData(Map, X, Y + 1).NpcIndex
                        FoundChar = 2
                    End If
                End If
                '¿Es un personaje?
                If FoundChar = 0 Then
24                  If MapData(Map, X, Y).UserIndex > 0 Then
23                      TempCharIndex = MapData(Map, X, Y).UserIndex
                        FoundChar = 1
                    End If
25                  If MapData(Map, X, Y).NpcIndex > 0 Then
26                      TempCharIndex = MapData(Map, X, Y).NpcIndex
                        FoundChar = 2
                    End If
                    ' @@ Clickeo un bot?
780                 .TargetBot = MapData(Map, X, Y).BotIndex
790                 If Not .TargetBot <> 0 Then .TargetBot = MapData(Map, X, Y + 1).BotIndex

800                 If .TargetBot <> 0 Then
810                     If IA_Bot(.TargetBot).Summoned Then
                            FoundChar = 0
                            'If ia_Bot(.TargetBot).EsCriminal Then

                            If UserList(UserIndex).flags.Hechizo = 0 Then
820                             Call WriteConsoleMsg(UserIndex, "Ves a " & IA_Bot(.TargetBot).TAG & " - Nivel " & IA_Bot(.TargetBot).Difficulty & " - Vida: " & IA_Bot(.TargetBot).HP & "/" & IA_Bot(.TargetBot).MaxHP, FontTypeNames.FONTTYPE_FIGHT)
                            End If
                            'Else
                            '    Call WriteConsoleMsg(UserIndex, "Ves a " & ia_Bot(.TargetBot).TAG, FontTypeNames.FONTTYPE_CITIZEN)
                            'End If
830                     End If
840                 End If
                End If
            End With

            'Reaccion al personaje
            If FoundChar = 1 Then        '  ¿Encontro un Usuario?
27              If UserList(TempCharIndex).flags.AdminInvisible = 0 Or .flags.Privilegios >= PlayerType.Dios Then
28                  With UserList(TempCharIndex)
29                      If LenB(.DescRM) = 0 And (.showName Or UserList(UserIndex).flags.Privilegios >= PlayerType.Dios) And LanzaSpell < 1 Then          'No tiene descRM y quiere que se vea su nombre.
30                          If EsNewbie(TempCharIndex) Then
31                              Stat = " <NEWBIE>"
                            End If

                            If .faccion.ArmadaReal = 1 Then
32                              Stat = Stat & " <Ejército Real> " & "<" & TituloReal(UserList(TempCharIndex).faccion.RecompensasReal) & ">"
33                          ElseIf .faccion.FuerzasCaos = 1 Then
34                              Stat = Stat & " <Legión Oscura> " & "<" & TituloCaos(UserList(TempCharIndex).faccion.RecompensasCaos) & ">"
                            End If

35                          If .GuildIndex > 0 Then
36                              Stat = Stat & " <" & modGuilds.GuildName(.GuildIndex) & ">"
                            End If

                            If Len(.Desc) > 0 Then
                                Stat = "Ves a " & .Name & Stat & " - " & .Desc
                            Else
                                Stat = "Ves a " & .Name & Stat
                            End If


37                          If EsGM(UserIndex) Then
38                              If .flags.Comerciando Then
                                    If .flags.commerce_npc_npcindex Then
39                                      Stat = Stat & " - Comerciando con " & Npclist(.flags.commerce_npc_npcindex).Name & " - npcIndex: " & .flags.commerce_npc_npcindex
                                    Else
                                        .flags.commerce_npc_npcindex = 0
                                    End If
                                End If
                            End If

40                          If .flags.Privilegios > PlayerType.RoleMaster Then
                                Stat = Stat & " <GAME MASTER>"
                                ' Dios-Admin
                                If .flags.Privilegios >= PlayerType.Dios Then
                                    ft = FontTypeNames.FONTTYPE_DIOS
                                ElseIf .flags.Privilegios = PlayerType.SemiDios Then
                                    ft = FontTypeNames.FONTTYPE_GM
                                    ' Conse
                                ElseIf .flags.Privilegios = PlayerType.Consejero Then
                                    ft = FontTypeNames.FONTTYPE_CONSE
                                    ' Rm o Dsrm
                                Else        'If .flags.Privilegios = (PlayerType.RoleMaster Or PlayerType.Consejero) Or .flags.Privilegios = (PlayerType.RoleMaster Or PlayerType.Dios) Then
                                    ft = FontTypeNames.FONTTYPE_EJECUCION
                                End If

                            Else

                                If .faccion.Status = FaccionType.RoyalCouncil Then
                                    Stat = Stat & " [CONSEJO DE BANDERBILL]"
                                    ft = FontTypeNames.FONTTYPE_CONSEJOVesA
                                ElseIf .faccion.Status = FaccionType.ChaosCouncil Then
                                    Stat = Stat & " [CONCILIO DE LAS SOMBRAS]"
                                    ft = FontTypeNames.FONTTYPE_CONSEJOCAOSVesA
                                ElseIf .flags.Privilegios = PlayerType.RoleMaster Then
                                    Stat = Stat & " <ROLE MASTER>"
                                    ft = FontTypeNames.FONTTYPE_EJECUCION
                                ElseIf criminal(TempCharIndex) Then
                                    Stat = Stat & " <CRIMINAL>"
                                    ft = FontTypeNames.FONTTYPE_FIGHT
                                Else
                                    Stat = Stat & " <CIUDADANO>"
                                    ft = FontTypeNames.FONTTYPE_CITIZEN
                                End If

                            End If

41                          If .flags.Muerto = 1 Then
                                Stat = Stat & " <MUERTO>"
                                ft = FontTypeNames.FONTTYPE_EJECUCION
                            End If
                        Else        'Si tiene descRM la muestro siempre.
                            Stat = .DescRM
                            ft = FontTypeNames.FONTTYPE_INFOBOLD
                        End If
                    End With


42                  If Not EsGM(UserIndex) Then
43                      If .flags.EnEvento = 3 Then  'JDH
44                          Stat = "Ves a Alguien"
                            ft = FontTypeNames.FONTTYPE_EVENTOS
                        End If
                    End If

                    If LenB(Stat) > 0 Then
45                      Call WriteConsoleMsg(UserIndex, Stat, ft)
                    End If

                    FoundSomething = 1
                    .flags.TargetUser = TempCharIndex
                    .flags.TargetNPC = 0
                    .flags.TargetNpcTipo = eNPCType.Comun
                End If
            End If

            With .flags
                If FoundChar = 2 Then        '¿Encontro un NPC?
                    Dim estatus As String
                    Dim MinHP As Long
                    Dim MaxHP As Long
                    Dim SupervivenciaSkill As Byte
                    Dim sDesc As String

46                  MinHP = Npclist(TempCharIndex).Stats.MinHP
47                  MaxHP = Npclist(TempCharIndex).Stats.MaxHP
48                  SupervivenciaSkill = UserList(UserIndex).Stats.UserSkills(eSkill.Supervivencia)

49                  If EsGM(UserIndex) Then
50                      estatus = "(" & MinHP & "/" & MaxHP & ") "
                    Else
51                      If .Muerto = 0 Then
                            If SupervivenciaSkill >= 0 And SupervivenciaSkill <= 10 Then
                                'estatus = "(Dudoso) "
                            ElseIf SupervivenciaSkill > 10 And SupervivenciaSkill <= 20 Then
                                If MinHP < (MaxHP / 2) Then
                                    estatus = "(Herido) "
                                Else
                                    estatus = "(Sano) "
                                End If
                            ElseIf SupervivenciaSkill > 20 And SupervivenciaSkill <= 30 Then
                                If MinHP < (MaxHP * 0.5) Then
                                    estatus = "(Malherido) "
                                ElseIf MinHP < (MaxHP * 0.75) Then
                                    estatus = "(Herido) "
                                Else
                                    estatus = "(Sano) "
                                End If
                            ElseIf SupervivenciaSkill > 30 And SupervivenciaSkill <= 40 Then
                                If MinHP < (MaxHP * 0.25) Then
                                    estatus = "(Muy malherido) "
                                ElseIf MinHP < (MaxHP * 0.5) Then
                                    estatus = "(Herido) "
                                ElseIf MinHP < (MaxHP * 0.75) Then
                                    estatus = "(Levemente herido) "
                                Else
                                    estatus = "(Sano) "
                                End If
                            ElseIf SupervivenciaSkill > 40 And SupervivenciaSkill < 60 Then
                                If MinHP < (MaxHP * 0.05) Then
                                    estatus = "(Agonizando) "
                                ElseIf MinHP < (MaxHP * 0.1) Then
                                    estatus = "(Casi muerto) "
                                ElseIf MinHP < (MaxHP * 0.25) Then
                                    estatus = "(Muy Malherido) "
                                ElseIf MinHP < (MaxHP * 0.5) Then
                                    estatus = "(Herido) "
                                ElseIf MinHP < (MaxHP * 0.75) Then
                                    estatus = "(Levemente herido) "
                                ElseIf MinHP < (MaxHP) Then
                                    estatus = "(Sano) "
                                Else
                                    estatus = "(Intacto) "
                                End If
                            ElseIf SupervivenciaSkill >= 60 Then
                                estatus = "(" & MinHP & "/" & MaxHP & ") "
                            Else
                                estatus = "¡Error!"
                            End If
                        End If
                    End If


                    If LanzaSpell < 1 Then
52                      If Len(Npclist(TempCharIndex).Desc) > 1 Then
53                          If EsGM(UserIndex) Then
                                Call WriteConsoleMsg(UserIndex, "Ves a " & Npclist(TempCharIndex).Name & " - NpcNum: " & Npclist(TempCharIndex).Numero)

                            End If

                            If TempCharIndex = CentinelaNPCIndex And (Centinela.RevisandoUserIndex = UserIndex Or EsGM(UserIndex)) Then
                                Call WriteChatOverHead(UserIndex, Centinela.Frase, Npclist(TempCharIndex).Char.CharIndex, vbWhite)
                            Else
                                Call WriteChatOverHead(UserIndex, Npclist(TempCharIndex).Desc, Npclist(TempCharIndex).Char.CharIndex, vbWhite)
                            End If

                        ElseIf TempCharIndex = CentinelaNPCIndex Then
                            'Enviamos nuevamente el texto del centinela según quien pregunta
55                          Call modCentinela.CentinelaSendClave(UserIndex)
                        Else
56                          If Npclist(TempCharIndex).MaestroUser > 0 Then
57                              Call WriteConsoleMsg(UserIndex, estatus & Npclist(TempCharIndex).Name & " es mascota de " & UserList(Npclist(TempCharIndex).MaestroUser).Name & "." & IIf(EsGM(UserIndex), " Tiempo de invocación: " & Npclist(TempCharIndex).Contadores.TiempoExistencia, ""), FontTypeNames.FONTTYPE_INFO)
                            Else
58                              sDesc = estatus & Npclist(TempCharIndex).Name
59                              If Npclist(TempCharIndex).Owner > 0 Then sDesc = sDesc & " le pertenece a " & UserList(Npclist(TempCharIndex).Owner).Name
60                              sDesc = sDesc & "."

                                If Npclist(TempCharIndex).flags.Inmovilizado <> 0 Then
                                    sDesc = sDesc & " [Inmovilizado]"
                                ElseIf Npclist(TempCharIndex).flags.Paralizado <> 0 Then
                                    sDesc = sDesc & " [Paralizado]"
                                End If

                                Call WriteConsoleMsg(UserIndex, sDesc, FontTypeNames.FONTTYPE_INFO)

61                              If EsGM(UserIndex) Then
                                    If Len(Npclist(TempCharIndex).flags.AttackedFirstBy) > 0 Then
                                        Call WriteConsoleMsg(UserIndex, "Le pegó primero: " & Npclist(TempCharIndex).flags.AttackedFirstBy, FontTypeNames.FONTTYPE_INFO)
                                    End If
                                    Call WriteConsoleMsg(UserIndex, "NPC ID: " & Npclist(TempCharIndex).Numero, FontTypeNames.FONTTYPE_INFO)
                                End If

                            End If
                        End If
3340                End If

                    FoundSomething = 1
                    .TargetNpcTipo = Npclist(TempCharIndex).NPCtype
                    .TargetNPC = TempCharIndex
                    .TargetUser = 0
                    .TargetObj = 0
                End If

                If FoundChar = 0 Then
                    .TargetNPC = 0
                    .TargetNpcTipo = eNPCType.Comun
                    .TargetUser = 0
                End If

                If FoundSomething = 0 Then
                    .TargetNPC = 0
                    .TargetNpcTipo = eNPCType.Comun
                    .TargetUser = 0
                    .TargetObj = 0
                    .TargetObjMap = 0
                    .TargetObjX = 0
                    .TargetObjY = 0
                    'Call WriteMultiMessage(UserIndex, eMessages.DontSeeAnything)
                End If
            End With
        Else
            If FoundSomething = 0 Then
                With .flags
                    .TargetNPC = 0
                    .TargetNpcTipo = eNPCType.Comun
                    .TargetUser = 0
                    .TargetObj = 0
                    .TargetObjMap = 0
                    .TargetObjX = 0
                    .TargetObjY = 0
                End With

                'Call WriteMultiMessage(UserIndex, eMessages.DontSeeAnything)
            End If
        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en LookAtTile en " & Erl & ". Error " & Err.Number & " : " & Err.Description)

End Sub

Function FindDirection(Pos As WorldPos, Target As WorldPos, Optional ByVal Inteligencia As Boolean) As eHeading
'***************************************************
'Author: Unknown
'Last Modification: -
'Devuelve la direccion en la cual el target se encuentra
'desde pos, 0 si la direc es igual
'*****************************************************************

'*****************************************************************
'Devuelve la direccion en la cual el target se encuentra
'desde pos, 0 si la direc es igual
'*****************************************************************
    If Not Inteligencia Then
        Dim X As Integer
        Dim Y As Integer

        X = Pos.X - Target.X
        Y = Pos.Y - Target.Y
        'NE
        If Sgn(X) = -1 And Sgn(Y) = 1 Then
            FindDirection = NORTH
            Exit Function
        End If
        'NW
        If Sgn(X) = 1 And Sgn(Y) = 1 Then
            FindDirection = WEST
            Exit Function
        End If
        'SW
        If Sgn(X) = 1 And Sgn(Y) = -1 Then
            FindDirection = WEST
            Exit Function
        End If
        'SE
        If Sgn(X) = -1 And Sgn(Y) = -1 Then
            FindDirection = SOUTH
            Exit Function
        End If
        'Sur
        If Sgn(X) = 0 And Sgn(Y) = -1 Then
            FindDirection = SOUTH
            Exit Function
        End If
        'norte
        If Sgn(X) = 0 And Sgn(Y) = 1 Then
            FindDirection = NORTH
            Exit Function
        End If
        'oeste
        If Sgn(X) = 1 And Sgn(Y) = 0 Then
            FindDirection = WEST
            Exit Function
        End If
        'este
        If Sgn(X) = -1 And Sgn(Y) = 0 Then
            FindDirection = EAST
            Exit Function
        End If
        'misma
        If Sgn(X) = 0 And Sgn(Y) = 0 Then
            FindDirection = 0
            Exit Function
        End If
    Else

        Dim possibleDirections() As eHeading
        Dim directionCount As Integer
        directionCount = 0

        If Pos.X < Target.X Then
            ReDim Preserve possibleDirections(directionCount)
            possibleDirections(directionCount) = eHeading.EAST
            directionCount = directionCount + 1
        End If

        If Pos.X > Target.X Then
            ReDim Preserve possibleDirections(directionCount)
            possibleDirections(directionCount) = eHeading.WEST
            directionCount = directionCount + 1
        End If

        If Pos.Y < Target.Y Then
            ReDim Preserve possibleDirections(directionCount)
            possibleDirections(directionCount) = eHeading.SOUTH
            directionCount = directionCount + 1
        End If

        If Pos.Y > Target.Y Then
            ReDim Preserve possibleDirections(directionCount)
            possibleDirections(directionCount) = eHeading.NORTH
            directionCount = directionCount + 1
        End If

        If directionCount > 0 Then
            ' Seleccionar aleatoriamente una dirección entre las posibles
            Dim randomIndex As Integer

            randomIndex = Int((directionCount - 1) * Rnd)
            If randomIndex = 0 Then randomIndex = RandomNumber(0, directionCount - 1)
            FindDirection = possibleDirections(randomIndex)
        Else
            ' No hay ninguna dirección válida, mantener la dirección actual o manejar según tu lógica
            FindDirection = 0
        End If
    End If
End Function

Public Function ObjEsRobable(ByRef objeto As ObjData) As Boolean

    If objeto.OBJType <> eOBJType.otLlaves And objeto.Caos = 0 And objeto.Real = 0 And objeto.OBJType <> eOBJType.otBarcos Then
        ObjEsRobable = True
        Exit Function
    End If

End Function


Public Function ItemNoEsDeMapa(ByVal Index As Integer, ByVal bIsExit As Boolean) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With ObjData(Index)
        ItemNoEsDeMapa = .OBJType <> eOBJType.otPuertas And _
                         .OBJType <> eOBJType.otCarteles And _
                         .OBJType <> eOBJType.otArboles And _
                         .OBJType <> eOBJType.otYacimiento And _
                         Not (.OBJType = eOBJType.otTeleport And bIsExit)

    End With

End Function

Public Function MostrarCantidad(ByVal Index As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With ObjData(Index)
        MostrarCantidad = .OBJType <> eOBJType.otPuertas And _
                          .OBJType <> eOBJType.otCarteles And _
                          .OBJType <> eOBJType.otArboles And _
                          .OBJType <> eOBJType.otYacimiento And _
                          .OBJType <> eOBJType.otTeleport
    End With

End Function

Public Function EsObjetoFijo(ByVal OBJType As eOBJType) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    EsObjetoFijo = OBJType = eOBJType.otCarteles Or _
                   OBJType = eOBJType.otArboles Or _
                   OBJType = eOBJType.otYacimiento
End Function


Public Function SDesencriptar(ByVal Cadena As String, ByVal nick As String) As String

    On Error Resume Next

1   If Len(Cadena) < 1 Then Exit Function
2   Dim i As Long, NumDesencriptar As String
    Dim origCadena As String

    origCadena = Cadena

3   NumDesencriptar = Chr$(Asc(Left$((Right(Cadena, 2)), 1)) - 10) & Chr$(Asc(Right$((Right(Cadena, 2)), 1)) - 10)
4   Cadena = (Left$(Cadena, Len(Cadena) - 2))

5   For i = 1 To Len(Cadena)
6       Mid$(Cadena, i, 1) = Chr$(Asc(val(mid$(Cadena, i, 1)) - NumDesencriptar))

7   Next i

8   SDesencriptar = Cadena


Errhandler:
    If Not Err.Number = 0 Then
        Call LogError("error en SDesencriptar en " & Erl & ". CADENA: " & Cadena & " !! OrigCadena: " & origCadena & " !! Err: " & Err.Number & " " & Err.Description & " - Nick: " & nick)
    End If

End Function


Public Function CheckMaxClients(ByVal UserIndex As Integer, ByVal Name As String) As Boolean

    Dim i As Long
    Dim iCount As Integer
    Dim wCount As Integer
    Dim wPCCount As Integer
    Dim userClass As Byte

    With UserList(UserIndex)
        userClass = val(GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Clase"))
        If userClass = eClass.Blacksmith Or userClass = eClass.Carpenter Or userClass = eClass.Fisherman Or userClass = eClass.Miner Or userClass = eClass.Woodcutter Then
            wPCCount = 1    'El personaje que logea es trabajador.
        End If

        For i = 1 To LastUser
            '@ ¿Tienen el mismo serial?
            If .flags.serialHD = UserList(i).flags.serialHD Then
                If StrComp(UCase$(.Name), UCase$(UserList(i).Name)) <> 0 And Len(UserList(i).Name) > 0 Then
                    iCount = iCount + 1
                    userClass = UserList(i).Clase
                    If userClass = eClass.Blacksmith Or userClass = eClass.Carpenter Or userClass = eClass.Fisherman Or userClass = eClass.Miner Or userClass = eClass.Woodcutter Then
                        wPCCount = wPCCount + 1
                    End If
                End If
            End If

            '@ Tienen la misma IP?
            If MaxWorkersPerIP > 0 Then
                If UserList(i).flags.UserLogged And (userClass = eClass.Blacksmith Or userClass = eClass.Carpenter Or userClass = eClass.Fisherman Or userClass = eClass.Miner Or userClass = eClass.Woodcutter) Then
                    If StrComp(.IP, UserList(i).IP) = 0 Then
                        wCount = wCount + 1
                    End If
                End If

                If wCount >= MaxWorkersPerIP Then
                    Call WriteErrorMsg(UserIndex, "No es posible usar más de un personaje trabajador al mismo tiempo.")
                    Exit Function
                End If
            End If

            If MaxWorkersPerPC > 0 Then
                If wPCCount > MaxWorkersPerPC Then
                    Call WriteErrorMsg(UserIndex, "No es posible usar más de un personaje trabajador al mismo tiempo.")
                    Exit Function
                End If
            End If

            If iCount >= MaxClientPerSerial Then
                Call WriteErrorMsg(UserIndex, "No es posible usar más de " & MaxClientPerSerial & " personaje al mismo tiempo.")
                Exit Function
            End If
        Next i
    End With

    CheckMaxClients = True

End Function


Public Function CharIndexToUserIndex(ByVal CharIndex As Integer) As Integer
    CharIndexToUserIndex = CharList(CharIndex)

    If CharIndexToUserIndex < 1 Or CharIndexToUserIndex > maxUsers Then
        CharIndexToUserIndex = INVALID_INDEX
        Exit Function
    End If

    If UserList(CharIndexToUserIndex).Char.CharIndex <> CharIndex Then
        CharIndexToUserIndex = INVALID_INDEX
        Exit Function
    End If
End Function

Public Sub AutoCurar(ByVal UserIndex As Integer)

'  @@ Función del Sacerdote.

    With UserList(UserIndex)

        If .flags.Envenenado = 1 Then
            .flags.Envenenado = 0
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_160)        'Te has curado del envenenamiento.
        End If
        Call WriteUpdateEnvenenado(UserIndex)

        If .flags.Muerto = 1 Then
            Call RevivirUsuario(UserIndex)
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_296)        '"¡¡Has sido resucitado!!"
        End If

    End With

End Sub

Public Function EsMineral(ObjIndex As Integer) As Boolean
    If ObjIndex = eOBJType.otMinerales Then
        EsMineral = True
        Exit Function
    End If
    EsMineral = False
End Function

Public Sub ReplaceInvalidChars(ByRef s As String)
    If InStrB(s, Chr$(13)) <> 0 Then
        s = Replace(s, Chr$(13), vbNullString)
    End If
    If InStrB(s, Chr$(10)) <> 0 Then
        s = Replace(s, Chr$(10), vbNullString)
    End If
    If InStrB(s, "¬") <> 0 Then
        s = Replace(s, "¬", vbNullString)        'morgo usaba esto como "separador"
    End If
End Sub

Public Function segundosAHoras(segundos As Long) As String

    Dim horas As Integer
    Dim Minutos As Byte

    horas = segundos \ 3600
    Minutos = ((segundos Mod 3600) \ 60)

    If horas = 1 Then
        segundosAHoras = segundosAHoras & "una hora"
    ElseIf horas > 1 Then
        segundosAHoras = segundosAHoras & horas & " horas"
    End If

    If Minutos > 0 Then

        If horas > 0 Then segundosAHoras = segundosAHoras & " y "

        If Minutos = 1 Then
            segundosAHoras = segundosAHoras & "un minuto"
        Else
            segundosAHoras = segundosAHoras & Minutos & " minutos"
        End If

    ElseIf Minutos = 0 And horas = 0 Then
        segundosAHoras = segundosAHoras & "0 minutos"
    End If

End Function

Function timePHP() As Long
    'Esta funcion es como el time() del php
    timePHP = DateDiff("s", "01/01/1970 00:00:00", Now, vbMonday, vbFirstFullWeek)
End Function

Function StrToPosition(ByVal Position As String) As Position
    'str("X-Y") to struct
    StrToPosition.X = val(ReadField(1, Position, 45))
    StrToPosition.Y = val(ReadField(2, Position, 45))
End Function

Function PositionToStr(ByRef Position As Position) As String
    'struct to str("X-Y")
    PositionToStr = Position.X & "-" & Position.Y
End Function



Function StrToWorldPos(ByVal Position As String) As WorldPos
    'str("MAP-X-Y") to struct
    StrToWorldPos.Map = val(ReadField(1, Position, 45))
    StrToWorldPos.X = val(ReadField(2, Position, 45))
    StrToWorldPos.Y = val(ReadField(3, Position, 45))
End Function

Function WorldPosToStr(ByRef Position As WorldPos) As String
    'struct to str("MAP-X-Y")
    WorldPosToStr = Position.Map & "-" & Position.X & "-" & Position.Y
End Function
